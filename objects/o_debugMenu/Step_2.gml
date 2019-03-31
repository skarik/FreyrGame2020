// Update mouse position
uiMouseX = window_mouse_get_x();
uiMouseY = window_mouse_get_y();


image_alpha = clamp(image_alpha + Time.unscaledDeltaTime * 4.0, 0.0, 1.0);