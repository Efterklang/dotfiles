def generate_subtitle [movie_file_path:string ] {
  whisper $movie_file_path --model medium --language English --output_format srt
}
