/// @description Update visiblity.

event_user(0); // Actual visibility

// Update visibility pretty often.
alarm[0] = choose(ceil(300 / fps), 1, 5, 10);