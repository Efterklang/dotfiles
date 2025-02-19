source ./eza.nu
source ./git.nu

def --env pwd [] {
    $env.PWD | str replace --all '\' '/'
}

def --env yy [...args] {
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

def killf [] {
    kill -f (ps | each {|i| $i | to json --raw} | str join "\n" | fzf --height 60% --layout reverse --border +s --tac | str trim | from json | get pid)
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

alias ci = code
alias zhelp = zoxide --help
alias zo = zoxide
alias vim = nvim
alias cat = bat
alias cd = z
alias curl = curlie
alias grep = rg
alias ff = fastfetch
alias wez = wezterm
alias top = btop
alias lzd = lazydocker
alias gg = gitui
alias yy = yazi
alias dig = doggo
alias c2p = code2prompt
alias ps = procs
alias msql = mysqld --standalone
alias psql = pg_ctl start
alias czg = bun run czg
alias hexo = bun run hexo
alias shizuku = adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh 
alias scene = adb shell sh /storage/emulated/0/Android/data/com.omarea.vtools/up.sh
alias g = lazygit
alias pyenv = overlay use .venv/bin/activate.nu
alias hf = fuzzy-command-search
