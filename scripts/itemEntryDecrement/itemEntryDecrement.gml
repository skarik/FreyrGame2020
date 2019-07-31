var item = argument0;

item.count -= 1;
if (item.count <= 0)
{
	if (item.onDeplete != null && item.onDeplete != nullScript)
	{
		script_execute(item.onDeplete);
	}
	itemEntryClear(item);
}