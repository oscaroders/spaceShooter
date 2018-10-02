class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	boolean firstItt;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
	}

	void update()
	{

		spawnEnemy();
		checkCollision();
		lars.update();

	}


	void checkCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; ++i)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size, enemies[i].position.x, enemies[i].position.y, enemies[i].size);
			if (colider)
			{
				gameOver();
			}

			for (int j = 0; j < 100; ++j)
			{
				 if (collision(lars.position.x, lars.position.y, lars.size,enemies[i].b[j].position.x, enemies[i].b[j].position.y, enemies[i].b[j].size))
				 {
				 	gameOver();
				 }

			}

	}
}

	void spawnEnemy()
	{
		if(firstItt){
			for (int i = 0; i < maxNumberOfEnemies; i++)
			{
				if (i < 6)
				{
					enemies[i] = new EnemyEasy();
				}
				if (i > 5 && i < 9)
				{
					enemies[i] = new EnemyMedium();
				}
				if (i > 8)
				{
					enemies[i] = new EnemyHard();
				}
			}
			firstItt = false;
		}

		for (int i = 0; i < 6; ++i) 
		{
			if (!(enemies[i] instanceof Enemy)) 
			{
				enemies[i] = new EnmeyEasy();
			}
		}

		for (int i = 6; i < 9; ++i) 
		{
			if (!(enemies[i] instanceof Enemy)) 
			{
				enemies[i] = new EnemyMedium();
			}
		}

		if (!(enemies[maxNumberOfEnemies - 1] instanceof Enemy)) 
			{
				enemies[maxNumberOfEnemies - 1] = new EnemyHard();
			}


	}

	void gameOver()
	{

		currentTime = millis() / 1000;

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/2);

		textAlign(CENTER);
		text("Time: " + currentTime + " seconds", width/2, height/2 + height/10);
	}

}
