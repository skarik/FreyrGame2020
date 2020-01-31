var risingEdge = max(0.0, m_powerInput - m_powerInputPrevious);
m_powerInputPrevious = m_powerInput;
return risingEdge;