/// @description slowly fade

image_alpha -= Time.deltaTime / 1000.0;
image_xscale -= Time.deltaTime * 5.5 / 4000.0;
image_yscale -= Time.deltaTime * 3.0 / 4000.0;

if (image_alpha < 0.0 || image_xscale < 0.0 || image_yscale < 0.0)
{
	delete(this);
}