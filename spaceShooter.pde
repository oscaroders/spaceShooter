
Player lars;
Enemy knut;

void setup()
{
	size(500, 500);
	lars = new Player(width/2, height/2);
	knut = new Enemy();
}

void draw()
{
	background(255);
	lars.update();
	knut.update();
}
