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
			collision(lars.position.x, lars.position.y, size, size)	
		}
		
		boolean collider = collision();

		if (collider)
		{
	  		
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
	
}