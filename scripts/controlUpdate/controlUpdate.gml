//@description Update inputs.
//@param clear_input  If true, clears all input.
if (argument0 == false)
{
	_controlStructUpdate(xAxis, -keyboard_check(ord("A")) + keyboard_check(ord("E")) + deadzone_bias(gamepad_axis_value(0, gp_axislh)));
	//188 is a comma
	_controlStructUpdate(yAxis, -keyboard_check(188) + keyboard_check(ord("O")) + deadzone_bias(gamepad_axis_value(0, gp_axislv)));
	_controlStructUpdate(zAxis, keyboard_check(vk_space));
	
	_controlStructUpdate(uAxis, -keyboard_check(vk_left) + keyboard_check(vk_right));
	_controlStructUpdate(vAxis, -keyboard_check(vk_up) + keyboard_check(vk_down));
	_controlStructUpdate(wAxis, keyboard_check(vk_space));

//	_controlStructUpdate(aButton, keyboard_check(ord("Z")));
	_controlStructUpdate(atkButton, mouse_check_button(mb_left)   + gamepad_button_check(0, gp_face1) + gamepad_button_check(0, gp_shoulderr));
	_controlStructUpdate(useButton, mouse_check_button(mb_left)   + gamepad_button_check(0, gp_face1) + gamepad_button_check(0, gp_shoulderr));
//	_controlStructUpdate(bButton, keyboard_check(ord("X")));
	_controlStructUpdate(aButton, keyboard_check(ord("U"))      + gamepad_button_check(0, gp_face2));
	_controlStructUpdate(cButton, mouse_check_button(mb_right)  + gamepad_button_check(0, gp_shoulderl));
	//222 is for single quote
	_controlStructUpdate(xButton, keyboard_check(222) || keyboard_check(vk_tab)  + gamepad_button_check(0, gp_start));
	///190 is period
	_controlStructUpdate(yButton, keyboard_check(190));
	_controlStructUpdate(lButton, keyboard_check(ord("T")) + mouse_wheel_down()   + gamepad_button_check(0, gp_padl));
	_controlStructUpdate(rButton, keyboard_check(ord("N")) + mouse_wheel_up()     + gamepad_button_check(0, gp_padr));
	_controlStructUpdate(itemsButton, keyboard_check(ord("C"))                                   + gamepad_button_check(0, gp_select));
	_controlStructUpdate(selectButton, mouse_check_button(mb_left) || keyboard_check(vk_enter)   + gamepad_button_check(0, gp_face1));
	_controlStructUpdate(cancelButton, mouse_check_button(mb_right) || keyboard_check(vk_escape) + gamepad_button_check(0, gp_face2) + + gamepad_button_check(0, gp_face4));
	_controlStructUpdate(prevUiButton, mouse_wheel_down()                               + gamepad_button_check(0, gp_shoulderl) );
	_controlStructUpdate(nextUiButton, mouse_wheel_up() + mouse_check_button(mb_middle) + gamepad_button_check(0, gp_shoulderr) );
	
	_controlStructUpdate(belt1Button, keyboard_check(ord("1")));
	_controlStructUpdate(belt2Button, keyboard_check(ord("2")));
	_controlStructUpdate(belt3Button, keyboard_check(ord("3")));
	_controlStructUpdate(belt4Button, keyboard_check(ord("4")));
	_controlStructUpdate(belt5Button, keyboard_check(ord("5")));
	_controlStructUpdate(belt6Button, keyboard_check(ord("6")));
	
	var nextUPositionMouse = round(window_mouse_get_x() / Screen.pixelScale + GameCamera.view_x);
	var nextVPositionMouse = round(window_mouse_get_y() / Screen.pixelScale + GameCamera.view_y);
	if (nextUPositionMouse != uPosition && nextVPositionMouse != vPosition)
	{
		uvPositionStyle = 0;
	}
	
	uPositionPrevious = uPosition;
	vPositionPrevious = vPosition;
	
	var analogX = deadzone_bias(gamepad_axis_value(0, gp_axisrh));
	var analogY = deadzone_bias(gamepad_axis_value(0, gp_axisrv));
	if (abs(analogX) > 0.3 || abs(analogY) > 0.3 || uvPositionStyle == 1)
	{
		uvPositionStyle = 1;
		//uPosition = round(x + analogX * 128.0);
		//vPosition = round(y + analogY * 128.0);
		uPositionScreen += Time.deltaTime * analogX * 128.0;
		vPositionScreen += Time.deltaTime * analogY * 128.0;
		uPositionScreen = clamp(uPositionScreen, 0, GameCamera.width);
		vPositionScreen = clamp(vPositionScreen, 0, GameCamera.height);
		
		uPosition = round(uPositionScreen + GameCamera.view_x);
		vPosition = round(vPositionScreen + GameCamera.view_y);
	}
	else
	{
		uPosition = nextUPositionMouse;
		vPosition = nextVPositionMouse;
	}
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
	_controlStructUpdate(atkButton, 0.0);
	_controlStructUpdate(useButton, 0.0);
	_controlStructUpdate(xButton, 0.0);
	_controlStructUpdate(yButton, 0.0);
	_controlStructUpdate(lButton, 0.0);
	_controlStructUpdate(rButton, 0.0);
	_controlStructUpdate(itemsButton, 0.0);
	_controlStructUpdate(selectButton, 0.0);
	_controlStructUpdate(cancelButton, 0.0);
	_controlStructUpdate(prevUiButton, 0.0);
	_controlStructUpdate(nextUiButton, 0.0);
	
	_controlStructUpdate(belt1Button, 0.0);
	_controlStructUpdate(belt2Button, 0.0);
	_controlStructUpdate(belt3Button, 0.0);
	_controlStructUpdate(belt4Button, 0.0);
	_controlStructUpdate(belt5Button, 0.0);
	_controlStructUpdate(belt6Button, 0.0);
}