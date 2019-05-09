var view_xview0 = GameCamera.x - GameCamera.width / 2;
var view_yview0 = GameCamera.y - GameCamera.height / 2;
var view_wview0 = GameCamera.width;
var view_hview0 = GameCamera.height;

if (exists(input_actor))
{
    uiPosX = input_actor.x - display_width / 2;
    uiPosY = input_actor.y - input_actor.sprite_yoffset - Choice_BoxHeight() - 18;
    
    // Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 64, view_yview0 + view_hview0 - 64 - Choice_BoxHeight());
}
else if (exists(o_PlayerTest))
{
    uiPosX = (view_xview0 + view_wview0 / 2 + o_PlayerTest.x) * 0.5 - display_width / 2;
    uiPosY = o_PlayerTest.y - o_PlayerTest.sprite_yoffset - Choice_BoxHeight() - 18;
    
    // Limit positions to stay on screen
    uiPosX = clamp(uiPosX, view_xview0 + 20, view_xview0 + view_wview0 - 20 - display_width);
    uiPosY = clamp(uiPosY, view_yview0 + 64, view_yview0 + view_hview0 - 64 - Choice_BoxHeight());
}
else
{
    uiPosX = view_xview0 + view_wview0 - 64 - display_width;
    uiPosY = view_yview0 + 64;
}
