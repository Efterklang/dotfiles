$env.config = {
    show_banner: false 

    ls: {
        use_ls_colors: true 
        clickable_links: true 
    }

    rm: {
        always_trash: true 
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    explore: {
        status_bar_background: { fg: "#11111b", bg: "#a4bce8" },
        command_bar_text: { fg: "#C4C9C6" },
        highlight: { fg: "black", bg: "yellow" },
        status: {
            error: { fg: "white", bg: "red" },
            warn: {}
            info: {}
        },
        table: {
            split_line: { fg: "#1e1e2e" },
            selected_cell: { bg: light_blue },
            selected_row: {},
            selected_column: {},
        },
    }

    history: {
        max_size: 5000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "plaintext" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {}

    cursor_shape: {
        emacs: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    footer_mode: "auto" # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: vi # emacs, vi
    shell_integration: {
        osc2: true
        osc7: true
        osc8: false
        osc9_9: true
        osc133: false 
        osc633: true
        reset_application_mode: true
    }
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
    highlight_resolved_externals: true # true enables highlighting of external commands in the repl resolved by which.
    recursion_limit: 50 # the maximum number of times nushell allows recursion before stopping it

    plugins: {} # Per-plugin configuration. See https://www.nushell.sh/contributor-book/plugins.html#configuration.

    plugin_gc: {
        # Configuration for plugin garbage collection
        default: {
            enabled: true # true to enable stopping of inactive plugins
            stop_after: 10sec # how long to wait after a plugin is inactive to stop it
        }
        plugins: {}
    }

    hooks: {
        pre_prompt: [{ null }] # run before the prompt is shown
        pre_execution: [{ null }] # run before the repl input is run
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
        command_not_found: { null } # return an error message when a command is not found
    }

    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "> "
            type: {
                layout: columnar
                columns: 4
                col_padding: 2
            }
            style: {
                text: "#a7b0eb"
                selected_text: { attr: r }
                description_text: red
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: ide_completion_menu
            only_buffer_difference: false
            marker: "> "
            type: {
                layout: ide
                min_completion_width: 0,
                max_completion_width: 70,
                max_completion_height: 20, # will be limited by the available lines in the terminal
                padding: 0,
                border: true,
                cursor_offset: 0,
                description_mode: "prefer_right"
                min_description_width: 0
                max_description_width: 50
                max_description_height: 10
                description_offset: 1
                # If true, the cursor pos will be corrected, so the suggestions match up with the typed text
                #
                # C:\> str
                #      str join
                #      str trim
                #      str split
                correct_cursor_pos: true
            }
            style: {
                text: blue
                selected_text: { attr: r }
                description_text: red
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
        {
            name: history_menu
            only_buffer_difference: true
            marker: "? "
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]

    keybindings: []
}


# platform-releated configuration
const linux_module = if $nu.os-info.name == linux { "./platform/ubuntu.nu" } else { null }
const window_module = if $nu.os-info.name == windows { "./platform/win.nu" } else { null }
const mac_module = if $nu.os-info.name == macos { "./platform/mac.nu" } else { null }

source $linux_module
source $window_module
source $mac_module

source ./plugins/plugins.nu
source ./aliases/aliases.nu
source ./completions/completions.nu
source ./keybindings/keybindings.nu
source ./themes/catppuccin-mocha.nu
