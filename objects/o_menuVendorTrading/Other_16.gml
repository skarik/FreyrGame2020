/// @description Unified UI draw

/*var c_bookHeading = make_color_rgb(165, 98, 67);
var c_bookHeadingShadow = make_color_rgb(207, 182, 144);

var kBookWidth = 482;
var kBookHeight = 298;
var kXOffsetCenterLeft = 130;
var kXOffsetCenterRight = kBookWidth - 130;

var kTabStartX = 50;
var kTabDivX = 25;
var kTabStartY = 9;*/

var dx, dy;
/*dx = ((Screen.width / Screen.pixelScale) - kBookWidth) / 2;
dy = round(((Screen.height / Screen.pixelScale) - kBookHeight) * 1.0 - 16.0);
dy += sqr(1.0 - saturate(m_totalBlend)) * 316; // Slide the book in from the bottom*/

dx = GameCamera.width / 2;
dy = -GameCamera.height * sqr(1.0 - saturate(m_totalBlend));

m_base_x = dx;
m_base_y = dy;

// Disable alpha-channel blending for most of this.
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);

// draw the left & right panels

//drawInventoryPanel

var panel_x;
var panel_y;

// player on left
panel_x = dx - 140;
panel_y = dy;
draw_rectangle(panel_x - 50, panel_y + 20, panel_x + 50, panel_y + 320, false);

// vendor on right
panel_x = dx + 140;
panel_y = dy;
draw_rectangle(panel_x - 50, panel_y + 20, panel_x + 50, panel_y + 320, false);

// center
panel_x = dx;
panel_y = dy;
draw_rectangle(panel_x - 30, panel_y + 120, panel_x + 30, panel_y + 200, false);

gpu_set_blendmode(bm_normal);