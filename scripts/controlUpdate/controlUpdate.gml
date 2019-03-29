//@description Update inputs.
//@param clear_input  If true, clears all input.
if (argument0 == false)
{
	_controlStructUpdate(xAxis, -keyboard_check(ord("A")) + keyboard_check(ord("D")));
	_controlStructUpdate(yAxis, -keyboard_check(ord("W")) + keyboard_check(ord("S")));
	_controlStructUpdate(zAxis, keyboard_check(vk_space));
	
	_controlStructUpdate(uAxis, -keyboard_check(vk_left) + keyboard_check(vk_right));
	_controlStructUpdate(vAxis, -keyboard_check(vk_up) + keyboard_check(vk_down));
	_controlStructUpdate(wAxis, keyboard_check(vk_space));

//	_controlStructUpdate(aButton, keyboard_check(ord("Z")));
	_controlStructUpdate(bButton, mouse_check_button(mb_left));
//	_controlStructUpdate(bButton, keyboard_check(ord("X")));
	_controlStructUpdate(aButton, keyboard_check(ord("F")));
	_controlStructUpdate(cButton, mouse_check_button(mb_right));
	_controlStructUpdate(xButton, keyboard_check(ord("Q")));
	_controlStructUpdate(yButton, keyboard_check(ord("E")));
	_controlStructUpdate(lButton, keyboard_check(ord("1")) + mouse_wheel_down());
	_controlStructUpdate(rButton, keyboard_check(ord("2")) + mouse_wheel_up());
	
	uPositionPrevious = uPosition;
	vPositionPrevious = vPosition;
	uPosition = round(window_mouse_get_x() / Screen.pixelScale + GameCamera.view_x);
	vPosition = round(window_mouse_get_y() / Screen.pixelScale + GameCamera.view_y);
}
else
{
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
	_controlStructUpdate(zAxis, 0.0);
	
	_controlStructUpdate(uAxis, 0.0);
	_controlStructUpdate(vAxis, 0.0);
	_controlStructUpdate(wAxis, 0.0);

	_controlStructUpdate(aButton, 0.0);
	_controlStructUpdate(bButton, 0.0);
	_controlStructUpdate(xButton, 0.0);
	_controlStructUpdate(yButton, 0.0);
	_controlStructUpdate(lButton, 0.0);
	_controlStructUpdate(rButton, 0.0);
}