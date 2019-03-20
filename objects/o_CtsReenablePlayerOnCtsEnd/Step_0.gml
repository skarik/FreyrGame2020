if (!exists(ob_CtsTalker))
{
	with (o_PlayerTest)
	{
		canMove = true;
	}
	delete(this);
}