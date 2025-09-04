def _find_media_paths [...paths: string] {
    let ext_pattern = '\.(mp4|webm)$'
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

def _get_video_info [file: string] {
    # 使用 ffprobe 获取视频流和格式信息
    let ffprobe_output = (ffprobe -v error -select_streams v:0
        -show_entries stream=codec_name,width,height:format=duration
        -of json $file | from json)

    let stream = ($ffprobe_output.streams | first)  # 获取第一个视频流
    let format = ($ffprobe_output.format)  # 获取格式信息

    # 格式化时长，如果失败则显示 N/A
    let duration = try {
      _format_duration $format.duration
    } catch {
      "N/A"
    }

    # 返回视频信息结构
    return {
        codec: ($stream.codec_name)
        width: ($stream.width)
        height: ($stream.height)
        duration: $duration
    }
}

@example "Display video info analysis results of all video files in a directory" {vcodec-analysis ./20250706_115938.mp4 ~/OneDrive/Movie/11.mp4} --result """
╭──────┬───────────────────────────────────────────────────────────────────────╮
│      │ ╭───┬─────────────────────┬───────┬────────────┬──────────┬─────────╮ │
│ hevc │ │ # │        file         │ codec │ resolution │ duration │  size   │ │
│      │ ├───┼─────────────────────┼───────┼────────────┼──────────┼─────────┤ │
│      │ │ 0 │ 20250706_115938.mp4 │ hevc  │ 1920x1080  │ 4.0s     │ 12.0 MB │ │
│      │ ╰───┴─────────────────────┴───────┴────────────┴──────────┴─────────╯ │
│      │ ╭───┬────────┬───────┬────────────┬───────────┬──────────╮            │
│ h264 │ │ # │  file  │ codec │ resolution │ duration  │   size   │            │
│      │ ├───┼────────┼───────┼────────────┼───────────┼──────────┤            │
│      │ │ 0 │ 11.mp4 │ h264  │ 1920x1080  │ 29m 42.0s │ 786.5 MB │            │
│      │ ╰───┴────────┴───────┴────────────┴───────────┴──────────╯            │
╰──────┴───────────────────────────────────────────────────────────────────────╯
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
        }
    }
    | group-by codec  # 按编解码器类型分组
}

alias va = vcodec-analysis

@example "Transcode a video file to a different codec, e.g. convert test.mp4's encoding format to vp9" {transcode test.mp4 "libvpx-vp9"} --result "This will convert test.mp4 to VP9 format and save it to ~/Downloads/ffmpeg_out/test.webm"
def transcode [input_file: string codec: string ext: string = "webm"] {
  let output_dir = $nu.home-path | path join "Downloads/ffmpeg_out"
  mkdir $output_dir
  let base = ($input_file | path parse | get stem)  # 获取不带扩展名的文件名
  let output_file = ($output_dir | path join $"($base).($ext)")  # 构造输出文件路径
  ffmpeg -i $input_file -vcodec $codec $output_file  # 执行转码
}

# TODO 这里其实可以优化一下，只处理非vp9编码的视频
def vp9 [...input_file: string] {
  let input_files  = (_find_media_paths ...$input_file)
  $input_files | par-each {|file|
    print $"Processing: ($file.name)";
    transcode $file.name "libvpx-vp9";
  }
}

# 睡前压一下视频，macos使用caffeinate避免睡眠
alias vp9-night = caffeinate -i nu --config $nu.config-path -c "vp9 ./"

# AV1压缩率要更好，但个人使用AV1编码速度还是慢于VP9
def av1 [...input_file: string] {
  let input_files  = (_find_media_paths ...$input_file)
  $input_files | par-each {|file|
    print $"Processing: ($file.name)";
    transcode $file.name "libaom-av1";
  }
}

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

  mv $output_path $file_name
  print $"✅ 已替换文件: ($file_name)"
}
