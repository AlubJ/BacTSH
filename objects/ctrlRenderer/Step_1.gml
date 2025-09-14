/// @desc Update ImGui and Window Mouse
/*
	ctrlRenderer.BeginStep
	-------------------------------------------------------------------------
	Script:			ctrlRenderer.BeginStep
	Version:		v1.00
	Created:		15/11/2024 by Alun Jones
	Description:	Update ImGui and Window Mouse
	-------------------------------------------------------------------------
	History:
	 - Created 15/11/2024 by Alun Jones
	
	To Do:
*/
if (window_get_width() > 0 && window_get_height() > 0) ImGui.__Update();

// Mouse Position
CURSOR_POSITION[0] = window_mouse_get_x();
CURSOR_POSITION[1] = window_mouse_get_y();

// Window Width
if (WINDOW_SIZE[0] != window_get_width() && window_get_width() > 0)
{
	// Main Window Width
	WINDOW_SIZE[0] = window_get_width();
	surface_resize(application_surface, WINDOW_SIZE[0], WINDOW_SIZE[1]);
	display_set_gui_size(WINDOW_SIZE[0], WINDOW_SIZE[1]);
}

// Window Height
if (WINDOW_SIZE[1] != window_get_height() && window_get_height() > 0)
{
	// Main Window Height
	WINDOW_SIZE[1] = window_get_height();
	surface_resize(application_surface, WINDOW_SIZE[0], WINDOW_SIZE[1]);
	display_set_gui_size(WINDOW_SIZE[0], WINDOW_SIZE[1]);
}