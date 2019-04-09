var buffer = argument0;

x				= buffer_read(buffer, buffer_f32);
y				= buffer_read(buffer, buffer_f32);
m_wateredTime	= buffer_read(buffer, buffer_f64);
tilled			= buffer_read(buffer, buffer_bool);
watered			= buffer_read(buffer, buffer_bool);

//show_message(string(x) + " " + string(y));