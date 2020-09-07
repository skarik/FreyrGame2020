function weatherGetWind() {
	var wind =  [(sin(Time.time * 0.3) * 0.5 + 0.6) * 100.0,
				 0.0];

	with (ob_weatherSystem)
	{
		wind[0] += m_windOffset[0];
		wind[1] += m_windOffset[1];
	}

	return wind;
	//return [0.0, 0.0];


}
