/// @description Motion & life


// Motion:
x += lengthdir_x(mspeed, mdirection) * Time.deltaTime;
y += lengthdir_y(mspeed, mdirection) * Time.deltaTime;
mspeed = max(0, mspeed - mfriction * Time.deltaTime);

// Life:
life -= Time.deltaTime;
if (life < 0.0)
{
	idelete(this);
}