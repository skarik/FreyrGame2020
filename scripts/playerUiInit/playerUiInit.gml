m_inCutscene = false;
m_inCutsceneBlend = 0.0;

m_astrolabeForceBlend = 0.0;

m_hiddenEdgeBlend = 0.0;

#region Inventory

m_bag_offsets = [
	[28, 10], [52, 10], [76, 10], [100, 10], [124, 10], [148, 10], [172, 10],
	[28, 34], [52, 34], [76, 34], [100, 34], [124, 34], [148, 34], [172, 34],
	[28, 58], [52, 58], [76, 58], [100, 58], [124, 58], [148, 58], [172, 58],
			  [52, 82],									[148, 82]
];

m_seed_offsets = [
	[23, 11], [47, 11], [71, 11], [95, 11], [119, 11], [143, 11], [172, 11],
	[23, 35], [47, 35], [71, 35], [95, 35], [119, 35], [143, 35], [172, 35],
	[23, 59], [47, 59], [71, 59], [95, 59], [119, 59], [143, 59], [172, 59]
];

m_bag_base_x = 0;
m_bag_base_y = 0;
m_bag_selection = null;
m_bag_hover = null;

m_seed_base_x = 0;
m_seed_base_y = 0;
m_seed_selection = null;
m_seed_hover = null;

m_sbag_blend = 0.0;
m_sbag_seeds = false;

m_belt_base_x = 0;
m_belt_base_y = 0;
m_belt_selection = null;
m_belt_hover = null;

m_chest_base_x = 0;
m_chest_base_y = 0;
m_chest_selection = null;
m_chest_hover = null;

#endregion

#region Book Menus

m_book_offsets_main = [
	[47, 54], [101, 57],
	[37, 133], [79, 146], [112, 125],
	
	[223, 50], // yes
	[222, 132], // no
];

m_book_base_x = 0;
m_book_base_y = 0;

m_book_main_selection = null;
m_book_main_hover = null;

enum Tabs {
	kMain,
	kOptions,
	kMap,
	kRelationship
};

m_book_tab = Tabs.kMain;

#endregion

#region Arm Scripting

m_arm_center_blend = 0.0;
m_arm_flash = 0.0;
m_arm_voidcap_draw_intro = 0.0;
m_arm_voidcap_blend = 0.0;

#endregion