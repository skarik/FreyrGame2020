/// @description Update the fades

// Update depth
if (iexists(o_PlayerHud))
{
	depth = o_PlayerHud.depth - 1; // Just over the HuD
}

m_timer += Time.deltaTime;
if (m_timer > 4.0)
{
	idelete(this);
}