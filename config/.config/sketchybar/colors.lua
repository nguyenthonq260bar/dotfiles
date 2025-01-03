return {
  black = 0xff181819,
  white = 0xffe2e2e3,
  red = 0xfffc5d7c,
  green = 0xff9ed072,
  blue = 0xff76cce0,
  yellow = 0xffe7c664,
  yellow2 = 0xffffea00,
  orange = 0xfff39660,
  magenta = 0xffb39df3,
  grey = 0xff7f8490,
  transparent = 0x00000000,

  red_light           = 0xffa9645d,
  red_dark            = 0xff573738,
  grey_blue           = 0xff6f797c,
  light_blue          = 0xff657378,
  darkblue            = 0xff212c35,
  pink                = 0xff725955,
  magenta_dark        = 0xff3a3949,
  magenta_darker      = 0xff25232f,
  nickel              = 0xff6b7c6b,
  nickelblu           = 0xff657378,
  auro                = 0xff6f797c,
  puce                = 0xffa9645d,
  pastel              = 0xffcfcdca,
  olive               = 0xff3a3a3a,
  olive_light         = 0xff9d9d9d,
  rocket              = 0xff928980,
  gunmetal            = 0xff2c303a,
  quicksilver         = 0xffa0a0a0,

  bar = {
    bg = 0xf02c2e34,
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xff7f8490
  },
  bg1 = 0xff181819,
  bg2 = 0xff181819,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
