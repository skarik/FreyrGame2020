var buffer = argument0;
var item = argument1;

var valid = buffer_read(buffer, buffer_u8);
if (valid)
{
	item.name     = buffer_read(buffer, buffer_string);
	item.object   = object_get_index(buffer_read(buffer, buffer_string));
	item.count    = buffer_read(buffer, buffer_s32);
	item.checkUse = script_get_index(buffer_read(buffer, buffer_string));
	item.onUse    = script_get_index(buffer_read(buffer, buffer_string));
	item.type     = buffer_read(buffer, buffer_s32);
}
else
{
	item.object   = null;
}