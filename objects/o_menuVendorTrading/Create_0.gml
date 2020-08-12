/// @description Set up menu

// Inherit the parent event (sets input priority to true to stop all motion)
event_inherited();

controlInit();

m_player = getPlayer();
m_vendor = m_player.m_currentVendor;

m_totalBlend = 0.0;

m_tab = 0; // TODO: Make this persist thru death

m_base_x = 0;
m_base_y = 0;

// TODO: create structs instead
var base_gs_struct = ds_map_create();
base_gs_struct[?"hover"] = null;
base_gs_struct[?"selection"] = null;

m_boxgs_player = ds_map_create_copy(base_gs_struct);
m_boxds_player = ds_map_create();

m_boxgs_vendor = ds_map_create_copy(base_gs_struct);
m_boxds_vendor = ds_map_create();

m_boxgs_rx = ds_map_create_copy(base_gs_struct);
m_boxds_rx = ds_map_create();

m_boxgs_tx = ds_map_create_copy(base_gs_struct);
m_boxds_tx = ds_map_create();

m_itemarray_rx = itemArrayCreate(16);
m_itemarray_tx = itemArrayCreate(16);

// button ui states
m_buttongs = ds_map_create_copy(base_gs_struct);
m_buttonds = ds_map_create();

enum VendorButtons {
	Trade = 0,
	ClearGive = 1,
	ClearGet = 2,
	Leave = 3,
	
	COUNT = 4
}
