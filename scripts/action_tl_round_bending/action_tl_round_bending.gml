/// action_tl_round_bending(enable)		
/// @arg enable

if (history_undo)
{
	with (history_data)
	{
		for (var t = 0; t < save_var_amount; t++)
		{
			with (iid_find(save_var_obj[t]))
			{
				round_bending = other.save_var_oldval[t]
				//tl_update_bend(true) // TODO
			}
		}
	}
}
else if (history_redo)
{
	with (history_data)
	{
		for (var t = 0; t < save_var_amount; t++)
		{
			with (iid_find(save_var_obj[t]))
			{
				round_bending = other.save_var_newval[t]
				//tl_update_bend(true) // TODO
			}
		}
	}
}
else
{
	var hobj = history_save_var_start(action_tl_round_bending, false);
	
	with (obj_timeline)
	{
		if (!select)
			continue
			
		with (hobj)
			history_save_var(other.id, other.round_bending, argument0)
			
		round_bending = argument0
		//tl_update_bend(1)  // TODO
	}
}
