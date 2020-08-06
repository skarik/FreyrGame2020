/// @description Delete after done

if (m_show)
{
	time += Time.deltaTime;
}
else
{
	time_fade += Time.deltaTime;
}

if (time_fade > 5.0)
{
	idelete(this);
	exit;
}