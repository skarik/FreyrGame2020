if (!surface_exists(m_surface))
{
	m_surface = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_surfaceLightweight))
{
	m_surfaceLightweight = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_surfaceLightweightBack))
{
	m_surfaceLightweightBack = surface_create(GameCamera.width, GameCamera.height);
}

if (surface_get_width(m_surface) != GameCamera.width || surface_get_height(m_surface) != GameCamera.height)
{
	surface_resize(m_surface, GameCamera.width, GameCamera.height);
}
if (surface_get_width(m_surfaceLightweight) != GameCamera.width || surface_get_height(m_surfaceLightweight) != GameCamera.height)
{
	surface_resize(m_surfaceLightweight, GameCamera.width, GameCamera.height);
}
if (surface_get_width(m_surfaceLightweightBack) != GameCamera.width || surface_get_height(m_surfaceLightweightBack) != GameCamera.height)
{
	surface_resize(m_surfaceLightweightBack, GameCamera.width, GameCamera.height);
}

// reset gpu state
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_set_alpha(1.0);

// clear front surface
surface_set_target(m_surfaceLightweight);
draw_clear_alpha(c_white, 0.0);
surface_reset_target();

//
// Outlined Surface

surface_set_target(m_surface);
draw_clear_alpha(c_white, 0.0);

playerUiDrawUpperLeft();
playerUiDrawUpperRightAstrolabe();

surface_reset_target();

//
// Normal Surface

surface_set_target(m_surfaceLightweightBack);
draw_clear_alpha(c_white, 0.0);

//
// farm ui
playerUiDrawFarmOverlay();

//
// enemy hearts
playerUiDrawEnemyHearts();

//
// map
playerUiDrawBottomRightMap();

//
// chest, underneathe the inventory
playerUiDrawChest();

//
// bag, under the inventory bar
playerUiDrawBag();

//
// inventory
playerUiDrawInventory();

//
// aimer
playerUiDrawAimer();

// on top of it all, draw the fuckin book
playerUiDrawBook();

// and on top of all that, draw the inventory/menu cursor
{
	// on top of it all, draw the cursor
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);

	draw_set_alpha(max(m_bag_totalBlend, m_book_totalBlend));
	_playerUiDrawCursor();
	draw_set_alpha(1.0);
}

// draw the overlay over that
if (m_hiddenEdgeBlend > 0.0)
{
	// below it all draw the overlay
	
	var offx = sqr(1.0 - m_hiddenEdgeBlend) * 64 + 48;
	var offy = sqr(1.0 - m_hiddenEdgeBlend) * 64 + 48;
	draw_sprite_ext(sui_hiddenEdges, 0, -offx, -offy,
		1.0, 1.0, 0.0, c_white, m_hiddenEdgeBlend * 0.7);
	draw_sprite_ext(sui_hiddenEdges, 1, GameCamera.width + offx, -offy,
		-1.0, 1.0, 0.0, c_white, m_hiddenEdgeBlend * 0.7);
	draw_sprite_ext(sui_hiddenEdges, 2, GameCamera.width + offx, GameCamera.height + offy,
		-1.0, -1.0, 0.0, c_white, m_hiddenEdgeBlend * 0.7);
	draw_sprite_ext(sui_hiddenEdges, 1, -offx, GameCamera.height + offx,
		1.0, -1.0, 0.0, c_white, m_hiddenEdgeBlend * 0.7);
}

// darw blood over that
with (o_ptcBloodHud)
{
	event_user(2);
}

draw_set_alpha(1.0); // clear here for now
surface_reset_target();
