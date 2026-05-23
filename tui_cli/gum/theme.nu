# Catppuccin theme for gum (https://github.com/charmbracelet/gum)
#
# Usage:
#   use /Users/gjx/.config/gum/theme.nu
#   theme apply                                      # mocha / lavender / blue
#   theme apply --flavour latte --accent peach       # auto-pick complementary highlight
#   theme apply --accent red --highlight maroon

def palette [flavour: string] {
    {
        latte: {
            rosewater: "#dc8a78", flamingo: "#dd7878", pink: "#ea76cb", mauve: "#8839ef",
            red: "#d20f39", maroon: "#e64553", peach: "#fe640b", yellow: "#df8e1d",
            green: "#40a02b", teal: "#179299", sky: "#04a5e5", sapphire: "#209fb5",
            blue: "#1e66f5", lavender: "#7287fd",
            text: "#4c4f69", subtext1: "#5c5f77", subtext0: "#6c6f85",
            surface1: "#bcc0cc", surface0: "#ccd0da"
        }
        frappe: {
            rosewater: "#f2d5cf", flamingo: "#eebebe", pink: "#f4b8e4", mauve: "#ca9ee6",
            red: "#e78284", maroon: "#ea999c", peach: "#ef9f76", yellow: "#e5c890",
            green: "#a6d189", teal: "#81c8be", sky: "#99d1db", sapphire: "#85c1dc",
            blue: "#8caaee", lavender: "#babbf1",
            text: "#c6d0f5", subtext1: "#b5bfe2", subtext0: "#a5adce",
            surface1: "#51576d", surface0: "#414559"
        }
        macchiato: {
            rosewater: "#f4dbd6", flamingo: "#f0c6c6", pink: "#f5bde6", mauve: "#c6a0f6",
            red: "#ed8796", maroon: "#ee99a0", peach: "#f5a97f", yellow: "#eed49f",
            green: "#a6da95", teal: "#8bd5ca", sky: "#91d7e3", sapphire: "#7dc4e4",
            blue: "#8aadf4", lavender: "#b7bdf8",
            text: "#cad3f5", subtext1: "#b8c0e0", subtext0: "#a5adcb",
            surface1: "#494d64", surface0: "#363a4f"
        }
        mocha: {
            rosewater: "#f5e0dc", flamingo: "#f2cdcd", pink: "#f5c2e7", mauve: "#cba6f7",
            red: "#f38ba8", maroon: "#eba0ac", peach: "#fab387", yellow: "#f9e2af",
            green: "#a6e3a1", teal: "#94e2d5", sky: "#89dceb", sapphire: "#74c7ec",
            blue: "#89b4fa", lavender: "#b4befe",
            text: "#cdd6f4", subtext1: "#bac2de", subtext0: "#a6adc8",
            surface1: "#45475a", surface0: "#313244"
        }
    } | get $flavour
}

def complementary [accent: string] {
    {
        rosewater: "flamingo", flamingo: "rosewater",
        pink: "mauve", mauve: "pink",
        red: "maroon", maroon: "red",
        peach: "yellow", yellow: "peach",
        green: "teal", teal: "green",
        sky: "sapphire", sapphire: "sky",
        blue: "lavender", lavender: "blue"
    } | get $accent
}

export def --env apply [
    --flavour: string = "mocha"    # latte | frappe | macchiato | mocha
    --accent: string = "lavender"  # primary color name
    --highlight: string = ""       # secondary; auto-picked if empty
] {
    let hl_name = if $highlight == "" { complementary $accent } else { $highlight }
    let p = (palette $flavour)
    let accent_c = ($p | get $accent)
    let highlight_c = ($p | get $hl_name)
    let bg = $p.surface0
    let dim = $p.surface1

    # choose
    $env.GUM_CHOOSE_CURSOR_FOREGROUND = $accent_c
    $env.GUM_CHOOSE_SELECTED_FOREGROUND = $accent_c
    $env.GUM_CHOOSE_HEADER_FOREGROUND = $highlight_c

    # confirm
    $env.GUM_CONFIRM_SELECTED_BACKGROUND = $accent_c
    $env.GUM_CONFIRM_SELECTED_FOREGROUND = $bg
    $env.GUM_CONFIRM_PROMPT_FOREGROUND = $highlight_c
    $env.GUM_CONFIRM_UNSELECTED_FOREGROUND = $p.text
    $env.GUM_CONFIRM_UNSELECTED_BACKGROUND = $bg

    # input
    $env.GUM_INPUT_CURSOR_FOREGROUND = $accent_c
    $env.GUM_INPUT_HEADER_FOREGROUND = $highlight_c
    $env.GUM_INPUT_PLACEHOLDER_FOREGROUND = $dim

    # filter
    $env.GUM_FILTER_INDICATOR_FOREGROUND = $accent_c
    $env.GUM_FILTER_SELECTED_PREFIX_FOREGROUND = $accent_c
    $env.GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND = $dim
    $env.GUM_FILTER_HEADER_FOREGROUND = $highlight_c
    $env.GUM_FILTER_MATCH_FOREGROUND = $highlight_c
    $env.GUM_FILTER_PROMPT_FOREGROUND = $dim
    $env.GUM_FILTER_PLACEHOLDER_FOREGROUND = $dim

    # spin
    $env.GUM_SPIN_SPINNER_FOREGROUND = $accent_c

    # table
    $env.GUM_TABLE_SELECTED_FOREGROUND = $accent_c
    $env.GUM_TABLE_HEADER_FOREGROUND = $highlight_c

    # write
    $env.GUM_WRITE_CURSOR_FOREGROUND = $accent_c
    $env.GUM_WRITE_HEADER_FOREGROUND = $highlight_c
    $env.GUM_WRITE_PLACEHOLDER_FOREGROUND = $dim
    $env.GUM_WRITE_PROMPT_FOREGROUND = $highlight_c

    # file
    $env.GUM_FILE_CURSOR_FOREGROUND = $accent_c
    $env.GUM_FILE_DIRECTORY_FOREGROUND = $highlight_c
    $env.GUM_FILE_SELECTED_FOREGROUND = $accent_c
    $env.GUM_FILE_PERMISSIONS_FOREGROUND = $p.subtext1
    $env.GUM_FILE_FILE_SIZE_FOREGROUND = $p.subtext0
    $env.GUM_FILE_SYMLINK_FOREGROUND = $p.green
}
