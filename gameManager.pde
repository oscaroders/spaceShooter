class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	int actualNumberOfEnemies = 0;


	public GameManager()
	{
		enemies = new Enemy[3];
		lars = new Player(width/2, height/2);
	}

	void update()
	{


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
		}
		
	}
	void spawnEnemy()
	{


		enemies[maxNumberOfEnemies] = new Enemy();
		enemies[actualNumberOfEnemies].update(); 

		if (actualNumberOfEnemies >= maxNumberOfEnemies) 
		{
		  	
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