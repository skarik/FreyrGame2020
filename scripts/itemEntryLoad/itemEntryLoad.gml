function itemEntryLoad(buffer, item)
{
	var valid = buffer_read(buffer, buffer_u8);
	if (valid)
	{
		item.name      = buffer_read(buffer, buffer_string);
		item.object    = object_get_index(buffer_read(buffer, buffer_string));
		item.count     = buffer_read(buffer, buffer_s32);
		item.checkUse  = script_get_index(buffer_read(buffer, buffer_string));
		item.onUse     = script_get_index(buffer_read(buffer, buffer_string));
		item.onDeplete = script_get_index(buffer_read(buffer, buffer_string));
		item.onUi      = script_get_index(buffer_read(buffer, buffer_string));
		item.type      = buffer_read(buffer, buffer_s32);
		item.tradeItem = [null, 0];
		item.tradeItem[0] = object_get_index(buffer_read(buffer, buffer_string));
		item.tradeItem[1] = buffer_read(buffer, buffer_s32);
		item.userInfo  = buffer_read(buffer, buffer_s32);
		item.userInfoS = buffer_read(buffer, buffer_string);
		
		// Now do fixes
		var item_info_table = itemfixGenerateStruct(item.object);
		{
			item.checkUse = item_info_table.checkUseScript;
			item.onUse = item_info_table.onUseScript;
			item.onDeplete = item_info_table.onDepleteScript;
			item.onUi = item_info_table.onUiScript;
		}
		delete item_info_table;
	}
	else
	{
		item.object   = null;
	}
}
