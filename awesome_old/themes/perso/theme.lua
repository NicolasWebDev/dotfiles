---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
--theme.bg_focus      = "#535d6c"
theme.bg_focus      = "#1E6685"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

--theme.border_width  = "1"
theme.border_width  = "3"
theme.border_normal = "#000000"
--theme.border_focus  = "#535d6c"
theme.border_focus  = "#1E6685"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/sathors/.config/awesome/themes/perso/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/sathors/.config/awesome/themes/perso/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/sathors/.config/awesome/themes/perso/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/sathors/.config/awesome/themes/perso/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/sathors/.config/awesome/themes/perso/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/sathors/.config/awesome/themes/perso/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/sathors/.config/awesome/themes/perso/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/sathors/.config/awesome/themes/perso/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/sathors/.config/awesome/themes/perso/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/sathors/.config/awesome/themes/perso/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/sathors/.config/awesome/themes/perso/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/sathors/.config/awesome/themes/perso/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/sathors/.config/awesome/themes/perso/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/sathors/.config/awesome/themes/perso/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/sathors/.config/awesome/themes/perso/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/sathors/.config/awesome/themes/perso/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/sathors/.config/awesome/themes/perso/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/sathors/.config/awesome/themes/perso/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/sathors/.config/awesome/themes/perso/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/sathors/.config/awesome/themes/perso/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/sathors/.config/awesome/themes/perso/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/sathors/.config/awesome/themes/perso/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
-- doesn't seem to work
--theme.wallpaper_cmd = { "awsetbg /home/sathors/.config/awesome/themes/perso/wallpaper.jpg" }
--theme.wallpaper_cmd = { "feh --bg-scale /home/sathors/.config/awesome/themes/perso/wallpaper.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/sathors/.config/awesome/themes/perso/layouts/fairhw.png"
theme.layout_fairv = "/home/sathors/.config/awesome/themes/perso/layouts/fairvw.png"
theme.layout_floating  = "/home/sathors/.config/awesome/themes/perso/layouts/floatingw.png"
theme.layout_magnifier = "/home/sathors/.config/awesome/themes/perso/layouts/magnifierw.png"
theme.layout_max = "/home/sathors/.config/awesome/themes/perso/layouts/maxw.png"
theme.layout_fullscreen = "/home/sathors/.config/awesome/themes/perso/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/sathors/.config/awesome/themes/perso/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/sathors/.config/awesome/themes/perso/layouts/tileleftw.png"
theme.layout_tile = "/home/sathors/.config/awesome/themes/perso/layouts/tilew.png"
theme.layout_tiletop = "/home/sathors/.config/awesome/themes/perso/layouts/tiletopw.png"
theme.layout_spiral  = "/home/sathors/.config/awesome/themes/perso/layouts/spiralw.png"
theme.layout_dwindle = "/home/sathors/.config/awesome/themes/perso/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
