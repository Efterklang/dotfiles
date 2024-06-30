$env.config.keybindings = (
    $env.config.keybindings
    | append {  # history_menu using fzf
        name: fzf_history_menu_fzf_ui
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: { 
            send: executehostcommand
            cmd: "commandline edit --insert (open -r $nu.history-path | fzf --height 40% --layout reverse --border +s --tac | str trim)"
        }
    }
    | append {
        name: fuzzy_file
        modifier: control
        keycode: char_t
        mode: emacs
        event: {
        send: executehostcommand
        cmd: "commandline edit --insert (fzf --layout=reverse)"
        }
    }
)