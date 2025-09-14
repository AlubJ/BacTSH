#macro buffer_nxg_string 0xff

function buffer_read_big(buffer, type)
{
	switch (type)
	{
		case buffer_u16:
			var tempBuff = buffer_create(2, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_s16:
			var tempBuff = buffer_create(2, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_u32:
			var tempBuff = buffer_create(4, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 3, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_s32:
			var tempBuff = buffer_create(4, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 3, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_u64:
			var tempBuff = buffer_create(8, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 7, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 6, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 5, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 4, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 3, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_f16:
			var tempBuff = buffer_create(2, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_f32:
			var tempBuff = buffer_create(4, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 3, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_f64:
			var tempBuff = buffer_create(8, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 7, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 6, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 5, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 4, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 3, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_read(buffer, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_read(buffer, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_nxg_string:
			buffer_read(buffer, buffer_u32);
			return buffer_read(buffer, buffer_string);
		default:
			return buffer_read(buffer, type);
			break;
	}
}

function buffer_write_big(buffer, type, value)
{
	switch (type)
	{
		case buffer_u16:
		case buffer_s16:
		case buffer_f16:
			var tempBuff = buffer_create(2, buffer_fixed, 1);
			
			buffer_write(tempBuff, type, value);
			
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 1, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 0, buffer_u8));
			
			buffer_delete(tempBuff);
			break;
		case buffer_u32:
		case buffer_s32:
		case buffer_f32:
			var tempBuff = buffer_create(4, buffer_fixed, 1);
			
			buffer_write(tempBuff, type, value);
			
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 3, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 2, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 1, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 0, buffer_u8));
			
			buffer_delete(tempBuff);
			break;
		case buffer_u64:
		case buffer_f64:
			var tempBuff = buffer_create(8, buffer_fixed, 1);
			
			buffer_write(tempBuff, type, value);
			
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 7, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 6, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 5, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 4, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 3, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 2, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 1, buffer_u8));
			buffer_write(buffer, buffer_u8, buffer_peek(tempBuff, 0, buffer_u8));
			
			buffer_delete(tempBuff);
			break;
		case buffer_nxg_string:
			buffer_read(buffer, buffer_u32);
			return buffer_read(buffer, buffer_string);
		default:
			return buffer_read(buffer, type);
			break;
	}
}

function buffer_peek_big(buffer, offset, type)
{
	switch (type)
	{
		case buffer_u16:
		case buffer_s16:
		case buffer_f16:
			var tempBuff = buffer_create(2, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 1, buffer_u8, buffer_peek(buffer, offset + 0, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_peek(buffer, offset + 1, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_u32:
		case buffer_s32:
		case buffer_f32:
			var tempBuff = buffer_create(4, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 3, buffer_u8, buffer_peek(buffer, offset + 0, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_peek(buffer, offset + 1, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_peek(buffer, offset + 2, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_peek(buffer, offset + 3, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_u64:
		case buffer_f64:
			var tempBuff = buffer_create(8, buffer_fixed, 1);
			
			buffer_poke(tempBuff, 7, buffer_u8, buffer_peek(buffer, offset + 0, buffer_u8));
			buffer_poke(tempBuff, 6, buffer_u8, buffer_peek(buffer, offset + 1, buffer_u8));
			buffer_poke(tempBuff, 5, buffer_u8, buffer_peek(buffer, offset + 2, buffer_u8));
			buffer_poke(tempBuff, 4, buffer_u8, buffer_peek(buffer, offset + 3, buffer_u8));
			buffer_poke(tempBuff, 3, buffer_u8, buffer_peek(buffer, offset + 4, buffer_u8));
			buffer_poke(tempBuff, 2, buffer_u8, buffer_peek(buffer, offset + 5, buffer_u8));
			buffer_poke(tempBuff, 1, buffer_u8, buffer_peek(buffer, offset + 6, buffer_u8));
			buffer_poke(tempBuff, 0, buffer_u8, buffer_peek(buffer, offset + 7, buffer_u8));

			var returnVal = buffer_peek(tempBuff, 0, type);
			
			buffer_delete(tempBuff);
			
			return returnVal;
			break;
		case buffer_nxg_string:
			return buffer_peek(buffer, offset + 4, buffer_string);
		default:
			return buffer_peek(buffer, offset, type);
			break;
	}
}

function buffer_read_nxg_string(buffer)
{
	buffer_read(buffer, buffer_u32);
	return buffer_read(buffer, buffer_string);
}

function buffer_peek_nxg_string(buffer, offset)
{
	buffer_peek(buffer, offset, buffer_u32);
	return buffer_peek(buffer, offset + 4, buffer_string);
}