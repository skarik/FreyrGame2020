#macro kControlUvStyle_Mouse 0
#macro kControlUvStyle_FakeMouse 1 
#macro kControlUvStyle_Unused 2

xAxis = _controlStructCreate();
yAxis = _controlStructCreate();
zAxis = _controlStructCreate();
uAxis = _controlStructCreate();
vAxis = _controlStructCreate();
wAxis = _controlStructCreate();

itemUseButton = _controlStructCreate();
atkButton = _controlStructCreate();
useButton = _controlStructCreate();
dodgeButton = _controlStructCreate();
journalButton = _controlStructCreate();
yButton = _controlStructCreate();
itemPrevButton = _controlStructCreate();
itemNextButton = _controlStructCreate();
itemsButton = _controlStructCreate();
selectButton = _controlStructCreate();
cancelButton = _controlStructCreate();
prevUiButton = _controlStructCreate();
nextUiButton = _controlStructCreate();

belt1Button = _controlStructCreate();
belt2Button = _controlStructCreate();
belt3Button = _controlStructCreate();
belt4Button = _controlStructCreate();
belt5Button = _controlStructCreate();
belt6Button = _controlStructCreate();

uPosition = GameCamera.width / 2;
vPosition = GameCamera.height / 2;
uPositionPrevious = uPosition;
vPositionPrevious = vPosition;

prevUPositionMouse = 0.0;
prevVPositionMouse = 0.0;

windowMouseXPrevious = 0.0;
windowMouseYPrevious = 0.0;

uPositionScreen = GameCamera.width / 2;
vPositionScreen = GameCamera.height / 2;

uvPositionStyle = kControlUvStyle_Mouse;

lastControlType = kControlKB;