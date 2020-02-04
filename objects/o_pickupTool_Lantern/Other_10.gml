/// @description Override and create the new item UI

var pl = getPlayer();
pl.pstats.m_pitem[kPitemLantern] = 1;

if (m_showPickupUI)
{
	// item ui pop
	var talker;
		talker = new(o_CtsItemBox);
		talker.input_actor = object_index;
		talker.input_name = m_name;
		talker.input_text = "The grubs inside emit a gentle light that seems to pierce the darkness.";
		talker.display_item_startx = x;
		talker.display_item_starty = y;
	
		//talker.display_text = talker.input_text;
		with (talker) ctsParseDialogue();

	this.visible = false;
	m_isPickingUp = false;
	m_canPickUp = false;
}
else
{
	event_inherited();
	delete(this);
}