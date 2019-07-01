/// @description Update visiblity.

event_user(0); // Actual visibility

// Update visibility pretty often.
alarm[0] = max(2, choose(ceil(300 / fps), 2, 5, 10));