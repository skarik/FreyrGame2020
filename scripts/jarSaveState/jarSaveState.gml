var buffer = argument0;

buffer_write(buffer, buffer_s32, 0); //Padding
buffer_write(buffer, buffer_f32, x);
buffer_write(buffer, buffer_f32, y);
buffer_write(buffer, buffer_s32, charges);
buffer_write(buffer, buffer_s32, filled);