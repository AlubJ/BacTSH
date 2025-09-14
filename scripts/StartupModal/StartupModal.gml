/*
	StartupModal
	-------------------------------------------------------------------------
	Script:			StartupModal
	Version:		v1.00
	Created:		26/11/2024 by Alun Jones
	Description:	Startup Modal
	-------------------------------------------------------------------------
	History:
	 - Created 26/11/2024 by Alun Jones
	
	To Do:
*/

function StartupModal() : Modal() constructor
{
	name = "Welcome";
	
	width = 320;
	height = 94;
	
	closeButton = undefined;
	
	static render = function()
	{
		// Set Modal Position and Size
		ImGui.SetNextWindowPos(floor(WINDOW_SIZE[0] / 2) - floor(width / 2), floor(WINDOW_SIZE[1] / 2) - floor(height / 2), ImGuiCond.Always);
		ImGui.SetNextWindowSize(width, height, ImGuiCond.Once);
		
		// Begin Modal
		if (ImGui.BeginPopupModal(name, closeButton, ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize))
		{
			// Set Modal Open
			modalOpen = true;
			
			// Templates Text
			ImGui.Text("Create or Open TextureSheet");
			ImGui.Separator();
			
			// Spacing
			ImGui.Spacing();
			
			// Get Cursor Position
			var cursorPos = [ImGui.GetCursorPosX(), ImGui.GetCursorPosY()];
			
			// Center Button
			ImGui.SetCursorPos(width / 2 - 102, cursorPos[1] + 2);
			
			// Open Project or Model
			if (ImGui.Button("New TSH", 100))
			{
				if (newTSH()) ImGui.CloseCurrentPopup();
			}
			
			// Center Button
			ImGui.SetCursorPos(width / 2 + 2, cursorPos[1] + 2);
			
			// Open Project or Model
			if (ImGui.Button("Open TSH", 100))
			{
				if (openTSH()) ImGui.CloseCurrentPopup();
			}
			
			// End Popup
			ImGui.EndPopup();
		}
		else
		{
			modalOpen = false;
			closeButton = true;
		}
	}
}