/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Bar Owner";
m_actionName = "Trade";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

m_inventory = inventoryCreateOrLoad(null, 24);

m_vendorPortrait = sui_tempPortraitBarOwner;

// set up vendor inventory
var items = [o_pickupRes_Bolt, kCountPositiveInfinite,
			o_pickupRes_Gear, kCountPositiveInfinite,
			o_pickupCons_EggScrapple, 5,
			o_pickupCons_Sandcake, 3,
			o_pickupCons_Pomnut, 10,
			o_pickupItem_Scrapple, 3,
			o_pickupCons_Meats, 2,
			o_pickupCons_MedLeaf, 1,
			o_pickupCons_SweetBun, 2,
			o_pickupCons_ScorpStick, 2,
			o_pickupCons_HoneyAbsinthe, 2,
			o_pickupCons_ScorpJuice, 2,
			o_pickupCons_CactusJizz, 2,
			o_pickupCons_CactusRed, 2];
			
			
			
// create the vendor inventory
for (var i = 0; i < array_length_1d(items)/2; ++i)
{
	var pickup = instance_create_depth(0, 0, 0, items[i * 2 + 0]);
		pickup.m_count = items[i * 2 + 1];
	with (pickup)
	{
		pickupAddToArray(other.m_inventory.item);
	}
	idelete(pickup);
}