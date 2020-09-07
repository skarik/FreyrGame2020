/// @function ctsGabbersHaveFocus()
/// @desc Checks all active gabbers to check if they have focus.
function ctsGabbersHaveFocus() {

	var l_hasFocus = false;

	with (ob_CtsTalker)
	{
		if (!input_minimal)
		{
			l_hasFocus = true;
			break;
		}
	}

	return l_hasFocus;


}
