return {
  -- Catppuccin Mocha colors
  peach = 0xfffab387, -- peach
  mauve = 0xffcba6f7, -- mauve
  grey = 0xff6c7086,  -- overlay0
  transparent = 0x00000000,

  rosewater = 0xfff5e0dc,
  flamingo = 0xfff2cdcd,
  pink = 0xfff5c2e7,
  red = 0xfff38ba8,
  maroon = 0xffeba0ac,
  yellow = 0xfff9e2af,
  green = 0xffa6e3a1,
  teal = 0xff94e2d5,
  sky = 0xff89dceb,
  sapphire = 0xff74c7ec,
  blue = 0xff89b4fa,
  lavender = 0xffb4befe,
  text = 0xffcdd6f4,
  subtext1 = 0xffbac2de,
  subtext0 = 0xffa6adc8,
  overlay2 = 0xff9399b2,
  overlay1 = 0xff7f849c,
  overlay0 = 0xff6c7086,
  surface2 = 0xff585b70,
  surface1 = 0xff45475a,
  surface0 = 0xff313244,
  base = 0xff1e1e2e,
  mantle = 0xff181825,   -- mantle
  crust = 0xff11111b,

  bar = {
    bg = 0xff11111b,     -- crust
    border = 0xff181825, -- mantle
  },
  popup = {
    bg = 0xe0313244,     -- surface0 with higher alpha (less transparent)
    border = 0xff45475a, -- surface1
  },

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
