$env.config.keybindings = [
    {
        name: completion_menu
        modifier: control
        keycode: char_i
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menunext }
                { edit: complete }
            ]
        }
    }
    {
        name: ide_completion_menu
        modifier: none
        keycode: tab
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: ide_completion_menu }
                { send: menunext }
                { edit: complete }
            ]
        }
    }
    #  ╭───────────────────────────────────────────────────────╮
    #  │               Custom keybindings                      │
    #  ╰───────────────────────────────────────────────────────╯
    {  # history_menu using fzf
        name: fzf_history_menu_fzf_ui
        modifier: control
        keycode: char_r
        mode: [emacs, vi_normal, vi_insert]
        event: { 
            send: executehostcommand
            cmd: "commandline edit --insert (bat --color never --style plain $nu.history-path | fzf --height 70% --layout reverse --tac | str trim)"
        }
    }
    {
        name: fuzzy_file
        modifier: control
        keycode: char_t
        mode: emacs
        event: {
            send: executehostcommand
            cmd: "commandline edit --insert (fzf --layout=reverse --preview 'bat {}')"
        }    
    }
    {
        name: fuzzy_command
        modifier: control
        keycode: char_h
        mode: emacs
        event: {
            send: executehostcommand
            cmd: "fuzzy-command-search"
        }
    }
]
