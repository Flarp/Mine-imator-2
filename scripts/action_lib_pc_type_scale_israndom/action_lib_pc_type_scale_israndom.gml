/// action_lib_pc_type_scale_israndom(israndom)
/// @arg israndom

var israndom;

if (history_undo)
	israndom = history_data.oldval
else if (history_redo)
	israndom = history_data.newval
else
{
	israndom = argument0
	history_set_var(action_lib_pc_type_scale_israndom, ptype_edit.scale_israndom, israndom, false)
}

ptype_edit.scale_israndom = israndom
