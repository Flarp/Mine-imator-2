/// action_lib_pc_type_rot_spd_mul_random_min(value, add)
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
	history_set_var(action_lib_pc_type_rot_spd_mul_random_min, ptype_edit.rot_spd_mul_random_min[axis_edit], ptype_edit.rot_spd_mul_random_min[axis_edit] * add + val, true)
}

ptype_edit.rot_spd_mul_random_min[axis_edit] = ptype_edit.rot_spd_mul_random_min[axis_edit] * add + val
