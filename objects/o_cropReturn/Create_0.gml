/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Payment Box";
m_actionName = "Open";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

m_inventory = inventoryCreateOrLoad(kBoxCropRewards, kCountInfinite);