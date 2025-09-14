/*
	ViewerPanel
	-------------------------------------------------------------------------
	Script:			ViewerPanel
	Version:		v1.00
	Created:		13/09/2025 by Alun Jones
	Description:	Viewer Panel
	-------------------------------------------------------------------------
	History:
	 - Created 13/09/2025 by Alun Jones
	
	To Do:
*/

function ViewerPanel() constructor
{
	// Icon Frame
	ENVIRONMENT.iconFrame = 0;
	ENVIRONMENT.iconSelected = -1;
	ENVIRONMENT.scrollY = 0;
	
	static render = function()
	{	
		// Window Size and Pos
		var windowSize = [round(WINDOW_SIZE[0] / 3 * 2) - 4, round(WINDOW_SIZE[1]) - 30];
		var windowPos = [4, 26];
		
		// Set Next Window Position and Size
		ImGui.SetNextWindowPos(windowPos[0], windowPos[1], ImGuiCond.Always);
		ImGui.SetNextWindowSize(windowSize[0], windowSize[1], ImGuiCond.Always);
		
		// Begin Window
		if (ImGui.Begin("ViewerPanel", undefined, ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize))
		{
			// Header
			ImGui.Text("Icons Viewer");
			ImGui.Separator();
			
			// Get Cursor Pos
			var cursorPos = [ImGui.GetCursorPosX(), ImGui.GetCursorPosY()];
			
			// View Layers Button
			//ImGui.SetCursorPos(windowSize[0] - 28, 6);
			//if (ImGui.ImageButton("##hiddenDisplayLayerMenu", graLayers, 0, c_white, 1, c_white, 0)) displayLayersPopup = true;
			//ImGui.ShowTooltip("Viewer Layers");
			
			// Reset Cursor Position
			ImGui.SetCursorPos(cursorPos[0], cursorPos[1]);
			
			// Characters List
			if (TSH != noone && ImGui.BeginChild("ModelViewer"))
			{
				// Get Surface Size
				var surfW = windowSize[0] - 16;
				var surfH = windowSize[1] - 40;
				var iconSize = 96;
				var iconsPerRow = floor(surfW / iconSize);
				var iconsPerColumn = floor(surfH / iconSize);
				var iconRows = floor(array_length(TSH.items) / iconsPerRow);
				var startX = round((surfW % iconSize) / 2);
				var startY = 0;
				var xx = 0;
				var yy = 0;
				var paddingY = 4;
				//show_debug_message(iconRows);
				
				// Do Drawing Here
				if (!surface_exists(PRIMARY_SURFACE)) PRIMARY_SURFACE = surface_create(surfW, surfH);
				surface_set_target(PRIMARY_SURFACE);
				
				// Draw Clear
				draw_clear_alpha(c_black, 0);
				
				if (keyboard_check_pressed(vk_up)) ENVIRONMENT.iconFrame++;
				if (keyboard_check_pressed(vk_down)) ENVIRONMENT.iconFrame--;
				
				if (point_in_rectangle(CURSOR_POSITION[0], CURSOR_POSITION[1], 22, 66, 22 + windowSize[0], 66 + windowSize[1]))
				{
					if (mouse_wheel_up()) ENVIRONMENT.scrollY++;
					if (mouse_wheel_down()) ENVIRONMENT.scrollY--;
				}
				ENVIRONMENT.scrollY = clamp(ENVIRONMENT.scrollY, -(iconRows - (iconsPerColumn - 1)), 0)
				
				// Get Cursor Pos
				var cursorPos = [ImGui.GetCursorPosX(), ImGui.GetCursorPosY()];
				
				// Icon Stuff
				for (var i = 0; i < array_length(TSH.items); i++)
				{
					var colour = c_white;
					var drawX = startX + xx * iconSize;
					var drawY = startY + (yy + ENVIRONMENT.scrollY) * (iconSize + paddingY);
					var multiplyScale = 1;
					
					if (point_in_rectangle(CURSOR_POSITION[0] - 13, CURSOR_POSITION[1] - 60, drawX, drawY, drawX + iconSize - 2, drawY + iconSize - 2))
					{
						multiplyScale = 1.25;
						colour = c_orange;
					}
					
					for (var s = 0; s < sprite_get_number(ICONFRAMES[ENVIRONMENT.iconFrame]); s++)
					{
						draw_sprite_stretched_ext(ICONFRAMES[ENVIRONMENT.iconFrame], s, drawX, drawY, iconSize, iconSize, colour, 1);
					}
					
					var icon = TSH.items[i].properties;
					var scalePercentage = iconSize / icon.fullWidth;
					var w = icon.width * scalePercentage;
					var h = icon.height * scalePercentage;
					var l = icon.paddingLeft * scalePercentage;
					var t = icon.paddingTop * scalePercentage;
					draw_sprite_part_ext(TSH.items[i].source, 0, icon.left, icon.top, icon.width, icon.height, drawX + l, drawY + t, scalePercentage, scalePercentage, c_white, 1);
					
					xx++;
					if (xx >= iconsPerRow)
					{
						yy++;
						xx = 0;
					}
				}
				
				// Reset Target
				surface_reset_target();
				
				// Draw Icon Surface
				ImGui.Surface(PRIMARY_SURFACE);
				
				ImGui.EndChild();
			}
			
			// End Window
			ImGui.End();
		}
	}
}