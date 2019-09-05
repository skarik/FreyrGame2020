#macro kControlKB 0
#macro kControlMouse 1 
#macro kControlGamepad 2

#macro kMouseWheelUp 0x101
#macro kMouseWheelDown 0x102

with (Settings)
{
	ctMoveLeft		= [kControlKB, ord("A"), kControlGamepad, -gp_axislh];
	ctMoveRight		= [kControlKB, ord("D"), kControlGamepad, gp_axislh];
	ctMoveUp		= [kControlKB, ord("W"), kControlGamepad, -gp_axislv];
	ctMoveDown		= [kControlKB, ord("S"), kControlGamepad, gp_axislv];
	ctJump			= [kControlKB, vk_space];
	
	ctAimLeft		= [kControlKB, vk_left, kControlGamepad, -gp_axisrh];
	ctAimRight		= [kControlKB, vk_right, kControlGamepad, gp_axisrh];
	ctAimUp			= [kControlKB, vk_up, kControlGamepad, -gp_axisrv];
	ctAimDown		= [kControlKB, vk_down, kControlGamepad, gp_axisrv];
	
	ctAttack		= [kControlMouse, mb_left, kControlGamepad, gp_face1, kControlGamepad, gp_shoulderr];
	ctUse			= [kControlMouse, mb_left, kControlGamepad, gp_face1];
	ctUseItem		= [kControlKB, ord("F"), kControlGamepad, gp_face2];
	ctDodge			= [kControlMouse, mb_right, kControlGamepad, gp_shoulderl];
	
	ctInventory		= [kControlKB, ord("I"), kControlGamepad, gp_select, kControlGamepad, gp_padu];
	ctJournal		= [kControlKB, ord("Q"), kControlKB, vk_tab, kControlGamepad, gp_start];
	ctMap			= [kControlKB, ord("M")];
	
	ctItem1			= [kControlKB, ord("1")];
	ctItem2			= [kControlKB, ord("2")];
	ctItem3			= [kControlKB, ord("3")];
	ctItem4			= [kControlKB, ord("4")];
	ctItem5			= [kControlKB, ord("5")];
	ctItem6			= [kControlKB, ord("6")];
	ctItemPrevious	= [kControlMouse, kMouseWheelDown, kControlGamepad, gp_padl];
	ctItemNext		= [kControlMouse, kMouseWheelUp, kControlGamepad, gp_padr];
	
	ctUiPrevious	= [kControlKB, vk_pageup, kControlGamepad, gp_shoulderl, kControlMouse, kMouseWheelDown];
	ctUiNext		= [kControlKB, vk_pagedown, kControlGamepad, gp_shoulderr, kControlMouse, kMouseWheelUp, kControlMouse, mb_middle];
	ctUiSelect		= [kControlMouse, mb_left, kControlKB, vk_enter, kControlGamepad, gp_face1];
	ctUiCancel		= [kControlMouse, mb_right, kControlKB, vk_escape, kControlGamepad, gp_face2, kControlGamepad, gp_face4];
}