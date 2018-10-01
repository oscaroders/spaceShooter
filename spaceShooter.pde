
Player lars;
Bullet ulf;

void setup()
{
	size(1920, 1080);
	lars = new Player(width/2, height/2);
	ulf = new Bullet(width/2, height/2);
}

void draw()
{
	background(255);
	lars.update();
	ulf.update();
}
