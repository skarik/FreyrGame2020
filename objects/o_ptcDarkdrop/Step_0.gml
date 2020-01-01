/// @description slowly fade

image_alpha -= Time.deltaTime * 0.2 / 4.0;
image_xscale -= Time.deltaTime * 1.0 / 11.0;
image_yscale -= Time.deltaTime * 0.7 / 11.0;

if (image_alpha < 0.0 || image_xscale < 0.0 || image_yscale < 0.0)
{
	delete(this);
}