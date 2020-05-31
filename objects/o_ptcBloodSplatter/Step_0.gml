/// @description slowly fade

life += Time.deltaTime / 10.0;

if (life > 1.0)
{
	image_alpha -= Time.deltaTime / 500.0;
	image_xscale -= Time.deltaTime / 4000.0;
	image_yscale -= Time.deltaTime / 4000.0;
}

if (image_alpha < 0.0 || image_xscale < 0.0 || image_yscale < 0.0)
{
	idelete(this);
}