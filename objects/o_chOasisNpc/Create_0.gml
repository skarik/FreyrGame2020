/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var standing = [
	s_charOasis0Stand,
	s_charOasis1Stand,
	s_charOasis2Stand,
	s_charOasis3Stand
];

var selector = id % array_length_1d(standing);

kAnimStanding = standing[selector];