int score;
Bullet[] b;
int bulletCounter;
int maxBullet = 1000;
int shootCounter;
int bulletSpray;

	void checkAndWriteScore()
	{

		textSize(20);
		textAlign(LEFT);
		fill(255, 255, 255);
		text("Score: " + score, 100, 100);

	}

	void enemyBulletDraw()
	{
<<<<<<< HEAD
		

		// for(int i = 0; i < maxBullet; i++)
		// {
		// 	for (int j = 0; j < 10; ++j) 
		// 	{
				
		// 		if(b[i] instanceof Bullet)
		// 		{
		// 			b[i].setBulletDirection(gameManager.getEnemyList()[j].getDirection());
		// 			b[i].update();
		// 		}
		// 	}

		// }
	}
=======
			for(int i = 0; i < maxBullet; i++)
			{
				if(b[i] instanceof Bullet)
				{
					b[i].update();
				}
			}
		}
>>>>>>> 6f09e2594564bfb7aaf38cc90448eb9c79f71d02

	void enemySpawnBullet()
	{
		if (shootCounter % 100 == 0)
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
