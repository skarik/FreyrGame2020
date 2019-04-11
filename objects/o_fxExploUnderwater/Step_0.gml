/// @description grow & decay

if (grow)
{
	alpha += Time.deltaTime / 0.1;
	radius = lerp(kStartRadius, kEndRadius, smoothstep(saturate(alpha)));

	if (alpha > 1.0)
	{
		alpha = 1.5;
		grow = false;
	}
}
else
{
	var fadeTime = 2.0;
	radius -= Time.deltaTime * kEndRadius * (1.4 / fadeTime) * saturate(1.0 - alpha);
	alpha -= Time.deltaTime / fadeTime;
}