/// @description Run the organic cutscene.

if (m_running)
{
	// Check end-state
	if (m_lineIndex >= m_lineCount)
	{
		m_mainLinesDone = true;
	}
	
	if (m_mainLinesDone)
	{
	}
	else
	{
		//m_lineIndex
		var l_organic = true;
	
		if (m_executeState == 0)
		{
			var gabber = ctsMakeGabber(m_actors[m_lineActors[m_lineIndex]], "", m_lines[m_lineIndex]);
		        gabber.input_priority = !l_organic;
		        gabber.input_disable = l_organic;
		        gabber.input_autoclose = false;//SEQEND_ORGANIC //(ending == SEQEND_AUTO);
				gabber.input_minimal = l_organic;
				
			m_executeState = 1;
		}
		else if (  (!iexists(o_CtsTalkerBox) /*|| o_CtsTalkerBox.input_fadeout*/)
				&& (!iexists(o_CtsGabberBox) || (instance_number(o_CtsGabberBox) == 1 && o_CtsGabberBox.input_fadeout))  )
	    {
	        m_lineIndex++;
	        m_executeState = 0;   
	    }
	}
}