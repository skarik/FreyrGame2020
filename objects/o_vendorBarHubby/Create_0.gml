/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Witchy Trader";
m_actionName = "Trade";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

m_inventory = inventoryCreateOrLoad(null, 24);

m_vendorPortrait = sui_tempPortraitBarHubby;

// set up vendor inventory
var items = [o_pickupRes_BoneShard, kCountPositiveInfinite,
			o_pickupRes_VoidShard, kCountPositiveInfinite,
			o_pickupSeed_Turnip, kCountPositiveInfinite,
			o_pickupSeed_Cabbage,50,
			o_pickupSeed_Potato, 50,
			o_pickupCons_Meats, 2,
			o_pickupCons_MedLeaf, 1,
			o_pickupCons_SweetBun, 2,
			o_pickupCons_ScorpStick, 2,];
			
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