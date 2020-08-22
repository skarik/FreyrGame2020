/// @description Rise over time

// Update flash
m_flashTimer -= Time.deltaTime;
if (m_flashTimer <= 0.0)
{
	m_flash = false;
}

// Rise over time
z_height += Time.deltaTime * 32.0;

// Slow down motion
var aspeed = [xspeed, yspeed];
var aspeed_len = avec2_length(aspeed);
if (aspeed_len > 0.0)
{
	var aspeed_newlen = max(0.0, aspeed_len - 160.0 * Time.deltaTime);
	xspeed *= aspeed_newlen / aspeed_len;
	yspeed *= aspeed_newlen / aspeed_len;
}

// Move the particle
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// Smallify over time
image_xscale -= sign(image_xscale) * Time.deltaTime * 0.5 * m_fadeSpeed;
image_yscale -= sign(image_yscale) * Time.deltaTime * 0.5 * m_fadeSpeed;

// Fade out over time
image_alpha -= Time.deltaTime * m_fadeSpeed;
if (image_alpha < 0.0)
{
	idelete(this);
}