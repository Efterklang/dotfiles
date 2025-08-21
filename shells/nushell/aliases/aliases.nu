source ./git.nu
source ./replace.nu

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

alias a = gh copilot suggest
alias b = bun run
alias c = code
alias d = dust
alias e = exit 0
alias f = fastfetch
alias g = lazygit --use-config-dir ~/.config/lazygit
alias h = bun run hexo s
alias i = gemini
alias j = commandline edit --insert (fd --type directory | fzf --preview 'eza --all --git --long --no-time --color=always --icons {}')
alias k = commandline edit --insert (zellij delete-all-sessions -y; zellij kill-all-sessions -y)
alias l = clear
alias m = nvim (tv --source-command "fd -e md ." files)
# n
alias o = open
alias p = gping
# q
alias r = commandline edit --insert (bat --color never --style plain $nu.history-path | fzf --height 70% --layout reverse --tac | str trim)
alias s = somo
alias t = tokei
alias u = uv
alias v = nvim (tv files)
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
# Jump directory
alias music = cd ~/OneDrive/Music
alias vluv = cd ~/Projects/vluv
alias wiki = cd ~/Projects/astro-docs
