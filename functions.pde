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
		b = new Bullet[maxBullet];

		for(int i = 0; i < maxBullet; i++)
		{

			if(b[i] instanceof Bullet)
			{
				b[i].setBulletDirection(gameManager.getEnemyList().getDirection());
				b[i].update();
			}

		}
	}

	void enemySpawnBullet()
	{	
		if (shootCounter % 100 == 0)
		{
			b[bulletCounter] = new BulletEnemy(position.x, position.y);
			bulletCounter++;

			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}

		shootCounter++;
	}



