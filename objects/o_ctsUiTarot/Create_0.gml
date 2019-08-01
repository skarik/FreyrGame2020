/// @description Initial state

depth = -9004;

controlInit();

m_ending = false;

// set up available deck
#macro kTarotSuitStaves 0
#macro kTarotSuitCups 1
#macro kTarotSuitSwords 2
#macro kTarotSuitRings 3
#macro kTarotValueAce 1

m_deck[0] = [kTarotSuitStaves, kTarotValueAce, sui_tarotStaveAce, tarotStavesAce];
m_deck[1] = [kTarotSuitCups, kTarotValueAce, sui_tarotCupAce, tarotCupsAce];
m_deck[2] = [kTarotSuitSwords, kTarotValueAce, sui_tarotSwordAce, tarotSwordsAce];
m_deck[3] = [kTarotSuitRings, kTarotValueAce, sui_tarotRingAce, tarotRingsAce];

// set up game state
m_card_selection[0] = -1;
m_card_selection[1] = -1;
m_card_selection[2] = -1;
m_card_flipped[0] = false;
m_card_flipped[1] = false;
m_card_flipped[2] = false;

#macro kTarotGameState_FortuneGenerate 0
#macro kTarotGameState_FortuneDeal 1
#macro kTarotGameState_FortuneChoose 2
#macro kTarotGameState_FortuneChosen 3
#macro kTarotGameState_FortuneGiven 4
m_state = kTarotGameState_FortuneGenerate;

m_state_blend_background = 0.0;
m_state_blend_deal = 0.0;
m_state_blend_select = 0.0;
m_state_blend_select_remove = 0.0;
m_state_blend_select_continue = 0.0;
m_state_blend_panout = 0.0;

m_state_selection = 1;

// create tarot cards
m_card[0] = instance_create_depth(0, -500, depth, o_ctsUiTarotCard);
m_card[1] = instance_create_depth(0, -500, depth, o_ctsUiTarotCard);
m_card[2] = instance_create_depth(0, -500, depth, o_ctsUiTarotCard);