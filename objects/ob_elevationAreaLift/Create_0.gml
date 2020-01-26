/// @description Tracker setup

// Set up the structures used to track all objets that are on this
tracked_objects = array_create(0);

x_previous = x;
x_requested = x;

y_previous = y;
y_requested = y;
y_requestedOffset = 0;

z_previous = z;
z_requested = z;