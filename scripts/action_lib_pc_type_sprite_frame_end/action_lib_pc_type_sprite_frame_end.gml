/// action_lib_pc_type_sprite_frame_end(value, add)
/// @arg value
/// @arg add

var val, add;
add = false

if (history_undo)
	val = history_data.oldval
else if (history_redo)
	val = history_data.newval
else
{
	val = argument0
	add = argument1
	history_set_var(action_lib_pc_type_sprite_frame_end, ptype_edit.sprite_frame_end, ptype_edit.sprite_frame_end * add + val, true)
}

with (ptype_edit)
{
	sprite_frame_end = sprite_frame_end * add + val
	ptype_update_sprite_vbuffers()
}

tab_template_editor_particles_preview_restart()
