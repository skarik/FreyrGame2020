// Is tilde pressed?
if ( keyboard_check_pressed(192) )
{
    // Toggle the menu when it is pressed down.
    if ( !exists(o_debugMenu) ) {
        new( o_debugMenu );
        visible = true;
    }
    else {
        delete( o_debugMenu );
        visible = false;
    }
}
