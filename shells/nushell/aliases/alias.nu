source ./git.nu
source ./replace.nu
source ./ffmpeg.nu
source ./obsidian.nu
source ./mpd.nu
source ./bun.nu

def --env y [...args] {
  let tmp = (mktemp -t "yazi-cwd.XXXXXX")
  yazi ...$args --cwd-file $tmp
  let cwd = (open $tmp)
  if $cwd != "" and $cwd != $env.PWD {
    cd $cwd
  }
  rm -fp $tmp
}

def trim_history [] {
  let history = $nu.history-path
  open $history | lines | uniq | save -f $history
}

def copy_text [] {
  match $nu.os-info.name {
    "windows" => {
      # Windows 使用 clip 命令
      $in | ^clip
    }
    "macos" => {
      # macOS 使用 pbcopy 命令
      $in | ^pbcopy
    }
  }
}

alias clip = copy_text

def ob [vault="posts"] {
  start $"obsidian://open?vault=($vault)"
}

let editable_files: string = "fd -L --exclude \"*.{code,data,webm,mp4,mp3,png,avif,webp,jpg,jpeg}\""
# ===== alphabet =====
alias a = atuin
alias b = bun run
alias c = code (tv files --source-command $editable_files)
alias d = dust
alias e = exit 0
alias f = fastfetch
alias g = tv text
alias h = bun run hexo s
alias i = gemini
alias j = just
alias k = commandline edit --insert (zellij delete-all-sessions -y; zellij kill-all-sessions -y)
alias l = clear
alias m = start_mpd
alias n = exec nu
alias o = start
alias p = tmux popup -w 80% -h 80%
alias q = exit 0
alias r = rmpc
alias s = somo
alias t = tokei
alias u = uv
alias v = nvim (tv files --source-command $editable_files)
alias w = wsl
alias x = ~/.local/bin/extract
alias y = yazi
alias z = z

alias ffd = commandline edit --insert (fd --type directory | fzf --preview 'eza --all --git --long --no-time --color=always --icons {}')
alias ze = zellij attach --create gnix
alias c2p = code2prompt
alias ci = code
alias ff = fastfetch
alias gg = lazygit --use-config-dir ~/.config/lazygit
alias oc = opencode
alias lc = nvim leetcode.nvim
alias hexo = bun run hexo
alias pyenv = overlay use .venv/bin/activate.nu
alias scene = adb shell sh /storage/emulated/0/Android/data/com.omarea.vtools/up.sh
alias shizuku = adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
alias zo = zoxide
# Jump directory
alias music = yazi ~/OneDrive/Music
alias vluv = cd ~/Projects/vluv
alias wiki = cd ~/Projects/astro-docs
alias draft = nvim ~/.cache/temp.md
# kitty
alias icat = kitten icat
# edit
alias vr = nvim ./README.md
alias vp = nvim ./package.json
alias vj = nvim ./justfile
