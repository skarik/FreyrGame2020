/// @description fade via alpha & size

image_yscale -= 1.0 * Time.deltaTime;
image_alpha -= 2.0 * Time.deltaTime;

if (image_yscale < 0.0 || image_alpha < 0.0)
	idelete(this);