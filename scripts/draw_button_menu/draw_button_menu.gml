/// draw_button_menu(name, type, x, y, width, height, value, text, script, [texture, [icon, [captionwidth]]])
/// @arg name
/// @arg type
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg value
/// @arg text
/// @arg script
/// @arg [texture
/// @arg [icon
/// @arg [captionwidth]]]

var name, type, xx, yy, wid, hei, value, text, script, tex, icon, capwid;
var flip, imgsize, mouseon, pressed, textoff, roundtop, roundbottom;
name = argument[0]
type = argument[1]
xx = argument[2] 
yy = argument[3]
wid = argument[4]
hei = argument[5]
value = argument[6]
text = argument[7]
script = argument[8]

if (xx + wid < content_x || xx > content_x + content_width || yy + hei < content_y || yy > content_y + content_height)
	return 0
	
if (argument_count > 9)
	tex = argument[9]
else
	tex = 0
	
if (argument_count > 10)
	icon = argument[10]
else
	icon = null

if (argument_count > 11)
	capwid = argument[11]
else
	capwid = text_max_width(name) + 20
	
flip = (yy + hei + hei * 4>window_height)
imgsize = hei - 4

// Tip
tip_set(text_get(name + "tip"), xx, yy, wid, hei)

// Caption
draw_label(text_get(name) + ":", xx, yy + hei / 2, fa_left, fa_middle)

// Mouse
xx += capwid
wid -= capwid
mouseon = app_mouse_box(xx, yy, wid, hei)

if (!content_mouseon)
	mouseon = false
	
pressed = false
if (mouseon)
{
	if (mouse_left || mouse_left_released)
		pressed = true
	frame = true
	mouse_cursor = cr_handpoint
}

if (menu_name = name)
	pressed = true

// Button
roundtop = (menu_name != name || !menu_flip)
roundbottom = (menu_name != name || menu_flip)
draw_box_rounded(xx, yy, wid, hei, test(pressed, setting_color_buttons_pressed, setting_color_buttons), 1, roundtop, roundtop, roundbottom, roundbottom)

// Sprite
if (icon)
	draw_image(spr_icons, icon, xx + 2 + imgsize / 2, yy + hei / 2 + pressed, 1, 1, setting_color_buttons_text, 1)
else if (tex)
	draw_texture(tex, xx + 4, yy + 2 + pressed, imgsize / texture_width(tex), imgsize / texture_height(tex))

// Text
textoff = test(tex || icon, imgsize - 4, 0)
draw_label(string_limit(string_remove_newline(text), wid - textoff - hei - 8), xx + hei / 2 + textoff, yy + hei / 2 + pressed, fa_left, fa_middle, setting_color_buttons_text, 1)

// Arrow
draw_image(spr_icons, test(flip, icons.arrowup, icons.arrowdown), xx + wid - hei / 2, yy + hei / 2 + pressed, 1, 1, setting_color_buttons_text, 1)

// Update menu position
if (menu_name = name)
{
	menu_x = xx
	menu_y = yy
}

// Check click
if (mouseon && mouse_left_released)
{
	window_busy = "menu"
	window_focus = string(menu_scroll)
	app_mouse_clear()
	
	menu_name = name
	menu_type = type
	menu_temp_edit = temp_edit
	menu_script = script
	menu_value = value
	menu_ani = 0
	menu_ani_type = "show"
	menu_flip = flip
	menu_x = xx
	menu_y = yy
	menu_w = wid
	menu_button_h = hei
	menu_item_w = wid
	menu_item_h = menu_button_h
	menu_flip = flip
	menu_include_tl_edit = (app.menu_name != "timelineeditorparent")
	
	// Init
	menu_clear()
	if (type = e_menu.LIST)
		menu_list_init()
	else if (type = e_menu.TIMELINE)
		menu_timeline_init()
	else
		menu_timeline_init()
		
	// Flip
	if (menu_flip)
		menu_show = floor((menu_y * 0.9) / menu_item_h)
	else
		menu_show = floor(((window_height - (menu_y + menu_button_h)) * 0.9) / menu_item_h)
	
	// Set scroll
	for (var m = 0; m < menu_amount; m++)
	{
		if (menu_value = menu_item[m].value)
		{
			menu_scroll.value = floor(clamp(m - floor(menu_show / 2), 0, max(0, menu_amount - menu_show)) / floor(menu_w / menu_item_w)) * menu_item_h
			break
		}
	}
	
	return true
}

return false
