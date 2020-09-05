/// @description Set audio based on quest

var IntroSequence = questGetValue(kQidIntroSequence);

if (IntroSequence < 1000)
{
	idelete(o_mus00_Mithra);
	inew_unique(o_mus00_FoolsMarch);
}
else
{
	idelete(o_mus00_FoolsMarch);
	inew_unique(o_mus00_Mithra);
}