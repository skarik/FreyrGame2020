/// @description Fade the effect & run logic

m_glitchFader += Time.deltaTime;
if (m_glitchFader > 1.0)
{
	idelete(this);	
}