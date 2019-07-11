// Apply gravity
zspeed -= zgravity * Time.deltaTime;

// Apply motion
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;
z_height += zspeed * Time.deltaTime;


depthUpdate();