# kitty-specific setup.
# Sourced unconditionally: `source`/`alias` are parse-time, but $env.TERM is
# only known at runtime, so the kitty check must live inside a runtime `def`.

# Under kitty, route `rg` through the hyperlinked-grep kitten (clickable hits);
# otherwise fall back to the real ripgrep.
def --wrapped rg [...rest] {
  if ($env.TERM? == "xterm-kitty") {
    kitten hyperlinked-grep ...$rest
  } else {
    ^rg ...$rest
  }
}

alias vcat = mpv --vo=kitty
