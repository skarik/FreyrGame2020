/// @description alpha fade

image_alpha -= Time.deltaTime;
if (image_alpha <= 0.0)
{
	delete(this);
}