//@description Zero out inputs
//@param clear_all  If true, re-inits entire state.
if (argument0 == false)
{
	xAxis.value = 0.0;
	yAxis.value = 0.0;
	zAxis.value = 0.0;
	
	uAxis.value = 0.0;
	vAxis.value = 0.0;
	wAxis.value = 0.0;

	aButton.value = 0.0;
	bButton.value = 0.0;
	cButton.value = 0.0;
	xButton.value = 0.0;
	yButton.value = 0.0;
	lButton.value = 0.0;
	rButton.value = 0.0;
	itemsButton.value = 0.0;
	selectButton.value = 0.0;
	cancelButton.value = 0.0;
	
	belt1Button.value = 0.0;
	belt2Button.value = 0.0;
	belt3Button.value = 0.0;
	belt4Button.value = 0.0;
	belt5Button.value = 0.0;
	belt6Button.value = 0.0;
}
else
{
	controlCleanup();
	controlInit();
}