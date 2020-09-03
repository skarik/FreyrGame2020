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
	SubsetLevel = 2,
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
	
	QuitToMenu		= 15,
	QuitToDesktop		= 16,
	
	Rune0	= 20,
	Rune1	= 21,
	Rune2	= 22,
	Rune3	= 23,
	Rune4	= 24,
	Rune5	= 25,
	
	OptionBase		= 100,
	Option_ViewUp		= 200,
	Option_ViewDown		= 201,
	Option_OptionBase	= 202,
	Option_TriOptionBase= 290,
};

m_tab = BookTabs.Main;

m_book_state = BookState.TopLevel;

m_top_selection = BookSelects.Invalid;
m_top_hover = BookSelects.Invalid;
m_sub_selection = BookSelects.Invalid;
m_sub_hover = BookSelects.Invalid;
m_sub_scroll = 0.0;
m_tri_selection = null;
m_tri_hover = null;
m_tri_ready = false;

m_anim_tab_flavor = 0.0;

m_hover_rects = array_create(300, null);

#macro kOptionTypeGameplay 0
#macro kOptionTypeControls 1
#macro kOptionTypeAudio 2
#macro kOptionTypeHUDLayout 3
#macro kOptionTypeSearch 4
#macro kOptionTypeDebug 5

#macro kOptionEntryOption 0
#macro kOptionEntryHeading 1

m_option_current_choice = null;
m_option_current_waittime = 3;

m_options_top_choices = ["Gameplay", "Controls", "Audio", "HUD Layout", "Search for Option"];
m_options = [
	[kOptionTypeGameplay,	kOptionEntryOption, "Blood", "blood"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Autoaim Items", "autoaim_item"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Autoaim Weapons", "autoaim_weapon"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Aim Cursor Style", "ui_cursor"],
	[kOptionTypeGameplay,	kOptionEntryOption, "UI Font Size", "ui_font_size"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Rumor Font Size", "ui_font_size_talk"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Font Style", "ui_font_style"],
	[kOptionTypeGameplay,	kOptionEntryOption, "Special Farm Mode", "mlgmode"],
	
	[kOptionTypeControls,	kOptionEntryHeading, "Interacting"],
	[kOptionTypeControls,	kOptionEntryOption,		"Use Object",		"use"],
	[kOptionTypeControls,	kOptionEntryOption,		"Use Item",			"useitem"],
	[kOptionTypeControls,	kOptionEntryOption,		"Use Equipment",	"usekeyitem"],
	[kOptionTypeControls,	kOptionEntryOption,		"Use Rune",			"usespecial"],
	[kOptionTypeControls,	kOptionEntryOption,		"Attack",			"attack"],
	[kOptionTypeControls,	kOptionEntryOption,		"Dodge",			"dodge"],
	[kOptionTypeControls,	kOptionEntryHeading, "Movement"],
	[kOptionTypeControls,	kOptionEntryOption,		"Move Left",		"moveleft"],
	[kOptionTypeControls,	kOptionEntryOption,		"Move Right",		"moveright"],
	[kOptionTypeControls,	kOptionEntryOption,		"Move Up",			"moveup"],
	[kOptionTypeControls,	kOptionEntryOption,		"Move Down",		"movedown"],
	[kOptionTypeControls,	kOptionEntryOption,		"Aim Left",			"aimleft"],
	[kOptionTypeControls,	kOptionEntryOption,		"Aim Right",		"aimright"],
	[kOptionTypeControls,	kOptionEntryOption,		"Aim Up",			"aimup"],
	[kOptionTypeControls,	kOptionEntryOption,		"Aim Down",			"aimdown"],
	[kOptionTypeControls,	kOptionEntryHeading, "Inventory"],
	[kOptionTypeControls,	kOptionEntryOption,		"Unequip Item",		"itemunequip"],
	[kOptionTypeControls,	kOptionEntryOption,		"Previous Item",	"itemprevious"],
	[kOptionTypeControls,	kOptionEntryOption,		"Next Item",		"itemnext"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 1",	"item1"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 2",	"item2"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 3",	"item3"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 4",	"item4"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 5",	"item5"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select Item 6",	"item6"],
	[kOptionTypeControls,	kOptionEntryHeading, "Screens"],
	[kOptionTypeControls,	kOptionEntryOption,		"Inventory",		"inventory"],
	[kOptionTypeControls,	kOptionEntryOption,		"Journal",			"journal"],
	[kOptionTypeControls,	kOptionEntryOption,		"Map",				"map"],
	[kOptionTypeControls,	kOptionEntryHeading, "In Menus"],
	[kOptionTypeControls,	kOptionEntryOption,		"Select",			"uiselect"],
	[kOptionTypeControls,	kOptionEntryOption,		"Cancel",			"uicancel"],
	[kOptionTypeControls,	kOptionEntryOption,		"Previous Tab",		"uiprevious"],
	[kOptionTypeControls,	kOptionEntryOption,		"Next Tab",			"uinext"],
	
	[kOptionTypeAudio,		kOptionEntryOption, "Total Volume", "total_volume"],
	[kOptionTypeAudio,		kOptionEntryOption, "Music Volume", "music_volume"],
	[kOptionTypeAudio,		kOptionEntryOption, "World Volume", "sfx_volume"],
	[kOptionTypeAudio,		kOptionEntryOption, "Speech Volume", "speech_volume"],
];