GameManager gameManager;

PImage img1;
PImage img2;
float deltaTime;
long currentTime;
float time;

void setup()
{
	size(1920, 1080);
	img1 = loadImage("spaceShip.jpg");
	img2 = loadImage("sun.jpg");
	gameManager = new GameManager();
}

void draw()
{
	currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;

	gameManager.update();

	time = currentTime;
}
