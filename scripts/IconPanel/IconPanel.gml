/*
	IconPanel
	-------------------------------------------------------------------------
	Script:			IconPanel
	Version:		v1.00
	Created:		13/09/2025 by Alun Jones
	Description:	Icon Panel
	-------------------------------------------------------------------------
	History:
	 - Created 13/09/2025 by Alun Jones
	
	To Do:
*/

function IconPanel() constructor
{
	static render = function()
	{	
		// Window Size and Pos
		var windowSize = [round(WINDOW_SIZE[0] / 3) - 8, round(WINDOW_SIZE[1]) - 30];
		var windowPos = [round(WINDOW_SIZE[0] / 3 * 2) + 4, 26];
		
		// Set Next Window Position and Size
		ImGui.SetNextWindowPos(windowPos[0], windowPos[1], ImGuiCond.Always);
		ImGui.SetNextWindowSize(windowSize[0], windowSize[1], ImGuiCond.Always);
		
		// Begin Window
		if (ImGui.Begin("IconPanel", undefined, ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize))
		{
			// Header
			ImGui.Text("Icon Editor");
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
			if (ImGui.BeginChild("ModelViewer"))
			{
				// Draw Icon Surface
				
				ImGui.EndChild();
			}
			
			// End Window
			ImGui.End();
		}
	}
}