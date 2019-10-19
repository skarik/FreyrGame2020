/// @description Init state and create Debug UI

// State:
uiMouseX = 0;
uiMouseY = 0;
image_alpha = 0.0;

// Debug UI:
uiListing = ds_list_create();
ds_list_add(uiListing, new(o_debugCmdline));
