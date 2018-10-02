class GameManager
{

	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	int actualNumberOfEnemies = 0;

	public GameManager()
	{
		enemies = new Enemy[3];
	}



	void update(){

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