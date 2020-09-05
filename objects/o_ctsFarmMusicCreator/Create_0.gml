/// @description Create music after initial cts

if (questGetValue(kQidIntroSequence) > 20)
{
	if (!iexists(o_mus00_Oasis))
	{
		inew(o_mus00_Oasis);
	}
}

//fmusic_fade_all(); // Breaks all music.

idelete(this);