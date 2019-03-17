//@description Update inputs.
//@param clear_input  If true, clears all input.
if (argument0 == false)
{
	_controlStructUpdate(xAxis, -keyboard_check(vk_left) + keyboard_check(vk_right));
	_controlStructUpdate(yAxis, -keyboard_check(vk_up) + keyboard_check(vk_down));
	_controlStructUpdate(zAxis, keyboard_check(vk_space));

	_controlStructUpdate(aButton, keyboard_check(ord("Z")));
	_controlStructUpdate(bButton, keyboard_check(ord("X")));
	_controlStructUpdate(xButton, keyboard_check(ord("A")));
	_controlStructUpdate(yButton, keyboard_check(ord("S")));
}
else
{
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
	_controlStructUpdate(zAxis, 0.0);

	_controlStructUpdate(aButton, 0.0);
	_controlStructUpdate(bButton, 0.0);
	_controlStructUpdate(xButton, 0.0);
	_controlStructUpdate(yButton, 0.0);
}