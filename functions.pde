int score;
Bullet[] b;
int bulletCounter;
int maxBullet = 100;
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

	void enemySpawnBullet()
	{	
		if (shootCounter % 100 == 0)
		{
			for (int j = 0; j < 10; ++j) 
			{
				b[bulletCounter] = new BulletEnemy(gameManager.getEnemyList()[j].getPosition().x, gameManager.getEnemyList()[j].getPosition().y);
				bulletCounter++;

				if (bulletCounter == maxBullet - 1)
				{
					bulletCounter = 0;
				}
			}
			
			
		}

		shootCounter++;
	}



