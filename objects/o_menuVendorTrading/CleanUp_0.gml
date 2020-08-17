/// @description Control

controlCleanup();

// cleanup item array and shunt it back to the respective inventories
if (iexists(m_player)) vendorKickItemsBackTo(m_itemarray_tx, m_player.inventory.bag, true);
if (iexists(m_vendor)) vendorKickItemsBackTo(m_itemarray_rx, m_vendor.m_inventory.item, false);

itemArrayFree(m_itemarray_rx);
itemArrayFree(m_itemarray_tx);
itemArrayFree(m_held_inventory);

// cleanup maps
ds_map_destroy(m_boxgs_player);
ds_map_destroy(m_boxds_player);

ds_map_destroy(m_boxgs_vendor);
ds_map_destroy(m_boxds_vendor);

ds_map_destroy(m_boxgs_tx);
ds_map_destroy(m_boxds_tx);

ds_map_destroy(m_boxgs_rx);
ds_map_destroy(m_boxds_rx);

ds_map_destroy(m_buttongs);
ds_map_destroy(m_buttonds);