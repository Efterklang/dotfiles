$env.config.keybindings = [
    {
        name: completion_menu
        modifier: control
        keycode: char_i
        mode: [emacs, vi_normal, vi_insert]
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
        mode: [emacs, vi_normal, vi_insert]
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
    {
        name: tv_folder
        modifier: control
        keycode: char_f
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "cd (tv zoxide)"
        }
    } 
]
