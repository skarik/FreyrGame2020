/// @description Give items

var pl = getPlayer();
if (iexists(pl))
{
	x = pl.x;
	y = pl.y;
}

if (state == 0)
{
	state = 1;
}
else if (state == 1)
{	
	repeat (13) instance_create_depth(x, y, 0, o_pickupJunk_Rock);
	repeat (1) instance_create_depth(x, y, 0, o_pickupCons_Meats);
	repeat (2) instance_create_depth(x, y, 0, o_pickupCons_HoneyAbsinthe);
	repeat (1) instance_create_depth(x, y, 0, o_pickupCons_CactusRed);
	repeat (3) instance_create_depth(x, y, 0, o_pickupCons_TeaCigar);
	repeat (10) instance_create_depth(x, y, 0, o_pickupCrop_Turnip);
	
	state = 2;
}
else if (state == 2 && !iexists(o_pickupJunk_Rock))
{
	repeat (16) instance_create_depth(x, y, 0, o_pickupSeed_Turnip);
	repeat (5) instance_create_depth(x, y, 0, o_pickupSeed_Cabbage);
	repeat (2) instance_create_depth(x, y, 0, o_pickupSeed_Melon);
	repeat (10) instance_create_depth(x, y, 0, o_pickupSeed_Parsnip);
	repeat (3) instance_create_depth(x, y, 0, o_pickupSeed_Rice);
	
	repeat (12) instance_create_depth(x, y, 0, o_pickupCrop_Turnip);
	repeat (3) instance_create_depth(x, y, 0, o_pickupCrop_Parsnip);
	repeat (2) instance_create_depth(x, y, 0, o_pickupCrop_Melon);
	repeat (2) instance_create_depth(x, y, 0, o_pickupItem_CrullEgg);
	repeat (1) instance_create_depth(x, y, 0, o_pickupJunk_Spork);
	
	repeat (14) instance_create_depth(x, y, 0, o_pickupRes_Gear);
	repeat (17) instance_create_depth(x, y, 0, o_pickupRes_Bolt);
	repeat (2) instance_create_depth(x, y, 0, o_pickupRes_VoidShard);
	
	state = 3;
}
else if (state == 3 && !iexists(o_pickupSeed_Turnip))
{
	idelete(this);
	exit;
}