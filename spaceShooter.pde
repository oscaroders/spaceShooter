
Player lars;

void setup()
{
	size(1920, 1080);
	lars = new Player(width/2, height/2);
}

void draw()
{
	background(255);
	lars.update();
}
