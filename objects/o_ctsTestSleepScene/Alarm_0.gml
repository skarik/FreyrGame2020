/// @description disable player

cutscenePlayerLock();

var pl = getPlayer();
//s_charHeroSleepSnore
aiscriptRequestAnimation(pl, kAiStyle_Default, "sleepSnore", true, 4);
pl.x = x;
pl.y = y;

if (!iexists(o_chNathan))
{
	inew(o_chNathan);
}

var nathan = instance_find(o_chNathan, 0);
//aiscriptRequestAnimation(o_chNathan, kAiStyle_Default, "sitReadBook", true, 4);
nathan.kAnimStanding = s_charNathanReadBook;
nathan.y = pl.y;
nathan.x = pl.x + 13;