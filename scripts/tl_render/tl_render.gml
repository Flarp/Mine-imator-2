/// tl_render()
/// @desc Renders the timeline instance.

// No 3D representation?
if (type = "char" || type = "spblock" || type = "folder" || type = "background" || type = "audio")
	return 0
	
// Invisible?
if (!value_inherit[VISIBLE])
	return 0
	
// Hidden?
if (hide && !render_hidden)
	return 0

// Not registered on shadow depth testing?
if (!shadows && (render_mode = "highlightsundepth" || render_mode = "highlightspotdepth" || render_mode = "highlightpointdepth"))
	return 0
	
// Already selected when clicking?
if (render_mode = "click" && (select || lock))
	return 0

// Outlined?
if (render_mode = "select" && !parent_is_select && !select)
	return 0

tl_set_shader()

// Box for clicking
if (type = "particles" || type = "spotlight" || type = "pointlight" || type = "camera")
{
	if (render_mode = "click")
	{
		shader_texture = sprite_get_texture(spr_shape, 0)
		shader_texture_gm = true
		shader_use()
		vbuffer_render(render_click_box, pos)
		shader_texture_gm = false
	}
	
	if (type != "particles") // Only proceed with rendering for particles
	{
		shader_clear()
		return 0
	}
}

if (shader_alpha > 0)
{
	render_set_culling(!backfaces)
	shader_texture_filter_linear = texture_blur
	shader_texture_filter_mipmap = (app.setting_texture_filtering && texture_filtering)
	
	if (type != "particles")
	{
		var texobj = value_inherit[TEXTUREOBJ];
		
		matrix_set(matrix_world, matrix)
		matrix_offset = point3D(-rot_point[X], -rot_point[Y], -rot_point[Z])
		
		switch (type)
		{
			case "bodypart":
			{
				// TODO: Invalid bodypart
				if (bodypart.shape_vbuffer = null)
					break
					
				// Get texture
				var res = temp.char_skin;
				if (texobj && texobj.type != "camera")
					res = texobj
				if (!res.ready)
					res = res_def
				with (res)
					shader_texture = res_model_texture(other.bodypart)
				
				shader_use()
				vbuffer_render(bodypart.shape_vbuffer)
		
				if (bodypart.bend_part != null)
				{
					if (value[BENDANGLE] != 0 && bend_vbuffer)
						vbuffer_render(bend_vbuffer)
					matrix_set(matrix_world, matrix_bend)
					vbuffer_render(bodypart.shape_bend_vbuffer)
				}
				break
			   }
			   
			case "scenery":
			case "block":
			{
				// Get resource for texture
				var res = temp.block_tex;
				if (texobj)
					if (texobj.type != "camera")
						if (res.block_texture[0])
							res = texobj
					
				if (!res.ready)
					res = res_def
				
				// Draw
				if (type = "block")
					render_world_block(temp.block_vbuffer, res)
				else if (temp.scenery)
					render_world_scenery(temp.scenery, res, temp.block_repeat_enable, temp.block_repeat)
				break
			}
			   
			case "item":
				render_world_item(temp.item_vbuffer, temp.item_bounce, temp.item_face_camera, temp.item_tex)
				break
			
			case "text":
				render_world_text(text_vbuffer, text_texture, temp.text_face_camera, temp.text_font)
				break
				
			default: // Shapes
				var tex;
				with (temp)
					tex = temp_get_shape_tex(temp_get_shape_texobj(texobj))
				render_world_shape(temp.type, temp.shape_vbuffer, temp.shape_face_camera, tex)
				break
		}
	} 
	else if (render_particles) 
	{
		for (var p = 0; p < ds_list_size(particles); p++)
			with (ds_list_find_value(particles, p))
				particle_draw()
	}
	
	render_set_culling(true)
}

matrix_world_reset()
shader_clear()
