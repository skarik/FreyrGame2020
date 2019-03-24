//@description Zero out inputs
//@param clear_all  If true, re-inits entire state.
if (argument0 == false)
{
	xAxis.value = 0.0;
	yAxis.value = 0.0;
	zAxis.value = 0.0;

	aButton.value = 0.0;
	bButton.value = 0.0;
	xButton.value = 0.0;
	yButton.value = 0.0;
	lButton.value = 0.0;
	rButton.value = 0.0;
}
else
{
	controlCleanup();
	controlInit();
}