/// @function savestatePeekBufferHeaderVersion(buffer)
/// @param buffer {Buffer}
/// @returns {Integer} - Buffer header version loaded

var buffer = argument0;

// Load in the header
var off_preheader = buffer_tell(buffer);
var header_raw = buffer_read(buffer, buffer_u32);
var header_version = buffer_read(buffer, buffer_s32);

// return back to where we were
buffer_seek(buffer, buffer_seek_start, off_preheader);

// return the version
return header_version;