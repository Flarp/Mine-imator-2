/// tl_value_set(valueid, value, add)
/// @arg valueid
/// @arg value
/// @arg add
/// @desc Adds the given value to all selected timelines.

if (history_undo)
{
	// Remove keyframes
	for (var k = 0; k < history_data.kf_add_amount; k++)
		with (iid_find(history_data.kf_add_tl[k]))
			tl_keyframe_remove(keyframe[history_data.kf_add_index[k]])
			
	// Restore keyframes
	for (var k = 0; k < history_data.kf_set_amount; k++)
		with (iid_find(history_data.kf_set_tl[k]).keyframe[history_data.kf_set_index[k]])
			for (var v = 0; v < history_data.par_set_amount; v++)
				value[history_data.value[v]] = tl_value_restore(history_data.value[v], history_data.kf_set_newvalue[k, v], history_data.kf_set_oldvalue[k, v])
}
else if (history_redo)
{
	// Add keyframes
	for (var k = 0; k < history_data.kf_add_amount; k++)
		with (iid_find(history_data.kf_add_tl[k]))
			tl_keyframe_add(history_data.kf_add_pos[k])
	
	// Restore keyframes
	for (var k = 0; k < history_data.kf_set_amount; k++)
		with (iid_find(history_data.kf_set_tl[k]).keyframe[history_data.kf_set_index[k]])
			for (var v = 0; v < history_data.par_set_amount; v++) 
				value[history_data.value[v]] = tl_value_restore(history_data.value[v], history_data.kf_set_oldvalue[k, v], history_data.kf_set_newvalue[k, v])
}
else
{
	var vid, val, add;
	vid = argument0
	val = argument1
	add = argument2

	// Modify timelines
	with (obj_timeline)
	{
		var nval;
		if (!select)
			continue
			
		if (vid = SOUNDOBJ && value[SOUNDOBJ])
			value[SOUNDOBJ].count--
			
		nval = value[vid] * add + val
		if (value[vid] != nval)
			update_matrix = true
		
		value[vid] = tl_value_clamp(vid, nval)
		if (vid = SOUNDOBJ && value[SOUNDOBJ])
			value[SOUNDOBJ].count++
	}
	
	// Save and modify keyframes
	for (var k = 0; k < history_data.kf_set_amount; k++)
	{
		with (iid_find(history_data.kf_set_tl[k]).keyframe[history_data.kf_set_index[k]])
		{
			if (history_data.par_set_n = history_data.par_set_amount)
				history_data.kf_set_oldvalue[k, history_data.par_set_n] = tl_value_save(vid, value[vid])
			
			value[vid] = tl_value_clamp(vid, value[vid] * add + val)
			history_data.kf_set_newvalue[k, history_data.par_set_n] = tl_value_save(vid, value[vid])
		}
	}
	
	history_data.value[history_data.par_set_n] = vid
	history_data.par_set_n++
	history_data.par_set_amount = max(history_data.par_set_amount, history_data.par_set_n)
	
	return 0
}

// For undo / redo
with (obj_timeline)
{
	cam_goalzoom = null
	tl_update_values()
}
	
with (app)
{
	tl_update_length()
	tl_update_matrix()
	app_update_tl_edit()
}
