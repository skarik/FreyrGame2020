/// @description Depth update

depthUpdate();

if (filled)
{
	if (charges <= 0)
	{
		filled = false;
		image_index = 0;
	}
}