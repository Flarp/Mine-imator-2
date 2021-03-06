/// app_update_previews()

lib_preview.select = temp_edit
res_preview.select = res_edit
bench_settings.preview.select = bench_settings

with (obj_preview)
{
	if (last_select != select)
	{
		preview_reset_view()
		particle_spawner_clear()
	}
	last_select = select
	
	if (select && select.type = "particles")
		particle_spawner_update()
	
	spawn_laststep = current_step
}
