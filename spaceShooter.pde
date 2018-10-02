GameManager gameManager;

float deltaTime;
long currentTime;
float time;

void setup()
{
	size(500, 500);
	gameManager = new GameManager();
}

void draw()
{
	currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;
	background(255);
	gameManager.update();
	time = currentTime;
}




