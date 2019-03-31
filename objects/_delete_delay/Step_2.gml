time += Time.deltaTime;

if (time > delay)
{
	delete(target);
	delete(this);
}