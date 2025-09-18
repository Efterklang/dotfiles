$env.config = {
  show_banner: false

  ls: {
    use_ls_colors: true
    clickable_links: true
  }

  rm: {
    always_trash: true
  }

  error_style: "fancy"

  history: {
    max_size: 5000
    sync_on_enter: true
    file_format: "plaintext"
    isolation: false
  }

  completions: {}

  cursor_shape: {
    emacs: block
    vi_insert: blink_block
    vi_normal: blink_underscore
  }

  footer_mode: "auto" # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  edit_mode: vi
  shell_integration: {
    osc2: true
    osc7: true
    osc8: true
    osc9_9: true
    osc133: true
    osc633: true
    reset_application_mode: true
  }
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
  highlight_resolved_externals: true
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
      PWD: [
        {||
          if (which direnv | is-empty) {
            return
          }
          direnv export json | from json | default {} | load-env
        }
      ]
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
        selected_text: {attr: r}
        description_text: red
        match_text: {attr: u}
        selected_match_text: {attr: ur}
      }
    }
    {
      name: ide_completion_menu
      only_buffer_difference: false
      marker: "> "
      type: {
        layout: ide
        min_completion_width: 0
        max_completion_width: 80
        max_completion_height: 20 # will be limited by the available lines in the terminal
        padding: 0
        border: true
        cursor_offset: 0
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
        selected_text: {attr: r}
        description_text: red
        match_text: {attr: u}
        selected_match_text: {attr: ur}
      }
    }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: control
      keycode: char_i
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          {send: menu name: completion_menu}
          {send: menunext}
          {edit: complete}
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
          {send: menu name: ide_completion_menu}
          {send: menunext}
          {edit: complete}
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
      mode: [emacs vi_normal vi_insert]
      event: {
        send: executehostcommand
        cmd: "cd (tv zoxide)"
      }
    }
    {
        name: "move_to_line_start"
        modifier: shift
        keycode: char_h
        mode: vi_normal
        event: { edit: MoveToStart }
    }
    {
        name: "move_to_line_end"
        modifier: shift
        keycode: char_l
        mode: vi_normal
        event: { edit: MoveToEnd }
    }
  ]
}

# platform-releated configuration
const window_module = if $nu.os-info.name == windows { "./platform/win.nu" } else { null }
const mac_module = if $nu.os-info.name == macos { "./platform/mac.nu" } else { null }

source $window_module
source $mac_module

source ./plugins/plugins.nu
source ./aliases/alias.nu
source ./completions/completions.nu
source ./themes/catppuccin-mocha.nu
