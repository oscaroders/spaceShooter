int score;
Bullet[] b;
int bulletCounter;
int maxBullet = 100;
int shootCounter;
int bulletSpray;

	void checkAndWriteScore()
	{
		int[] highScore;
		highScore = new int[3];
		highScore = getHighScore();

		if(highScore[0] < score){
			 highScore[0] = score;
		}

		textSize(20);
		textAlign(LEFT);
		fill(255, 255, 255);
		text(" Score: " + score +
				"\n" + " High Score:" +
				"\n 1st: " + highScore[0], 100, 100);


	}

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
