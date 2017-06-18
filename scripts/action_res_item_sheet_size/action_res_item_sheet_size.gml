/// action_res_item_sheet_size(value, add)
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
	history_set_var(action_res_item_sheet_size, res_edit.item_sheet_size[axis_edit], res_edit.item_sheet_size[axis_edit] * add + val, true)
}

with (res_edit)
	res_edit.item_sheet_size[axis_edit] = res_edit.item_sheet_size[axis_edit] * add + val

lib_preview.update = true
