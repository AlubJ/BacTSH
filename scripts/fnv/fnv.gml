#macro FNV32Prime  0x01000193
#macro FNV32Offset 0x811c9dc5

function FNV32(str)
{
    var ret = int64(FNV32Offset) & 0xFFFFFFFF;
	
    for (var i = 1; i <= string_length(str); i++)
    {
		ret *= int64(FNV32Prime);
		ret = ret & 0xFFFFFFFF;
		ret ^= int64(ord(string_char_at(str, i)));
		ret = ret & 0xFFFFFFFF;
    }
	
    return ret & 0xFFFFFFFF;
}