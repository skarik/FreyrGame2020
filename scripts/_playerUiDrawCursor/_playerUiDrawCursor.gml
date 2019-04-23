// aimer
var dx = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
var dy = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

draw_set_color(c_black);
draw_rectangle(dx - 3, dy - 1, dx + 3, dy + 1, false);
draw_rectangle(dx - 1, dy - 3, dx + 1, dy + 3, false);
draw_set_color(c_gold);
draw_line(dx - 3, dy, dx + 2, dy);
draw_line(dx, dy - 3, dx, dy + 2);