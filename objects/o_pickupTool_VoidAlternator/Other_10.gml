/// @description Override and create the new item UI

// item ui pop
var talker;
	talker = new(o_CtsItemBox);
	talker.input_actor = object_index;
	talker.input_name = m_name;
	talker.input_text = "Same make as the capacitor...maybe it can plug into something.";
	talker.display_item_startx = x;
	talker.display_item_starty = y;
	
	//talker.display_text = talker.input_text;
	with (talker) Cts_ParseDialogue();

this.visible = false;
m_isPickingUp = false;
m_canPickUp = false;
//delete(this);

var pl = getPlayer();
pl.pstats.m_pitem[kPitemVoidAlternator] = 1;