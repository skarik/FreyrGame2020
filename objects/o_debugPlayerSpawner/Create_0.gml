/// @description Delete or set alarm
if (exists(o_PlayerTest))
{
	delete(this);
}
else
{
	alarm[0] = 1;
}