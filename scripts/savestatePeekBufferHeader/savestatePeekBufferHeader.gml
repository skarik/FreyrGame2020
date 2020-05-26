/// @function savestatePeekBufferHeader(buffer)
/// @param buffer {Buffer}
/// @returns {String[4]} - Buffer header loaded.

var buffer = argument0;

// Load in the header
var off_preheader = buffer_tell(buffer);
var header = array_create(4);
header[0] = buffer_read(buffer, buffer_u8);
header[1] = buffer_read(buffer, buffer_u8);
header[2] = buffer_read(buffer, buffer_u8);
header[3] = buffer_read(buffer, buffer_u8);

// return back to where we were
buffer_seek(buffer, buffer_seek_start, off_preheader);

// build the string to check
var header_str = "";
for (var i = 0; i < 4; ++i)
{
	if (header[i] != 0)
	{
		header_str += chr(header[i]);
	}
}
return header_str;