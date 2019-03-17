stepper += Time.deltaTime * 60.0;
if (stepper >= 8.0)
{
	delete(this);
}