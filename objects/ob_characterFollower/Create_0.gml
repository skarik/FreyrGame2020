/// @description Inentory

// Inherit the parent event
event_inherited();

// they need a small inventory, since they are a follower
inventory = inventoryCreateOrLoad(m_name + "#bag", kCountInfinite);
