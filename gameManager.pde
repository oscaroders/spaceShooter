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

		boolean collider = collision();

		if (collider)
		{
	  		if ()
     		{

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
	
}