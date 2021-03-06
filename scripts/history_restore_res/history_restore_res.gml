/// history_restore_res(save)
/// @arg save

var save, res;
save = argument0
res = new(obj_resource)

with (save)
	res_copy(res)
	
save_folder = app.project_folder
load_folder = app.project_folder

with (res)
{
	res_load()
	
	for (var s = 0; s < save.usage_char_skin_amount; s++)
	{
		with (iid_find(save.usage_char_skin[s]))
		{
			char_skin.count--
			char_skin = res
		}
	}
			
	for (var s = 0; s < save.usage_item_tex_amount; s++)
	{
		with (iid_find(save.usage_item_tex[s]))
		{
			item_tex.count--
			item_tex = res
			temp_update_item()
		}
	}
			
	for (var s = 0; s < save.usage_block_tex_amount; s++)
	{
		with (iid_find(save.usage_block_tex[s]))
		{
			block_tex.count--
			block_tex = res
		}
	}
			
	for (var s = 0; s < save.usage_scenery_amount; s++)
		with (iid_find(save.usage_scenery[s]))
			scenery = res
			
	for (var s = 0; s < save.usage_shape_tex_amount; s++)
		with (iid_find(save.usage_shape_tex[s]))
			shape_tex = res
			
	for (var s = 0; s < save.usage_text_font_amount; s++)
	{
		with (iid_find(save.usage_text_font[s]))
		{
			text_font.count--
			text_font = res
		}
	}
			
	for (var s = 0; s < save.usage_sprite_tex_amount; s++)
		with (iid_find(save.usage_sprite_tex[s]))
			sprite_tex = res
			
	for (var s = 0; s < save.usage_kf_texture_amount; s++)
		with (iid_find(save.usage_kf_texture_tl[s]))
			keyframe[save.usage_kf_texture_index[s]].value[TEXTUREOBJ] = res
			
	for (var s = 0; s < save.usage_kf_sound_amount; s++)
		with (iid_find(save.usage_kf_sound_tl[s]))
			keyframe[save.usage_kf_sound_index[s]].value[SOUNDOBJ] = res
			
	for (var s = 0; s < save.usage_tl_texture_amount; s++)
	{
		with (iid_find(save.usage_tl_texture[s]))
		{
			value[TEXTUREOBJ] = res
			update_matrix = true
		}
	}
	
	for (var s = 0; s < save.usage_tl_sound_amount; s++)
	{
		with (iid_find(save.usage_tl_sound[s]))
		{
			value[SOUNDOBJ] = res
			update_matrix = true
		}
	}
	
	if (save.usage_background_image)
		app.background_image = res
		
	if (save.usage_background_sky_sun_tex)
	{
		app.background_sky_sun_tex.count--
		app.background_sky_sun_tex = res
	}
		
	if (save.usage_background_sky_moon_tex)
	{
		app.background_sky_moon_tex.count--
		app.background_sky_moon_tex = res
	}
		
	if (save.usage_background_sky_clouds_tex)
	{
		app.background_sky_clouds_tex.count--
		app.background_sky_clouds_tex = res
	}
		
	if (save.usage_background_ground)
	{
		with (app)
		{
			background_ground.count--
			background_ground = res
			background_ground_update_texture()
		}
	}
		
	count += save.usage_char_skin_amount
	count += save.usage_item_tex_amount
	count += save.usage_block_tex_amount
	count += save.usage_scenery_amount
	count += save.usage_shape_tex_amount
	count += save.usage_text_font_amount
	count += save.usage_sprite_tex_amount
	count += save.usage_kf_sound_amount
	count += save.usage_background_image
	count += save.usage_background_sky_sun_tex
	count += save.usage_background_sky_moon_tex
	count += save.usage_background_sky_clouds_tex
	count += save.usage_background_ground
}

sortlist_add(app.res_list, res)
	
return res
