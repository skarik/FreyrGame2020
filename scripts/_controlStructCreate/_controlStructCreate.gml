var control = new(_dummy);
control.value = 0.0;
control.previous = 0.0;

control.down = false;
control.pressed = false;
control.released = false;

control.persistent = true;

return control;