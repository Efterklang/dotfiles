local mocha_palette = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

--- Gets the Catppuccin theme.
--- @param flavor string Flavor of the theme: "latte", "frappe", "macchiato" or "mocha".
--- @return table theme Used in Yatline.
local function catppuccin_theme(flavor)
  
  local catppuccin_palette = mocha_palette

  return {
    -- yatline
    section_separator_open = "",
    section_separator_close = "",

    inverse_separator_open = "",
    inverse_separator_close = "",

    part_separator_open = "",
    part_separator_close = "",

    style_a = {
      fg = catppuccin_palette.mantle,
      bg_mode = {
        normal = catppuccin_palette.blue,
        select = catppuccin_palette.mauve,
        un_set = catppuccin_palette.red,
      },
    },
    style_b = { bg = catppuccin_palette.surface0, fg = catppuccin_palette.text },
    style_c = { bg = catppuccin_palette.mantle, fg = catppuccin_palette.text },

    permissions_t_fg = catppuccin_palette.green,
    permissions_r_fg = catppuccin_palette.yellow,
    permissions_w_fg = catppuccin_palette.red,
    permissions_x_fg = catppuccin_palette.sky,
    permissions_s_fg = catppuccin_palette.lavender,

    selected = { icon = "󰻭", fg = catppuccin_palette.yellow },
    copied = { icon = "", fg = catppuccin_palette.green },
    cut = { icon = "", fg = catppuccin_palette.red },

    total = { icon = "", fg = catppuccin_palette.yellow },
    succ = { icon = "", fg = catppuccin_palette.green },
    fail = { icon = "", fg = catppuccin_palette.red },
    found = { icon = "", fg = catppuccin_palette.blue },
    processed = { icon = "", fg = catppuccin_palette.green },

    -- yatline-githead
    prefix_color = catppuccin_palette.subtext0,
    branch_color = catppuccin_palette.sapphire,
    commit_color = catppuccin_palette.mauve,
    behind_color = catppuccin_palette.flamingo,
    ahead_color = catppuccin_palette.lavender,
    stashes_color = catppuccin_palette.pink,
    state_color = catppuccin_palette.maroon,
    staged_color = catppuccin_palette.yellow,
    unstaged_color = catppuccin_palette.peach,
    untracked_color = catppuccin_palette.teal,
  }
end

return {
  setup = function(_, args)
    args = args or "mocha"

    return catppuccin_theme(args)
  end,
}
