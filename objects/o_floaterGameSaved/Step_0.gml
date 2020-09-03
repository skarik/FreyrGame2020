/// @description Fade in and out

if (fadeIn)
{
	y -= 8 * saturate(image_alpha) * Time.dt;
	
	image_alpha += Time.deltaTime * 2.0;
	if (image_alpha > 3.0 * 2.0)
	{
		fadeIn = false;
	}
}
else
{
	y -= (8 + saturate(1.0 - image_alpha) * 32) * Time.dt;
	
	image_alpha = min(image_alpha - Time.deltaTime, 1.0);
	if (image_alpha <= 0.0)
	{
		idelete(this);
	}
}