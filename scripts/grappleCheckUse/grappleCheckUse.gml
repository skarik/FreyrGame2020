// @description returns true when grapple can be used

if (moScriptOverride != null)
{
	return false;
}

if (isDashing || isAttacking)
{
	return false;
}

return true;