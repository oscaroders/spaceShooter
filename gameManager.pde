class GameManager
{

	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	int actualNumberOfEnemies = 0;

	public GameManager()
	{
		enemies = new Enemy[3];
	}



	void collision()
	{

		boolean collider = collision(Enemy.position.x, Enemy.position.y);

		if (collider)
		{
	  		if (Enemy)
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