//return m_powerInput; // Directly route input to the output

if (exists(m_pot))
{
	return m_powerInput;
}
else
{
	return 0.0;
}