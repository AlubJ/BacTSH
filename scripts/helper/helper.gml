function newTSH()
{
	// New TSH
	TSH = new TexturePage();
	
	// Set Model Name
	TSH_NAME = "NEW_TPAGE";
	window_set_caption($"{TSH_NAME} - BacTSH");
	
	return true;
}

function openTSH()
{
	var file = get_open_filename("TtGames Texture Sheet (*.tsh)|*.tsh", "sheet.tsh");
	if (file != "")
	{
		// Set Cursor To Wait
		window_set_cursor(cr_hourglass);
		
		// Load Texture Page
		TSH = new TexturePage(file);
		
		// Set Cursor To Default
		window_set_cursor(cr_default);
		
		// Set Model Name
		TSH_NAME = filename_name(file);
		window_set_caption($"{TSH_NAME} - BacTSH");
	}
	return true;
}

function saveTSH()
{
	var _file = get_save_filename("TtGames Texture Sheet (*.tsh)|*.tsh", TSH_NAME + ".TSH");
	if (_file != "")
	{
		TSH.repack();
		TSH.save(_file);
	}
}

function addTexture()
{
	var _file = get_open_filename("DirectDraw Surface (*.dds;*.tex)|*.dds;*.tex", "texture.dds");
	if (_file != "")
	{
		var icon = new TexturePageItem(_file, string_split(filename_name(_file), ".")[0]);
		if (sprite_get_width(icon.source) > 256 || sprite_get_height(icon.source) > 256)
		{
			sprite_delete(icon.source);
			show_debug_message($"Skipping icon {_file}, icon too big.");
			return;
		}
		icon.trim();
		TSH.add(icon);
	}
}

function addBulkTextures()
{
	var _file = get_open_filename("DirectDraw Surface (*.dds;*.tex)|*.dds;*.tex", "texture.dds");
	if (_file != "")
	{
		var _directory = filename_dir(_file);
		var _extension = filename_ext(_file);
		
		var _file = file_find_first(_directory + "/*" + _extension, fa_none);
		
		while (_file != "")
		{
			var icon = new TexturePageItem(_directory + "/" + _file, );
			_file = file_find_next();
			if (sprite_get_width(icon.source) > 256 || sprite_get_height(icon.source) > 256)
			{
				sprite_delete(icon.source);
				show_debug_message($"Skipping icon {_file}, icon too big.");
				continue;
			}
			icon.trim();
			TSH.add(icon);
		}
		
		file_find_close();
	}
}