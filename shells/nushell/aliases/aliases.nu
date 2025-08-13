source ./git.nu
source ./replace.nu

def --env pwd [] {
    $env.PWD | str replace --all '\' '/'
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

def fzfp [] {
    fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
}

const tablen = 8

# calculate required tabs/spaces to get a nicely aligned table
def pad-tabs [input_name max_indent] {
    let input_length = ($input_name | str length)
    let required_tabs = $max_indent - ($input_length / $tablen | into int)
    seq 0 $required_tabs | reduce -f "" {|it, acc| $acc + (char tab)}
}

def fuzzy-command-search [] {
    let max_len = (help commands | each { $in.name | str length } | math max)
    let max_indent = ($max_len / $tablen | into int)
    let command = ((help commands | each {|it|
        let name = ($it.name | str trim | ansi strip)
        $"($name)(pad-tabs $name $max_indent)($it.description)"
    }) | str join (char nl) | fzf --layout reverse --style full -e | split column (char tab) | get column1.0)
    if ($command | is-not-empty) {
        help $command
    }
}

def cprv [input_file: string] {
  let base = ($input_file | path parse | get stem)
  let output_file = $"($base).webm"
  ffmpeg -i $input_file -vcodec libvpx-vp9 $output_file
}

def trim_history [] {
	let history = $nu.history-path
	open $history | lines | uniq | save -f $history
}

alias a = gh copilot suggest
alias b = bun run
alias c = code
alias d = dust
alias e = exit 0 
alias f = commandline edit --insert (fzf --layout=reverse --preview 'bat {}')
alias g = lazygit
alias h = bun run hexo s
alias i = gemini
alias j = commandline edit --insert (fd --type directory | fzf --preview 'eza --all --git --long --no-time --color=always --icons {}')
alias k = commandline edit --insert (zellij delete-all-sessions -y; zellij kill-all-sessions -y)
alias l = clear
# m n
alias o = open
alias p = gping
# q
alias r = commandline edit --insert (bat --color never --style plain $nu.history-path | fzf --height 70% --layout reverse --tac | str trim)
alias s = somo
alias t = tokei
alias u = uv
alias v = vim
alias w = wsl
alias x = ~/.local/bin/extract
alias y = yazi
alias z = z
alias ze = zellij attach --create gnix
alias c2p = code2prompt
alias ci = code
alias czg = bun run czg
alias ff = fastfetch
alias gg = gitui
alias hexo = bun run hexo
alias hf = fuzzy-command-search
alias pyenv = overlay use .venv/bin/activate.nu
alias scene = adb shell sh /storage/emulated/0/Android/data/com.omarea.vtools/up.sh
alias shizuku = adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
alias zhelp = zoxide --help
alias zo = zoxide
