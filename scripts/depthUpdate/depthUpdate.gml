//depth = -y / 2.0 - (z + z_height *  0.5) / 2.0;

// var y_zero = y + z;
// depth = -(y_zero + z + z_height);
//depth = -(y + z + z + z_height);

var y_zero = y + z;
depth = -(y_zero + (z + z_height) / 2.0) / 2.0;