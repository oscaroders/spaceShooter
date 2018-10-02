GameManager gameManager;

void setup()
{
	size(500, 500);
	gameManager = new GameManager();
}

void draw()
{
	background(255);
	gameManager.update();

}
