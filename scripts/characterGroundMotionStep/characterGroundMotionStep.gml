if (moEnabled)
{
	if (moScriptOverride != null)
	{
		script_execute(moScriptOverride);
	}
	/*else if (isDashing)
	{
		_playerMotionDashing();
	}*/
	else if (isAttacking)
	{
		switch (meleeAtkCurrent)
		{
		case 0: script_execute(meleeAtk0Script); break;
		case 1: script_execute(meleeAtk1Script); break;
		case 2: script_execute(meleeAtk2Script); break;
		case 3: script_execute(meleeAtk3Script); break;
		default:
			isAttacking = false;
			meleeAtkCurrent = 0;
			break;
		}
	}
	else
	{
		//_playerMotionNormal();
		_characterGroundMotionNormal();
	}
}