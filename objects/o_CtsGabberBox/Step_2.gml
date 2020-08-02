var view_xview0 = GameCamera.x - GameCamera.width / 2;
var view_yview0 = GameCamera.y - GameCamera.height / 2;
var view_wview0 = GameCamera.width;
var view_hview0 = GameCamera.height;

draw_set_font(display_font);

if (iexists(input_actor))
{
    uiPosX = input_actor.x - display_width / 2;
    uiPosY = input_actor.y - input_actor.sprite_yoffset - _gabberBoxHeight() - (input_minimal ? 0 : 18);
}
else if (iexists(o_CtsKeyPoint))
{
    uiPosX = o_CtsKeyPoint.x - display_width / 2;
    uiPosY = o_CtsKeyPoint.y - _gabberBoxHeight() - (input_minimal ? 10 : 28);
}
else if (iexists(o_PlayerTest))
{
    uiPosX = view_xview0 + view_wview0 / 2 - display_width / 2;
    uiPosY = o_PlayerTest.y - o_PlayerTest.sprite_yoffset - _gabberBoxHeight() - (input_minimal ? 0 : 18);
}
else
{
    uiPosX = view_xview0 + 64;
    uiPosY = view_yview0 + 64;
}

if (!input_minimal)
{	// Limit positions to stay on screen
	uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
	uiPosY = clamp(uiPosY, view_yview0 + 20, view_yview0 + view_hview0 - 20 - _gabberBoxHeight());
}
else
{	// Blend positions offscreen
	var min_x = view_xview0 + 20;
	var max_x = view_xview0 + view_wview0 - 20 - display_width;
	
	var min_y = view_yview0 + 20;
	var max_y = view_yview0 + view_hview0 - 20 - _gabberBoxHeight();
	
	if (uiPosX < min_x) 
		uiPosX = lerp(uiPosX, min_x, lerp(1.0, 0.3, saturate(min_x - uiPosX - 20)));
	else if (uiPosX > max_x) 
		uiPosX = lerp(uiPosX, max_x, lerp(1.0, 0.3, saturate(uiPosX - max_x - 20)));
		
	if (uiPosY < min_y) 
		uiPosY = lerp(uiPosY, min_y, 0.4);
	else if (uiPosY > max_y) 
		uiPosY = lerp(uiPosY, max_y, 0.4);
}

// Move postions to screenspace
uiPosX -= view_xview0;
uiPosY -= view_yview0;