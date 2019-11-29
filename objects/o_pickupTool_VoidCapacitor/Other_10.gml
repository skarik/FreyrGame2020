/// @description Override and create the new item UI

// item ui pop
var talker;
	talker = new(o_CtsItemBox);
	talker.input_actor = object_index;
	talker.input_name = m_name;
	talker.input_text = "The way it hums vaguely reminds you of home. Less refined, of course.";
	talker.display_item_startx = x;
	talker.display_item_starty = y;
	talker.input_addItem = false;
	
	//talker.display_text = talker.input_text;
	with (talker) ctsParseDialogue();

this.visible = false;
m_isPickingUp = false;
m_canPickUp = false;
//delete(this);

var pl = getPlayer();
if (pl.pstats.m_pitem[kPitemVoidCapacitor] == 0)
{
	if (!exists(o_cts00_UIGetVoidCap))
	{
		new(o_cts00_UIGetVoidCap);
	}
}