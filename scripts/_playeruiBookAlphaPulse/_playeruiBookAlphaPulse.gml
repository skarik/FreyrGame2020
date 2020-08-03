//return floor((sin(current_time / 1000 * 5.0) * 0.4 + 0.8) * 5) / 5.0;
//return floor((sin(current_time / 1000 * 5.0) * 0.4 + 0.8) * 10) / 10.0;

var value = sin(current_time / 1000 * 5.0) * 0.4 + 0.8;
var value_mul = value * 5;
var lower = floor(value_mul);
var upper = ceil(value_mul);
var percent = (value_mul - lower)/(upper - lower);
return lerp(lower, upper, circInOut(percent)) / 5;