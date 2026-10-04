def _find_media_paths [...paths: string] {
    let ext_pattern = '\.(mp4|mov|webm|vid)$'
    # 如果没有指定路径，则默认使用当前目录
    let files = if ($paths | is-empty) {
        ls . | where name =~ $ext_pattern
    } else {  # 如果指定了路径，则迭代查找这些路径下的文件
        $paths | each {|p|
            let expanded = ($p | path expand)
            ls $expanded | where name =~ $ext_pattern
        } | flatten
    }
    return $files
}

def _find_image_paths [...paths: string] {
    let ext_pattern = '\.(jpg|jpeg|png|bmp|tiff|webp|heic)$'
    # 如果没有指定路径，则默认使用当前目录
    let files = if ($paths | is-empty) {
        ls . | where name =~ $ext_pattern
    } else {  # 如果指定了路径，则迭代查找这些路径下的文件
        $paths | each {|p|
            let expanded = ($p | path expand)
            ls $expanded | where name =~ $ext_pattern
        } | flatten
    }
    return $files
}

def _format_duration [seconds: string] {
    let sec = ($seconds | into int)
    let hours = ($sec / 3600 | into int)  # 计算小时数
    let minutes = (($sec mod 3600) / 60 | into int)  # 计算分钟数
    let seconds = ($sec mod 60)  # 计算剩余秒数

    mut result = []
    # 只有当值大于0时才添加到结果中
    if $hours > 0 { $result = ($result | append $'($hours)h') }
    if $minutes > 0 { $result = ($result | append $'($minutes)m') }
    if $seconds > 0 { $result = ($result | append $'($seconds | math round -p 2)s') }

    $result | str join ' '  # 用空格连接各部分
}

def _format_bitrate [bitrate: int] {
    # 将比特率转换为合适的单位
    if $bitrate >= 1000000 {
        let mbps = ($bitrate / 1000000.0 | math round -p 1)
        $'($mbps) Mbps'
    } else if $bitrate >= 1000 {
        let kbps = ($bitrate / 1000.0 | math round -p 1)
        $'($kbps) kbps'
    } else {
        $'($bitrate) bps'
    }
}

def _get_video_info [file: string] {
    # 使用 ffprobe 获取视频流和格式信息
    let ffprobe_output = (ffprobe -v error -select_streams v:0
        -show_entries stream=codec_name,width,height,bit_rate:format=duration,bit_rate
        -of json $file | from json)

    let stream = ($ffprobe_output.streams | first)  # 获取第一个视频流
    let format = ($ffprobe_output.format)  # 获取格式信息

    # 格式化时长，如果失败则显示 N/A
    let duration = try {
      _format_duration $format.duration
    } catch {
      "N/A"
    }

    # 格式化比特率，优先使用流的比特率，其次使用格式的比特率
    let bitrate = try {
      let rate = if ($stream.bit_rate | is-not-empty) {
        $stream.bit_rate | into int
      } else if ($format.bit_rate | is-not-empty) {
        $format.bit_rate | into int
      } else {
        null
      }

      if ($rate | is-not-empty) {
        _format_bitrate $rate
      } else {
        "N/A"
      }
    } catch {
      "N/A"
    }

    # 返回视频信息结构
    return {
        codec: ($stream.codec_name)
        width: ($stream.width)
        height: ($stream.height)
        duration: $duration
        bitrate: $bitrate
    }
}

@example "Display video info analysis results of all video files in a directory" {vcodec-analysis ./20250706_115938.mp4 ~/OneDrive/Movie/11.mp4} --result """
╭──────┬─────────────────────────────────────────────────────────────────────────────────╮
│      │ ╭───┬─────────────────────┬───────┬────────────┬──────────┬─────────┬─────────╮ │
│ hevc │ │ # │        file         │ codec │ resolution │ duration │  size   │ bitrate │ │
│      │ ├───┼─────────────────────┼───────┼────────────┼──────────┼─────────┼─────────┤ │
│      │ │ 0 │ 20250706_115938.mp4 │ hevc  │ 1920x1080  │ 4.0s     │ 12.0 MB │ 2.0 Mbps│ │
│      │ ╰───┴─────────────────────┴───────┴────────────┴──────────┴─────────┴─────────╯ │
│      │ ╭───┬────────┬───────┬────────────┬───────────┬──────────┬─────────╮            │
│ h264 │ │ # │  file  │ codec │ resolution │ duration  │   size   │ bitrate │            │
│      │ ├───┼────────┼───────┼────────────┼───────────┼──────────┼─────────┤            │
│      │ │ 0 │ 11.mp4 │ h264  │ 1920x1080  │ 29m 42.0s │ 786.5 MB │ 3.7 Mbps│            │
│      │ ╰───┴────────┴───────┴────────────┴───────────┴──────────┴─────────╯            │
╰──────┴─────────────────────────────────────────────────────────────────────────────────╯
"""
def vcodec-analysis [...paths: string] {
    let files = (_find_media_paths ...$paths)
    # 并行执行 _get_video_info 获取信息
    $files | par-each {|file|
        let video_info = (_get_video_info $file.name)
        {
            file: ($file.name | path basename)
            codec: $video_info.codec
            resolution: $'($video_info.width)x($video_info.height)'
            duration: $video_info.duration
            size: $file.size
            bitrate: $video_info.bitrate
        }
    }
    | group-by codec  # 按编解码器类型分组
}

alias va = vcodec-analysis

@example "Transcode a video file to a different codec, e.g. convert test.mp4's encoding format to vp9" {transcode test.mp4 "libvpx-vp9"} --result "This will convert test.mp4 to VP9 format and save it to ~/Downloads/ffmpeg_out/test.webm"
def transcode [input_file: string codec: string ext: string = "webm"] {
  let output_dir = $nu.home-dir| path join "Downloads/ffmpeg_out"
  mkdir $output_dir
  let base = ($input_file | path parse | get stem)  # 获取不带扩展名的文件名
  let output_file = ($output_dir | path join $"($base).($ext)")  # 构造输出文件路径

  # -c:v/vcodec 视频编码器; -q:v/crf 设置视频质量; -b:v 视频比特率
  # -c:a 音频编码器
  let codec_args = if $codec == "hevc_videotoolbox" {
    ["-c:v" $codec "-q:v" "65" "-tag:v" "hvc1" "-c:a" "copy"]
  } else if $codec == "libsvtav1" {
    ["-c:v" $codec]
  } else {
    ["-vcodec" $codec]
  }

  # 执行转码
  ffmpeg -hide_banner -i $input_file ...$codec_args $output_file
}

# TODO 这里其实可以优化一下，只处理非vp9编码的视频
def vp9 [...input_file: string] {
  let input_files  = (_find_media_paths ...$input_file)
  $input_files | par-each {|file|
    print $"Processing: ($file.name)";
    transcode $file.name "libvpx-vp9";
  }
}

def hevc [...input_file: string] {
  let input_files = (_find_media_paths ...$input_file)
  # 如果是mac，使用hevc_videotoolbox
  let encoder = if $nu.os-info.name == "macos" {
    "hevc_videotoolbox"
  } else {
    "libx265"
  }
  $input_files | par-each {|file|
    print $"Processing: ($file.name)";
    transcode $file.name $encoder "mp4";
  }
}

# AV1压缩率要更好，但个人使用AV1编码速度还是慢于VP9
def av1 [...input_file: string] {
  let input_files  = (_find_media_paths ...$input_file)
  $input_files | par-each {|file|
    print $"Processing: ($file.name)";
    transcode $file.name "libsvtav1";
  }
}

# 把图片转为AVIF格式
def avif [...input_file: string] {
  let input_files = (_find_image_paths ...$input_file)

  $input_files | par-each {|file|
    print $"Processing: ($file.name)";

    let parsed = $file.name | path parse
    let parent_dir = $parsed | get parent
    let stem = $parsed | get stem

    let output_file = ($parent_dir | path join $"($stem).avif")

    # 使用 libsvtav1 编码器转换图片为 AVIF 格式
    # -c:v libsvtav1: 使用 SVT-AV1 编码器
    # -crf 23: 设置质量参数，23是较好的质量平衡点
    # -preset 6: 编码预设，6是速度和质量的平衡
    ffmpeg -hide_banner -i $file.name -c:v libsvtav1 -crf 23 -preset 6 $output_file
  }
}

# 睡前压一下视频，macos使用caffeinate避免睡眠
alias vp9-night = caffeinate -i nu --config $nu.config-path -c "vp9 ./"
alias hevc-night = caffeinate -i nu --config $nu.config-path -c "hevc ./"
alias av1-night = caffeinate -i nu --config $nu.config-path -c "av1 ./"

def show_ffmpeg_tasks [] {
  ps --long | where name has "ffmpeg"
}

def trans_diff [input_file: string] {
  let output_file = $"~/Downloads/ffmpeg_out/($input_file | path parse | get stem).webm"

  # 检查输出文件是否存在
  let output_path = ($output_file | path expand)
  if not ($output_path | path exists) {
    print $"❌ 输出文件不存在: ($output_path)"
    return
  }

  # 获取文件大小
  let input_size = (ls $input_file | get size | first)
  let output_size = (ls $output_path | get size | first)
  let saved_size = ($input_size - $output_size)
  let size_ratio = (($output_size / $input_size) * 100 | math round -p 2)

  # 显示分析结果
  let analysis_result = (va $input_file $output_path)
  # 展开显示每个编解码器组的详细信息
  $analysis_result | transpose codec data | each { |row|
    print $"\n🎥 ($row.codec) 编解码器:"
    print ($row.data)
  }

  # 打印节省的大小信息
  print $"\n💾 文件大小对比:"
  print $"💰 节省: ($saved_size)"
  print $"📊 转码后/原文件: ($size_ratio)%\n"
}

alias td = trans_diff

# 把当前文件用 ~/Downloads/ffmpeg_out/{file_basename}.webm 替换
def replace_file [file_name: string] {
  let output_file = $"~/Downloads/ffmpeg_out/($file_name | path parse | get stem).webm"
  let output_path = ($output_file | path expand)

  if not ($output_path | path exists) {
    print $"❌ 输出文件不存在: ($output_path)"
    return
  }

  rm $file_name
  mv $output_path ./
  print $"✅ 已替换文件: ($file_name)"
}

alias rf = replace_file
