/// @description Update visiblity.

event_user(0); // Actual visibility

// Update visibility pretty often.
alarm[0] = max(4, choose(ceil(300 / fps), 4, 8, 16));