# A helper function to get video codec information
def _get_codec [file: string] {
  return (
    ffprobe -v error -select_streams v:0
    -show_entries stream=codec_name
    -of default=noprint_wrappers=1:nokey=1
    $file | str trim
  )
}

def vcodec-analysis [path: string = "."] {
  ls $path | where name =~ '\.(mp4|webm)$' | each {|file|
    {
      file: $file.name
      codec: (_get_codec $file.name)
      size: $file.size
      modified: $file.modified
    }
  } | group-by codec
}

alias va = vcodec-analysis

# Encoding video
def transcode [input_file: string codec: string ext: string = "webm"] {
  let output_dir = $nu.home-path | path join "Downloads/ffmpeg_out"
  let base = ($input_file | path parse | get stem)
  let output_file = ($output_dir | path join $"($base).($ext)")
  ffmpeg -i $input_file -vcodec $codec $output_file
}

def vp9 [input_file: string] {
  transcode $input_file "libvpx-vp9"
}

def av1 [input_file: string] {
  transcode $input_file "libaom-av1"
}
