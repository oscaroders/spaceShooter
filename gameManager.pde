class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	int actualNumberOfEnemies = 0;
	// int enemyCounter;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
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

			for (int j = 0; j < enemies[i].length; ++j) 
			{
				 if (collision(lars.position.x, lars.position.y, lars.size,enemies[i].b[j].position.x, enemies[i].b[j].position.y, enemies[i].b[j].size)) 
				 {
				 	gameOver();	
				 }
		
			}

	void spawnEnemy()
	{

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

		enemies[] = new Enemy();
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