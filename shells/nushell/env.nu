$env.PATH = (
  $env.PATH
  | split row (char esep)
  | uniq
  | prepend ["~/.local/bin"]
)

# nushell vi mode
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.GOOGLE_CLOUD_PROJECT = 'gen-lang-client-0006538526'
