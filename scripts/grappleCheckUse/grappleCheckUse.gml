function grappleCheckUse(argument0) {
	// @description returns true when grapple can be used

	var _itemType = argument0;

	if (moScriptOverride != null)
	{
		return false;
	}

	if (isDashing || isAttacking)
	{
		return false;
	}

	return true;


}
