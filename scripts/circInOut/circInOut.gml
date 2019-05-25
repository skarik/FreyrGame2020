var t = argument0;

if (t < 0.5)
{
	return (1.0 - sqrt(1.0 - 2.0 * t)) * 0.5;
}
else
{
	return (1.0 + sqrt(2.0 * t - 1.0)) * 0.5;
}