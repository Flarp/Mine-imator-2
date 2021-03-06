/// view_control_position(view)
/// @arg view

var view, len, mat;
view = argument0

// Arrow length
if (tl_edit.type = "camera" && tl_edit.value[CAMROTATE])
	len = point3D_distance(cam_from, tl_edit.pos_rotate) * 0.2
else
	len = point3D_distance(cam_from, tl_edit.pos) * 0.2

// Create matrix
with (tl_edit)
{
	// Start from the parent matrix (body part transforms included), restore the position and remove all scaling
	mat = matrix_parent
	mat[MATX] = matrix[MATX]
	mat[MATY] = matrix[MATY]
	mat[MATZ] = matrix[MATZ]
	matrix_remove_scale(mat)
}

// Draw each axis
view_control_position_axis(view, XPOS, c_yellow, point3D_mul_matrix(vec3(-len, 0, 0), mat), point3D_mul_matrix(vec3(len, 0, 0), mat))
view_control_position_axis(view, YPOS, test(setting_z_is_up, c_blue, c_red), point3D_mul_matrix(vec3(0, -len, 0), mat), point3D_mul_matrix(vec3(0, len, 0), mat))
view_control_position_axis(view, ZPOS, test(setting_z_is_up, c_red, c_blue), point3D_mul_matrix(vec3(0, 0, -len), mat), point3D_mul_matrix(vec3(0, 0, len), mat))

// Is dragging
if (window_busy = "rendercontrol" && view_control_edit_view = view && view_control_edit < XROT)
{
	mouse_cursor = cr_handpoint
	
	// Move
	var veclen = vec2_length(view_control_vec)
	if (veclen > 0 && !mouse_still)
	{
		var vecmouse, vecdot, move, snapval;
		
		// Find move factor
		vecmouse = vec2(mouse_dx, mouse_dy)
		vecdot = vec2_dot(vec2_normalize(view_control_vec), vec2_normalize(vecmouse))
		move = (vec2_length(vecmouse) / veclen) * len * 2*vecdot
		move /= tl_edit.value_inherit[XSCA + view_control_edit]
		view_control_value += move
		
		// Snap
		snapval = frame_editor.position.snap_enabled * frame_editor.position.snap_size
		
		// Update
		axis_edit = view_control_edit
		tl_value_set_start(action_tl_frame_pos, true)
		tl_value_set(view_control_edit, snap(view_control_value, snapval) - tl_edit.value[view_control_edit], true)
		tl_value_set_done()
	}
	
	// Release
	if (!mouse_left)
	{
		window_busy = ""
		view_control_edit = null
	}
}
