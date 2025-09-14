/// @desc Initialise BrickDrasil
/*
	ctrlInit.Create
	-------------------------------------------------------------------------
	Script:			ctrlInit.Create
	Version:		v1.00
	Created:		20/11/2024 by Alun Jones
	Description:	Initialise BrickDrasil
	-------------------------------------------------------------------------
	History:
	 - Created 20/11/2024 by Alun Jones
	
	To Do:
*/

// 3D Settings
//gpu_set_ztestenable(true);
//gpu_set_zwriteenable(true);
//gpu_set_tex_repeat(true);
//gpu_set_tex_filter(true);
//gpu_set_alphatestenable(true);
//gpu_set_tex_mip_enable(mip_on);
//gpu_set_tex_min_mip(0);
//gpu_set_tex_max_mip(16);
//gpu_set_tex_max_aniso(16);
//gpu_set_tex_mip_bias(0);
//gpu_set_tex_mip_filter(tf_anisotropic);
display_reset(2, true);

#region Filesystem

// Create Cache Folder
TEMP_DIRECTORY = cache_directory;
directory_create(TEMP_DIRECTORY);

// Create Config Folder
CONFIG_DIRECTORY = game_save_id;
directory_create(CONFIG_DIRECTORY);

// Working Directory
WORKING_DIRECTORY = working_directory;

#endregion

#region BrickDrasil Settings

// Default Settings For First Time Launch
SETTINGS = {
	// Version
	version: VERSION,
	
	// Window Settings
	window: {
		maximised: false,
		size: [1366, 768],
		position: [0, 0],
	},
}

// Load Settings or Save Default Settings
if (file_exists(CONFIG_DIRECTORY + "settings.bin"))
{
	var settings = SnapFromBinary(CONFIG_DIRECTORY + "settings.bin");
	if (settings.version == VERSION) SETTINGS = settings;
	else 
	{
		SnapToBinary(SETTINGS, CONFIG_DIRECTORY + "settings.bin");
	}
}
else SnapToBinary(SETTINGS, CONFIG_DIRECTORY + "settings.bin");

// About
var buffer = buffer_load("about.txt");
ABOUT = buffer_read(buffer, buffer_text);
buffer_delete(buffer);

VERSIONS = {
	indev: true,
	main: "v0.0.1",
	renderer: "v0.0.1",
	backend: "v0.0.1",
	revision: "3",
}

VERSION_TAG = $"{game_display_name} | {VERSIONS.indev ? "dev_": ""}{VERSIONS.main}{VERSIONS.revision != 0 ? "_rev" + VERSIONS.revision : ""}";

#endregion

#region Window Settings

// Base Window Variables
WINDOW_SIZE = [1366, 768];
CURSOR_POSITION = [window_mouse_get_x(), window_mouse_get_y()];

// Set Window Size
window_set_min_width(1366);
window_set_min_height(768);
window_set_size(WINDOW_SIZE[0], WINDOW_SIZE[1]);
window_center();

// Resize the surfaces
surface_resize(application_surface, WINDOW_SIZE[0], WINDOW_SIZE[1]);
display_set_gui_size(WINDOW_SIZE[0], WINDOW_SIZE[1]);

#endregion

#region Create Instances

instance_create_layer(0, 0, layer, ctrlRenderer);
//instance_create_layer(0, 0, layer, ctrlScene);
instance_create_layer(0, 0, layer, ctrlUI);

#endregion

#region Goto Next Scene

//room_goto(scnMain);

#endregion