/// @desc Render ImGui
/*
	ctrlRenderer.DrawGUI
	-------------------------------------------------------------------------
	Script:			ctrlRenderer.DrawGUI
	Version:		v1.00
	Created:		15/11/2024 by Alun Jones
	Description:	Draw The GUI
	-------------------------------------------------------------------------
	History:
	 - Created 15/11/2024 by Alun Jones
	
	To Do:
*/
gpu_set_tex_filter(false);
draw_clear(#080808);
if (window_get_width() > 0 && window_get_height() > 0) ImGui.__Render();
gpu_set_tex_filter(true);