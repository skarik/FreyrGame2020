/// @description options

// Inherit the parent event
event_inherited();

#region Options

m_name = "Test Vendor";
m_actionName = "Test";
m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;

#endregion

m_inventory = inventoryCreateOrLoad(null, 23);