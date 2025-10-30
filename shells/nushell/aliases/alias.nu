source ./git.nu
source ./replace.nu
source ./ffmpeg.nu
source ./obsidian.nu
source ./mpd.nu

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

# ===== diary ======
def today-diary [] {
  let diary_folder = $"($env.HOME)/Onedrive/Documents/diary"
  # 获取当前日期（年、月、日）
  let today = (date now)
  let year = ($today | format date "%Y")
  let month = ($today | format date "%-m")  # 不带前导零的月份（1-12）
  let date_str = ($today | format date "%Y-%m-%d")  # 文件名格式（带前导零）

  # 构建完整路径：日记根目录/年/月/年-月-日.md
  let diary_path = ($diary_folder | path join $year $month $"($date_str).md")
  return $diary_path
}

def --env edit-diary [...args] {
  cd (today-diary | path parse | get parent)
  nvim +15 +startinsert (today-diary)
}

let editable_files: string = "fd -L --exclude \"*.{code,data,webm,mp4,mp3,png,avif,webp,jpg,jpeg}\""
# ===== alphabet =====
alias a = gh copilot suggest
alias b = bun run
alias c = code (tv files --source-command $editable_files)
alias d = dust
alias e = exit 0
alias f = fastfetch
alias g = lazygit --use-config-dir ~/.config/lazygit
alias h = bun run hexo s
alias i = gemini
alias j = commandline edit --insert (fd --type directory | fzf --preview 'eza --all --git --long --no-time --color=always --icons {}')
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

alias ze = zellij attach --create gnix
alias c2p = code2prompt
alias ci = code
alias ff = fastfetch
alias gg = gitui
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
alias draft = nvim ~/.cahce/temp.md
