/// @description fade in/out

if (!fade)
{
	image_alpha = min(1.0, image_alpha + Time.deltaTime * 0.6);
}
else
{
	image_alpha -= Time.deltaTime * 2.0;
	if (image_alpha <= 0.0)
	{
		delete(this);
	}
}