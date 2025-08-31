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

@example "Display video info analysis results of specific video file" {vcodec-analysis test.mp4} --result """
╭──────┬────────────────────────────────────────────────────────────────────────────╮
│      │ ╭───┬──────────┬───────┬────────────┬─────────────┬────────┬─────────────╮ │
│ h264 │ │ # │   file   │ codec │ resolution │  duration   │  size  │  modified   │ │
│      │ ├───┼──────────┼───────┼────────────┼─────────────┼────────┼─────────────┤ │
│      │ │ 0 │ test.mp4 │ h264  │ 1920x1080  │ 1h 13m 3.0s │ 2.0 GB │ 3 weeks ago │ │
│      │ ╰───┴──────────┴───────┴────────────┴─────────────┴────────┴─────────────╯ │
╰──────┴────────────────────────────────────────────────────────────────────────────╯
"""
@example "Display video info analysis results of all video files in a directory" {vcodec-analysis ~/Videos} --result """
╭──────┬──────────────────────────────────────────────────────────────────────────────────────╮
│      │ ╭───┬─────────────────────┬───────┬────────────┬──────────┬─────────┬──────────────╮ │
│ hevc │ │ # │        file         │ codec │ resolution │ duration │  size   │   modified   │ │
│      │ ├───┼─────────────────────┼───────┼────────────┼──────────┼─────────┼──────────────┤ │
│      │ │ 0 │ 20250706_115938.mp4 │ hevc  │ 1920x1080  │ 4.0s     │ 12.0 MB │ 2 months ago │ │
│      │ │ 1 │ 20250706_123722.mp4 │ hevc  │ 1920x1080  │ 4.0s     │ 13.4 MB │ 2 months ago │ │
│      │ ╰───┴─────────────────────┴───────┴────────────┴──────────┴─────────┴──────────────╯ │
╰──────┴──────────────────────────────────────────────────────────────────────────────────────╯
"""
def vcodec-analysis [path: string = "."] {
    # 查找所有 mp4 和 webm 文件，并行处理获取信息
    ls $path | where name =~ '\.(mp4|webm)$' | par-each {|file|
        let video_info = (_get_video_info $file.name)
        {
            file: $file.name
            codec: $video_info.codec
            resolution: $'($video_info.width)x($video_info.height)'
            duration: $video_info.duration
            size: $file.size
            modified: $file.modified
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

def vp9 [input_file: string] {
  transcode $input_file "libvpx-vp9"
}

def av1 [input_file: string] {
  transcode $input_file "libaom-av1"
}