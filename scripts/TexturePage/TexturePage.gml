function TexturePage(_file = "") constructor
{
	// Variables
	texturePage = noone;
	items = [];
	
	if (file_exists(_file))
	{
		// Load Texture Page
		load(_file);
	}
	
	static load = function(_file)
	{
		// Load Buffer
		var buffer = buffer_load(_file);
		
		// Read Header
		var sizeOfCC = buffer_read_big(buffer, buffer_u32);
		buffer_seek(buffer, buffer_seek_relative, sizeOfCC);
		var sizeOfSection = buffer_read_big(buffer, buffer_u32);
		
		// Get Data Position
		var dataPosition = buffer_tell(buffer);
		
		// Get the pointer to the DDS data
		var ddsPointer = dataPosition + sizeOfSection;
		
		// Load DDS Data
		var ddsBuffer = buffer_create(buffer_get_size(buffer) - ddsPointer, buffer_fixed, 1);
		buffer_copy(buffer, ddsPointer, buffer_get_size(ddsBuffer), ddsBuffer, 0);
		
		// Decode DDS
		var _texture = new Texture(ddsBuffer);
		texturePage = _texture.toSprite();
		_texture.destroy();
		
		// Destroy DDS Buffer
		buffer_delete(ddsBuffer);

		// Read Past Unhelpful Data
		buffer_seek(buffer, buffer_seek_relative, 0x14);
		
		// Get Texture Page Width and Height
		var tpageWidth = sprite_get_width(texturePage);
		var tpageHeight = sprite_get_height(texturePage);

		// Number of items
		var itemCount = buffer_read_big(buffer, buffer_u32);
		
		// Loop Items
		repeat(itemCount)
		{
			// Get Icon Page UVs
			var uvLeft		= buffer_read_big(buffer, buffer_f32);
			var uvBottom	= 1 - buffer_read_big(buffer, buffer_f32);
			var uvRight		= buffer_read_big(buffer, buffer_f32);
			var uvTop		= 1 - buffer_read_big(buffer, buffer_f32);
			
			// Normalize the UVs to pixel space
			var pixelLeft	= round(uvLeft * tpageWidth);
			var pixelTop	= round(uvTop * tpageHeight);
			var pixelWidth	= round(uvRight * tpageWidth) - pixelLeft;
			var pixelHeight	= round(uvBottom * tpageHeight) - pixelTop;
			
			// Positions From File
			var fileLeft	= buffer_read_big(buffer, buffer_u32);
			var fileTop	= buffer_read_big(buffer, buffer_u32);
			
			// Item Size With Padding
			var itemWidth	= buffer_read_big(buffer, buffer_u32);
			var itemHeight	= buffer_read_big(buffer, buffer_u32);
			
			// TXT1
			buffer_read_big(buffer, buffer_u32);
			
			// Padding
			var paddingBottom	= buffer_read_big(buffer, buffer_u32);
			var paddingTop		= buffer_read_big(buffer, buffer_u32);
			var paddingLeft		= buffer_read_big(buffer, buffer_u32);
			var paddingRight	= buffer_read_big(buffer, buffer_u32);
			
			// FNV Hash
			var FNVHash			= buffer_read_big(buffer, buffer_u32);
			
			// Get Name From TXT File Here
			
			// Create New Texture Page Item
			var item = new TexturePageItem(texturePage, "", {
				left: pixelLeft,
				top: pixelTop,
				width: pixelWidth,
				height: pixelHeight,
				fullWidth: itemWidth,
				fullHeight: itemHeight,
				paddingTop: paddingTop,
				paddingBottom: paddingBottom,
				paddingLeft: paddingLeft,
				paddingRight: paddingRight,
				FNVHash: FNVHash,
			});
			
			// Push Texture Page Item
			array_push(items, item);
		}
	}
	
	static add = function(item)
	{
		array_push(items, item);
	}

	static repack = function()
	{
		var timer = current_time;
		// Packer
		var packer = new TexturePacker();
		
		// Start
		packer.prepareSurface();
		
		// Loop All Items
		for (var i = 0; i < array_length(items); i++)
		{
			// Item
			var item = items[i];
			var properties = item.properties;
			
			// Get Item Properties
			var itemLeft = properties.left;
			var itemTop = properties.top;
			var itemWidth = properties.width;
			var itemHeight = properties.height;
			
			// Change Values Please
			if (item.source != texturePage)
			{
				itemLeft = 0;
				itemTop = 0;
			}
			
			// Add to packer
			show_debug_message($"Packing: {i}");
			var newTPageItem = packer.add(item.source, itemLeft, itemTop, itemWidth, itemHeight);
			
			// Set New Properties
			properties.left = newTPageItem[1];
			properties.top = newTPageItem[2];
			properties.width = newTPageItem[3];
			properties.height = newTPageItem[4];
		}
		
		// Reset
		packer.resetSurface();
		
		// Loop All Items
		for (var i = 0; i < array_length(items); i++)
		{
			// Destroy Source
			if (items[i].source != texturePage) sprite_delete(items[i].source);
		}
		
		// Save
		//packer.save("test.png");
		//show_debug_message($"Total Time: {current_time - timer}ms");
		
		// Delete Old Texture Page
		if (texturePage != noone) sprite_delete(texturePage);
		texturePage = packer.convertToSprite();
		
		// Loop All Items
		for (var i = 0; i < array_length(items); i++)
		{
			items[i].source = texturePage;
		}
		
		// Cleanup
		packer.destroy();
	}

	static save = function(_file)
	{
		// Create Buffer
		var buffer = buffer_create(1024, buffer_grow, 1);
		
		// Write Header
		buffer_write_big(buffer, buffer_u32, 0x4D);
		buffer_write(buffer, buffer_text, ".CC4HSERHSER");
		buffer_write_big(buffer, buffer_u32, 0x6);
		buffer_write_big(buffer, buffer_u32, 0x0);
		buffer_write_big(buffer, buffer_u32, 0x524F5456);
		buffer_write_big(buffer, buffer_u32, 0x0);
		buffer_write_big(buffer, buffer_u32, 0x15);
		buffer_write_big(buffer, buffer_u16, 0x10);
		buffer_write(buffer, buffer_string, "ProjectBlack_QA");
		buffer_write_big(buffer, buffer_u32, 0x0);
		buffer_write_big(buffer, buffer_u32, 0x6B9CFF);
		buffer_write_big(buffer, buffer_u16, 0xC);
		buffer_write(buffer, buffer_string, "alub_packer");
		buffer_write(buffer, buffer_u8,  0x18);
		buffer_write_big(buffer, buffer_u16, 0x1);
		buffer_write_big(buffer, buffer_u16, 0xE);
		
		// Write Length
		buffer_write_big(buffer, buffer_u32, array_length(items) * 0x38 + 0x18);
		buffer_write(buffer, buffer_text, ".CC4HSXTHSXT");
		buffer_write_big(buffer, buffer_u32, 0x4);
		buffer_write_big(buffer, buffer_u32, 0x524F5456);
		buffer_write_big(buffer, buffer_u32, array_length(items));
		
		// Write Items
		for (var i = 0; i < array_length(items); i++)
		{
			// Item
			var item = items[i];
			var properties = item.properties;
			
			// Texture Page
			texturePageWidth = sprite_get_width(texturePage);
			texturePageHeight = sprite_get_height(texturePage);
			
			// Get Icon Page UVs
			var uvLeft		= properties.left / texturePageWidth;
			var uvBottom	= 1 - (properties.top + properties.height) / texturePageHeight;
			var uvRight		= (properties.left + properties.width) / texturePageWidth;
			var uvTop		= 1 - properties.top / texturePageHeight;
			
			// Write
			buffer_write_big(buffer, buffer_f32, uvLeft);
			buffer_write_big(buffer, buffer_f32, uvBottom);
			buffer_write_big(buffer, buffer_f32, uvRight);
			buffer_write_big(buffer, buffer_f32, uvTop);
			
			// Positions From File
			buffer_write_big(buffer, buffer_u32, properties.left);
			buffer_write_big(buffer, buffer_u32, properties.top);
			
			// Item Size With Padding
			buffer_write_big(buffer, buffer_u32, properties.fullWidth);
			buffer_write_big(buffer, buffer_u32, properties.fullHeight);
			
			// TXT1
			buffer_write_big(buffer, buffer_u32, 0x31545844);
			
			// Padding
			buffer_write_big(buffer, buffer_u32, properties.paddingBottom);
			buffer_write_big(buffer, buffer_u32, properties.paddingTop);
			buffer_write_big(buffer, buffer_u32, properties.paddingLeft);
			buffer_write_big(buffer, buffer_u32, properties.paddingRight);
			
			// TXT1
			buffer_write_big(buffer, buffer_u32, properties.FNVHash);
		}
		
		// Create Texture
		var _texture = new Texture(texturePage, 0, 0, _COMPRESSION_TYPE.BC1, false, true);
		
		// Get Buffer
		var _textureBuffer = _texture.toBuffer();
		
		// Copy Buffer
		buffer_copy(_textureBuffer, 0, buffer_get_size(_textureBuffer), buffer, buffer_tell(buffer));
		
		// Clean-up
		_texture.destroy();
		buffer_delete(_textureBuffer);
		
		// Save Buffer
		buffer_save(buffer, _file);
	}
}

function TexturePageItem(_source = noone, _name = "", _tpageProperties = {}) constructor
{
	source = _source;				// Source Sprite
	name = _name;					// Name for hashing
	properties = _tpageProperties;	// TPage Properties Struct
	if (name != "") properties.FNVHash = FNV32(string_upper(name)); // Hash It
	
	if (is_string(_source))
	{
		// Load Sprite
		var buffer = buffer_load(_source);
		
		// Decode DDS
		var _texture = new Texture(buffer);
		source = _texture.toSprite();
		_texture.destroy();
		
		// Delete DDS Buffer
		buffer_delete(buffer);
		
		// Get Properties
		properties.fullWidth = sprite_get_width(source);
		properties.fullHeight = sprite_get_height(source);
	}
	
	// Trim
	static trim = function()
	{
		// Get Width and Height
		var w = properties.fullWidth;
		var h = properties.fullHeight;
		
		// Force precise bounding box
		sprite_collision_mask(source, true, bboxmode_automatic, 0, 0, 0, 0, bboxkind_precise, 0);
		
		var offsets = 0;
		
		var l = sprite_get_bbox_left(source);
		var t = sprite_get_bbox_top(source);
		var r = sprite_get_bbox_right(source);
		var b = sprite_get_bbox_bottom(source);
		
		var cropW = r - l + 4;
		var cropH = b - t + 4;
		
		// Create surface for cropping
		var surf = surface_create(cropW, cropH);
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		draw_sprite(source, 0, -l + 2, -t + 2); // offset to crop
		surface_reset_target();
		sprite_delete(source);

		var frameSpr = sprite_create_from_surface(surf, 0, 0, cropW, cropH, false, false, 0, 0);
		surface_free(surf);
		
		source = frameSpr;
		
		properties.left = 0;
		properties.top = 0;
		properties.width = cropW;
		properties.height = cropH;
		
		show_debug_message(json_stringify(properties, true));
		
		properties.paddingTop = t - 2;
		properties.paddingLeft = l - 2;
		properties.paddingBottom = properties.fullHeight - b;
		properties.paddingRight = properties.fullWidth - r;
	}
}

function TexturePacker() constructor
{
	// Set Up
	x = 0;
	y = 0;
	width = 256;
	height = 256;
	surface = surface_create(width, height);
	
	maxWidth = 4096;
	maxHeight = 4096;
	
	freeRectangles = [
		[0, 0, width, height],
	]
	
	step = 256;
	
	// Add
	static add = function(_sprite = noone, _x = 0, _y = 0, _w = sprite_get_width(_sprite), _h = sprite_get_height(_sprite))
	{
		// Find a free rectangle that fits
		var bestIndex = -1;
		var bestShort = 999999;
		var bestLong = 999999;
		// Find the best free rect
		for (var i = 0; i < array_length(freeRectangles); i++)
		{
			var free = freeRectangles[i];
			if (_w <= free[2] && _h <= free[3])
			{
				var leftoverH = abs(free[3] - _h);
				var leftoverW = abs(free[2] - _w);
				var shortSide = min(leftoverW, leftoverH);
				var longSide  = max(leftoverW, leftoverH);
            
				if (shortSide < bestShort || (shortSide == bestShort && longSide < bestLong))
				{
					bestShort = shortSide;
					bestLong  = longSide;
					bestIndex = i;
				}
			}
		}
		
		// No fit then we resize
		if (bestIndex == -1)
		{
			resize(_w, _h);
			return add(_sprite, _x, _y, _w, _h);
		}
		
		// Place In Free Space
		var free = freeRectangles[bestIndex];
		var px = free[0];
		var py = free[1];
		
		// Draw onto atlas
		draw_sprite_part(_sprite, 0, _x, _y, _w, _h, px, py);
		
		// Split free rect
		var newRects = splitRects(free, px, py, _w, _h);
		array_delete(freeRectangles, bestIndex, 1);
		for (var j = 0; j < array_length(newRects); j++) {
			array_push(freeRectangles, newRects[j]);
		}
		
		// Add new rects
		for (var i = 0; i < array_length(newRects); i++) {
			array_push(freeRectangles, newRects[i]);
		}
		
		// Cleanup
		cleanup();
		
		// Return Data
		return [surface, px, py, _w, _h];
	}
	
	// Cleanup
	static cleanup = function()
	{
		var i = 0;
		while (i < array_length(freeRectangles))
		{
			var a = freeRectangles[i];
			var j = i + 1;
			while (j < array_length(freeRectangles))
			{
				var b = freeRectangles[j];
            
				// Remove fully contained rects
				if (rectContains(a, b))
				{
					array_delete(freeRectangles, j, 1);
					continue;
				}
				if (rectContains(b, a))
				{
					array_delete(freeRectangles, i, 1);
					i--; break;
				}
            
				// Trim overlaps
				if (rectsOverlap(a, b))
				{
					var splits = rectSplitOverlap(a, b);
					// Replace a with splits
					array_delete(freeRectangles, i, 1);
					for (var s = 0; s < array_length(splits); s++)
					{
						array_push(freeRectangles, splits[s]);
					}
					i--; break;
				}
				j++;
			}
			i++;
		}
	}
	
	// Rect Contains
	static rectContains = function(a, b)
	{
		return (b[0] >= a[0] && b[1] >= a[1] &&
			b[0] + b[2] <= a[0] + a[2] &&
			b[1] + b[3] <= a[1] + a[3]);
	}
	
	// Rects Overlap
	static rectsOverlap = function(a, b)
	{
		return !(a[0] >= b[0] + b[2] ||
				a[0] + a[2] <= b[0] ||
				a[1] >= b[1] + b[3] ||
				a[1] + a[3] <= b[1]);
	}
	
	// Rect Split
	static rectSplitOverlap = function(a, b)
	{
		var rects = [];
		var ax = a[0], ay = a[1], aw = a[2], ah = a[3];
		var bx = b[0], by = b[1], bw = b[2], bh = b[3];
    
		var ax2 = ax + aw, ay2 = ay + ah;
		var bx2 = bx + bw, by2 = by + bh;
    
		// Left slice
		if (bx > ax && bx < ax2)
		{
			array_push(rects, [ax, ay, bx - ax, ah]);
		}
		// Right slice
		if (bx2 < ax2 && bx2 > ax)
		{
			array_push(rects, [bx2, ay, ax2 - bx2, ah]);
		}
		// Top slice
		if (by > ay && by < ay2)
		{
			array_push(rects, [ax, ay, aw, by - ay]);
		}
		// Bottom slice
		if (by2 < ay2 && by2 > ay)
		{
			array_push(rects, [ax, by2, aw, ay2 - by2]);
		}
		
		return rects;
	}
	
	// Prepare Surface
	static prepareSurface = function()
	{
		surface_set_target(surface);
		draw_clear_alpha(c_black, 0);
	}
	
	// Reset Surface
	static resetSurface = function()
	{
		surface_reset_target();
	}
	
	// Resize
	static resize = function(_w, _h)
	{
		var newW = width;
		var newH = height;
		
		if (_w > width) newW = ceil((width + _w) / step) * step;
		if (_h > height) newH = ceil((height + _h) / step) * step;
		
		// If no free rects fit (even though sprite < atlas), force expand one dimension
		if (_w <= width && _h <= height)
		{
			// Grow the smaller dimension first
			if (width <= height)
			{
				newW = width + step;
			}
			else
			{
				newH = height + step;
			}
		}
    
		// If nothing changed, bail to avoid infinite loop
		if (newW == width && newH == height)
		{
			show_debug_message("ERROR: Sprite too large to fit in atlas, even after resizing.");
			return;
		}
		
		surface_reset_target();
		
		var oldSurface = surface;
		//if (newW > maxWidth || newH > maxHeight) throw ("Uh oh");
		var newSurface = surface_create(newW, newH);
		
		surface_set_target(newSurface);
		draw_clear_alpha(c_black, 0);
		draw_surface(oldSurface, 0, 0);
		surface_reset_target();
		
		// Update free rects with new space
		if (newW > width) array_push(freeRectangles, [width, 0, newW - width, newH]);
		if (newH > height) array_push(freeRectangles, [0, height, newW, newH - height]);
		
		surface_free(oldSurface);
		surface = newSurface;
		width = newW;
		height = newH;
		surface_set_target(newSurface);
	}
	
	// Split Rects
	static splitRects = function(free_rect, px, py, w, h)
	{
		var frx = free_rect[0];
		var fry = free_rect[1];
		var frw = free_rect[2];
		var frh = free_rect[3];
    
		var rects = [];

		// Top
		if (py > fry) {
			array_push(rects, [frx, fry, frw, py - fry]);
		}
		// Bottom
		if (py + h < fry + frh) {
			array_push(rects, [frx, py + h, frw, (fry + frh) - (py + h)]);
		}
		// Left
		if (px > frx) {
			array_push(rects, [frx, py, px - frx, h]);
		}
		// Right
		if (px + w < frx + frw) {
			array_push(rects, [px + w, py, (frx + frw) - (px + w), h]);
		}

		return rects;
	}
	
	// Save
	static save = function(_filepath)
	{
		surface_save(surface, _filepath);
	}
	
	// Destroy
	static destroy = function()
	{
		surface_free(surface);
	}
	
	// Convert To Sprite
	static convertToSprite = function()
	{
		return sprite_create_from_surface(surface, 0, 0, width, height, false, false, 0, 0);
	}
	
	static toDDSBuffer = function()
	{
		// Convert To Sprite
		var _sprite = convertToSprite();
		
		// Create Texture
		var _texture = new Texture(_sprite, 0, 0, _COMPRESSION_TYPE.BC1, false, true);
		
		// Get Buffer
		var _buffer = _texture.toBuffer();
		
		// Destroy Texture
		_texture.destroy();
		
		// Return Buffer
		return _buffer;
	}
}