source ./default.nu

$env.config.keybindings = (
    $env.config.keybindings
    | append {  # history_menu using fzf
        name: fzf_history_menu_fzf_ui
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: { 
            send: executehostcommand
            cmd: "commandline edit --insert (cat $nu.history-path | fzf --height 70% --layout reverse --style full --tac | str trim)"
        }
    }
    | append {
        name: fuzzy_file
        modifier: control
        keycode: char_t
        mode: emacs
        event: {
        send: executehostcommand
        cmd: "commandline edit --insert (fzf --layout=reverse --preview 'bat --color=always --style=numbers --line-range=:500 {}')"
        }
    }
    | append {
        name: fuzzy_command
        modifier: control
        keycode: char_h
        mode: emacs
        event: {
        send: executehostcommand
        cmd: "fuzzy-command-search"
        }
    }
)
