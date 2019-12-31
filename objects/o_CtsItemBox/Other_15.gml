/// @description Draw lit parts

gpu_set_blendmode(bm_normal);

uiPosX += xoffset;
uiPosY += yoffset;
event_perform(ev_draw, 0);
uiPosX -= xoffset;
uiPosY -= yoffset;

lightingResetBlendMode();