var currentTime = timeofdayGetDay() * 24.0 + timeofdayGetHour();
var day = floor(currentTime / 24.0);

// Mark today as watered!
m_watered[? day] = true;