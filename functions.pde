Bullet[] b;
int score;
int bulletCounter;
int shootCounter;
int bulletSpray;
float endTime;
int maxBullet = 100;
int gameOverCounter = 0;

void enemyBulletDraw()
{
	for(int i = 0; i < maxBullet; i++)
	{
		if(b[i] instanceof Bullet)
		{
			b[i].update();
		}
	}
}

void checkAndWriteScore()
{
	int[] highScore = new int[3];
	highScore = getHighScore();
	if(highScore[0] < score)
	{
		 highScore[0] = score;
	}
	textSize(20);
	textAlign(LEFT);
	fill(255, 255, 255);
	text(" Score: " + score +
		  	"\n" + " High Score:" +
				"\n 1st: " + highScore[0], 100, 100);
}

void enemySpawnBullet()
{
	if (shootCounter % 1000 == 0)
	{
		for (int j = 0; j < 10; j++)
		{
			b[bulletCounter] = new BulletEnemy(gameManager.getEnemyList()[j].getPosition().x, gameManager.getEnemyList()[j].getPosition().y);
			b[bulletCounter].setBulletDirection(gameManager.getEnemyList()[j].getDirection());
			bulletCounter++;

			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}
	}
	shootCounter++;
}

void gameOver()
{
	int[] highScore = new int[3];
	highScore = getHighScore();
	currentTime = millis() / 1000;

	if (gameOverCounter == 0)
	{
		endTime = currentTime;
		saveHighScore();
	}
	textSize(50);
	textAlign(CENTER);
	fill(255, 255, 255);
	text("Game Over", width/2, height/10);

	textAlign(CENTER);

	text("Time: " + endTime + " seconds", width/2,  height/6);
	gameOverCounter++;

	textAlign(CENTER);
	text("Score: " + score + "\n High Score: \n 1st: " + highScore[0] + "\n 2nd: " + highScore[1] + "\n 3rd: " + highScore[2], width/2,  height/4);

	fill(255, 0, 0);
	textAlign(CENTER);
	text("Press r to reset the game!", width/2,  height/2 + height /5);
}
