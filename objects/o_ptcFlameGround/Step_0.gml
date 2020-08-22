/// @description Shrink and fade over time

if (m_fadeTimer > 0.0)
	m_fadeTimer -= Time.deltaTime;
else
	image_alpha -= Time.deltaTime * m_fadeSpeed;
	
image_xscale -= sign(image_xscale) * Time.deltaTime * m_shrinkSpeed;
image_yscale -= sign(image_yscale) * Time.deltaTime * m_shrinkSpeed;

if (image_alpha <= 0.0 || image_yscale <= 0.0)
{
	idelete(this);
}