/// @description This class will handle triggering events based on time
// I hope this doesn't become a mess, but it will. I can feel it in my bones.

//Each spot in the array will keep track of if the events for a given hour have been called.
m_hourFlags = array_create(24,0);
