/// @description Set up menu

// Inherit the parent event (sets input priority to true to stop all motion)
event_inherited();

controlInit();

m_player = getPlayer();

m_totalBlend = 0.0;

m_tab = 0; // TODO: Make this persist thru death

m_base_x = 0;
m_base_y = 0;

//m_main_selection = null;
//m_main_hover = null;

enum BookTabs {
	Main = 0,
	Options = 3,
	Map = 1,
	Relationship = 2
};

enum BookState {
	TopLevel = 0,
	SelectionOptions = 1,
};

enum BookSelects {
	Invalid = null,
	
	TabMain			= 0,
	TabMap			= 1,
	TabRelationship	= 2,
	TabOptions		= 3,
	
	RestShort		= 10,
	RestShort_Duration	= 11,
	RestShort_Confirm	= 12,
	RestFull		= 13,
	RestFull_Confirm	= 14,
	
	Rune0	= 20,
	Rune1	= 21,
	Rune2	= 22,
	Rune3	= 23,
	Rune4	= 24,
	Rune5	= 25,
};

m_tab = BookTabs.Main;

m_book_state = BookState.TopLevel;

m_top_selection = BookSelects.Invalid;
m_top_hover = BookSelects.Invalid;
m_sub_selection = BookSelects.Invalid;
m_sub_hover = BookSelects.Invalid;

m_anim_tab_flavor = 0.0;