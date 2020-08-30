cts_entry_count = 0;
cts_entry[0] = 0;
cts_entry_type[0] = SEQTYPE_NULL;

cts_entry_current = 0;
cts_execute_state = 0;
cts_execute_timer = 0;

cts_organic = false;

cts_last_signal = "";
cts_last_signal_consumed = true;

cts_actor_override_list = [];
cts_actor_override_list_enabled = false;

cts_actor_tracking_list = [];

cts_lines_tracked_instance = null;


// internal cutscene state. normally handled by an object but i'm lazy sometimes
m_cts_start_position = [0, 0];