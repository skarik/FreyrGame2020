/// @description Vslice menu

depth = -10;

#macro kiVSliceMenuTitle 0
#macro kiVSliceMenuDesc 1
#macro kiVSliceMenuWillBreakSaves 2
#macro kiVSliceAction 3

menuListing = [
	["Play Game", "Play game from the start.", false, 0],
	["Load Game", "Load the last played game.", false, 1],
	["Get Farming", "Skip everything and just get to the farming, starting out with various seeds.", true, 2],
	["Combat Event", "Escorting the trader across Fool's March, fighting gobbos along the way.", true, 3],
	["Stealth Event", "Escape from the town of Mithra at night, escaping gaurds on that way.", true, 4],
	["Vendor Demo", "Places you next to a vendor with a good amount of items, to try out some trading. Head inside the tavern to the left for a second vendor.", true, 5],
	["Character Event: Nathan", "Character event: Cortez stumbles into Nathan's tent. Walk into Nathan's tent to begin.", true, 6],
	["Character Event: Go", "Character event: Aurum and Go hang out in Mithra. Walk left then up into the tavern to begin.", true, 7],
	["WIP: Tower & Atmosphere", "Unfinished area, the Fool's Tower. Acts as the game's first dungeon.", true, 8],
	["WIP: Tower B", "Unfinished area, the Fool's Tower. Acts as the game's first dungeon.", true, 11],
	//["WIP: Grapple Hook", "Use the grapple hook to traverse northwards to the next area.", true, 9],
	["WIP: Snow Concept", "Initial tests with snow effects for winter in Freyr.", true, 10],
];
menuDrawRects = [];

controlInit();

m_fadeIn = true;
image_alpha = 0.0;

m_menuHover = null;
m_menuSelection = null;

m_menuDescriptionSelection = null;
m_menuDescriptionAlpha = 0.0;