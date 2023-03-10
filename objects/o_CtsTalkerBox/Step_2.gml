var view_xview0 = GameCamera.x - GameCamera.width / 2;
var view_yview0 = GameCamera.y - GameCamera.height / 2;
var view_wview0 = GameCamera.width;
var view_hview0 = GameCamera.height;

draw_set_font(display_font);

/*if (iexists(input_actor))
{
    uiPosX = input_actor.x - display_width / 2;
    uiPosY = input_actor.y - input_actor.sprite_yoffset - _gabberBoxHeight() - 18;
    
    // Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 20, view_yview0 + view_hview0 - 20 - _gabberBoxHeight());
}
else if (iexists(o_CtsKeyPoint))
{
    uiPosX = o_CtsKeyPoint.x - display_width / 2;
    uiPosY = o_CtsKeyPoint.y - _gabberBoxHeight() - 28;
    
    // Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 20, view_yview0 + view_hview0 - 20 - _gabberBoxHeight());
}
else if (iexists(o_PlayerTest))
{
    uiPosX = view_xview0 + view_wview0 / 2 - display_width / 2;
    uiPosY = o_PlayerTest.y - o_PlayerTest.sprite_yoffset - _gabberBoxHeight() - 18;
    
    // Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 20, view_yview0 + view_hview0 - 20 - _gabberBoxHeight());
}*/
if (iexists(o_CtsPortraitRenderer) 
	&& input_portrait >= 0 && input_portrait < kPortraitIndex_Max
	&& o_CtsPortraitRenderer.state_alpha[input_portrait] > 0.0)
{
	uiPosX = view_xview0 + o_CtsPortraitRenderer.state_position[input_portrait] - display_width / 2;
	uiPosY = view_yview0 + view_hview0 - _gabberBoxHeight() - 28 - 20;
	
	// Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 20, view_yview0 + view_hview0 - 20 - _gabberBoxHeight());
}
else
{
    uiPosX = view_xview0 + 64;
    uiPosY = view_yview0 + 64;
}

uiPosX -= GameCamera.view_x;
uiPosY -= GameCamera.view_y;