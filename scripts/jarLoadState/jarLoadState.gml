var buffer = argument0;

buffer_read(buffer, buffer_s32); //Padding
x		= buffer_read(buffer, buffer_f32);
y		= buffer_read(buffer, buffer_f32);
charges	= buffer_read(buffer, buffer_s32);
filled	= buffer_read(buffer, buffer_s32);
