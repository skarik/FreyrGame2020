m_surface = null;
m_surfaceLightweight = null;
m_surfaceLightweightBack = null;

#macro kUiDepthHudBase -9000
depth = kUiDepthHudBase;

m_inventory_selector = 0.0;
m_inventory_selectorStart = 0.0;
m_inventory_selectorTarget = 0.0;
m_inventory_selectorTimerCd = 0.0;
m_inventory_selectorBlend = 0.0;
m_inventory_selectorBlendCruft = 0.0;
m_inventory_selectorNameTimerCd = 0.0;
m_inventory_selectorNameBlend = 0.0;
m_inventory_selectorName = "";

//m_book_enabled = false;
m_book_totalBlend = 0;
m_bag_totalBlend = 0;

playerUiInit();

if (!exists(o_PlayerMap)) 
	map = new(o_PlayerMap);
else 
	map = instance_find(o_PlayerMap, 0);
map.persistent = true;