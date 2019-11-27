var buffer = argument0;
var item = argument1;

if (item.object != null)
{
	buffer_write(buffer, buffer_u8, true);
	buffer_write(buffer, buffer_string, item.name);
	buffer_write(buffer, buffer_string, object_get_name(item.object));
	buffer_write(buffer, buffer_s32, item.count);
	buffer_write(buffer, buffer_string, script_get_name(item.checkUse));
	buffer_write(buffer, buffer_string, script_get_name(item.onUse));
	buffer_write(buffer, buffer_string, script_get_name(item.onDeplete));
	buffer_write(buffer, buffer_s32, item.type);
	buffer_write(buffer, buffer_string, object_get_name(item.tradeItem[0]));
	buffer_write(buffer, buffer_s32, item.tradeItem[1]);
	buffer_write(buffer, buffer_s32, item.userInfo);
	buffer_write(buffer, buffer_string, item.userInfoS);
}
else
{
	buffer_write(buffer, buffer_u8, false);
}