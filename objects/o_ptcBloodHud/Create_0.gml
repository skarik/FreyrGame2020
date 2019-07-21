/// @description Select position and sprite

filltimer = 0;
m_damageType = 0;

// select position
x = choose( 0, GameCamera.width, random(GameCamera.width) );
if ( abs(x - GameCamera.width / 2) < (GameCamera.width / 2 - 10) ) {
	y = choose(0, GameCamera.height);
}
else {
	y = random(GameCamera.height);
}