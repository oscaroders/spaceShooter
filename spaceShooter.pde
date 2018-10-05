GameManager gameManager;

PImage img1, img2, imgA;

float deltaTime;
long currentTime;
float time;

void setup()
{
	size(1920, 1080);
	img1 = loadImage("spaceShip.jpg");
	img2 = loadImage("sun.jpg");
	imgA = loadImage("asteroid.png");
	gameManager = new GameManager();
}

void draw()
{
	currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;

	gameManager.update();

	time = currentTime;
}
