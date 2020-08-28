/// @description Fade out after time

fadeDelay -= Time.deltaTime;
if (fadeDelay < 0.0)
{
	image_alpha -= Time.deltaTime / 0.3;
	if (image_alpha <= 0.0)
	{
		idelete(this);
	}
}