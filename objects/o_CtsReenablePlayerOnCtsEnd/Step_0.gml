if (!iexists(ob_CtsTalker))
{
	with (o_PlayerTest)
	{
		canMove = true;
	}
	idelete(this);
}