/// shader_alpha_test_set()

var uTexture = shader_get_sampler_index(shader_alpha_test, "uTexture"), 
	uBlendColor = shader_get_uniform(shader_alpha_test, "uBlendColor");

shader_set(shader_alpha_test)

if (shader_texture_gm)
	texture_set_stage(uTexture, shader_texture)
else
	texture_set_stage_lib(uTexture, shader_texture)
	
shader_set_uniform_color(uBlendColor, shader_blend_color, shader_alpha)

shader_set_wind(shader_alpha_test)
