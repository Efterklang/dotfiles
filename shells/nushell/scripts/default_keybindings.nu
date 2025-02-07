$env.config.keybindings = (
    $env.config.keybindings
    | append {
        name: completion_menu
        modifier: control
        keycode: char_n
        mode: [emacs vi_normal vi_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menunext }
                { edit: complete }
            ]
        }
    }
    | append {
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
    | append {
        name: undo_or_previous_page_menu
        modifier: control
        keycode: char_z
        mode: emacs
        event: {
            until: [   
                { send: menupageprevious }
                { edit: undo }
            ]
        }
    }
    | append {
        name: escape
        modifier: none
        keycode: escape
        mode: [emacs, vi_normal, vi_insert]
        event: { send: esc }    # NOTE: does not appear to work
    }
    | append {
        name: quit_shell
        modifier: control
        keycode: char_d
        mode: [emacs, vi_normal, vi_insert]
        event: { send: ctrld }
    }
    | append {
        name: clear_screen
        modifier: control
        keycode: char_l
        mode: [emacs, vi_normal, vi_insert]
        event: [{ send: clearscreen },{ send: clearscrollback }]
    }
    | append {
        name: move_up
        modifier: none
        keycode: up
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: menuup }
                { send: up }
            ]
        }
    }
    | append {
        name: move_down
        modifier: none
        keycode: down
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: menudown }
                { send: down }
            ]
        }
    }
    | append {
        name: move_left
        modifier: none
        keycode: left
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: menuleft }
                { send: left }
            ]
        }
    }
    | append {
        name: move_right_or_take_history_hint
        modifier: none
        keycode: right
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: historyhintcomplete }
                { send: menuright }
                { send: right }
            ]
        }
    }
    | append {
        name: move_one_word_left
        modifier: control
        keycode: left
        mode: [emacs, vi_normal, vi_insert]
        event: { edit: movewordleft }
    }
    | append {
        name: move_one_word_right_or_take_history_hint
        modifier: control
        keycode: right
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: historyhintwordcomplete }
                { edit: movewordright }
            ]
        }
    }
    | append {
        name: move_to_line_start
        modifier: none
        keycode: home
        mode: [emacs, vi_normal, vi_insert]
        event: { edit: movetolinestart }
    }
    | append {
        name: move_to_line_end_or_take_history_hint
        modifier: none
        keycode: end
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: historyhintcomplete }
                { edit: movetolineend }
            ]
        }
    }
    | append {
        name: move_to_line_end_or_take_history_hint
        modifier: control
        keycode: char_e
        mode: [emacs, vi_normal, vi_insert]
        event: {
            until: [
                { send: historyhintcomplete }
                { edit: movetolineend }
            ]
        }
    }
    | append {
        name: delete_one_character_backward
        modifier: none
        keycode: backspace
        mode: [emacs, vi_insert]
        event: { edit: backspace }
    }
    | append {
        name: delete_one_word_backward
        modifier: control
        keycode: backspace
        mode: [emacs, vi_insert]
        event: { edit: backspaceword }
    }
    | append {
        name: delete_one_character_forward
        modifier: none
        keycode: delete
        mode: [emacs, vi_insert]
        event: { edit: delete }
    }
    | append {
        name: delete_one_character_forward
        modifier: control
        keycode: delete
        mode: [emacs, vi_insert]
        event: { edit: delete }
    }
    | append {
        name: delete_one_word_backward
        modifier: control
        keycode: char_w
        mode: [emacs, vi_insert]
        event: { edit: backspaceword }
    }
    | append {
        name: move_left
        modifier: none
        keycode: backspace
        mode: vi_normal
        event: { edit: moveleft }
    }
    | append {
        name: newline_or_run_command
        modifier: none
        keycode: enter
        mode: emacs
        event: { send: enter }
    }
    | append {
        name: undo_change
        modifier: control
        keycode: char_z
        mode: emacs
        event: { edit: undo }
    }
    | append {
        name: paste_before
        modifier: control
        keycode: char_v
        mode: emacs
        event: { edit: pastecutbufferbefore }
    }
    | append {
        name: cut_line_to_end
        modifier: control
        keycode: char_k
        mode: emacs
        event: { edit: cuttoend }
    }
    | append {
        name: cut_line_from_start
        modifier: control
        keycode: char_u
        mode: emacs
        event: { edit: cutfromstart }
    }
    | append {
        name: move_to_head
        modifier: control
        keycode: char_a
        mode: emacs
        event: { edit: movetolinestart }
    }
    | append {
        name: move_to_end
        modifier: alt
        keycode: right
        mode: emacs
        event: { edit: movetolineend }
    }
    | append {
        name: delete_one_word_forward
        modifier: alt
        keycode: delete
        mode: emacs
        event: { edit: deleteword }
    }
    | append {
        name: delete_one_word_backward
        modifier: alt
        keycode: backspace
        mode: emacs
        event: { edit: backspaceword }
    }
    | append {
        name: delete_one_word_backward
        modifier: alt
        keycode: char_m
        mode: emacs
        event: { edit: backspaceword }
    }
    | append {
        name: cut_word_to_right
        modifier: alt
        keycode: char_d
        mode: emacs
        event: { edit: cutwordright }
    }
    | append {
        name: upper_case_word
        modifier: alt
        keycode: char_u
        mode: emacs
        event: { edit: uppercaseword }
    }
    | append {
        name: lower_case_word
        modifier: alt
        keycode: char_l
        mode: emacs
        event: { edit: lowercaseword }
    }
    | append {
        name: capitalize_char
        modifier: alt
        keycode: char_c
        mode: emacs
        event: { edit: capitalizechar }
    }
    # The following bindings with `*system` events require that Nushell has
    # been compiled with the `system-clipboard` feature.
    # This should be the case for Windows, macOS, and most Linux distributions
    # Not available for example on Android (termux)
    # If you want to use the system clipboard for visual selection or to
    # paste directly, uncomment the respective lines and replace the version
    # using the internal clipboard.
    | append {
        name: copy_selection
        modifier: control
        keycode: char_c
        mode: [emacs, vi_normal, vi_insert]
        event: { edit: copyselection }
        # event: { edit: copyselectionsystem }
    }
    | append {
        name: cut_selection
        modifier: control
        keycode: char_x
        mode: emacs
        event: { edit: cutselection }
    }
)
