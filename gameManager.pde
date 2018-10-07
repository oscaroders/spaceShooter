class GameManager
{
	Player lars;
	Enemy[] enemies;
	Asteroid asteroid;
	Asteroid asteroid2;
	Asteroid asteroid3;
	PVector[] starPos;
	boolean firstItt;
	boolean gameOverScreen;
	boolean firstSpawn;
	int backgcount = 0;
	int maxNumberOfEnemies = 10;
	int numberOfStars = 500;

	public GameManager()
	{
		lars = new Player(width/2, height/2);
		enemies = new Enemy[maxNumberOfEnemies];
		asteroid = new Asteroid();
		asteroid2 = new Asteroid();
		asteroid3 = new Asteroid();
		starPos = new PVector[numberOfStars];
		boolean gameOverScreen = false;
		gameOverCounter = 0;
		firstItt = true;
		firstSpawn = true;
		score = 0;
	}

	void update()
	{
		if (!play)
		{
			startScreen();
		} else {
			drawBackground();
			asteroid.draw();
			asteroid2.draw();
			asteroid3.draw();
			if (gameOverScreen == false)
			{
				playerAsteroidCollision();
				if (millis() > 5000)
				{
					if(firstSpawn)
					{
						b = new Bullet[maxBullet];
						spawnEnemy(10);
						firstSpawn = false;
					}
					checkPlayerCollision();
					checkEnemyCollision();
					enemyBulletDraw();
					for(int i = 0; i < maxNumberOfEnemies; i++)
					{
						enemies[i].update();
					}
				}
				lars.update();
				checkAndWriteScore();
			}
			if (gameOverScreen == true)
			{
				gameOver();
				if(keyPressed && key == 'r')
					setup();
			}
		}
	}

	void drawBackground()
	{
		background(spaceBlue);
		if(firstItt)
		{
			generateBackground();
			firstItt = false;
		}
		for(int i = 0; i < numberOfStars; i++){
			if(backgcount % (int)random(7, 23) == 0)
			{
				stroke(lightYellow);
				strokeWeight(random(2, 5));
			} else {
				stroke(yellow);
				strokeWeight(2);
			}
			point(starPos[i].x, starPos[i].y);
			backgcount++;
		}
	}

	void generateBackground()
	{
		for(int i = 0; i < numberOfStars; i++){
			starPos[i] = new PVector(random(0, width), random(0, height));
		}
	}

	void playerAsteroidCollision()
	{
		if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
			gameOverScreen = true;
		if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
			gameOverScreen = true;
		if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
			gameOverScreen = true;
	}

	void spawnEnemy(int w)
	{
		if(w == 10){
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
		}
		if(w < 7)
		{
			if ((enemies[w] instanceof Enemy))
			{
				enemies[w] = new EnemyEasy();
			}
		}
		if(w > 5 && w < 9)
		{
			if ((enemies[w] instanceof Enemy))
			{
				enemies[w] = new EnemyMedium();
			}
		}
		if(w == 9)
		{
			if ((enemies[maxNumberOfEnemies - 1] instanceof Enemy))
			{
				enemies[maxNumberOfEnemies - 1] = new EnemyHard();
			}
		}
	}

	void checkPlayerCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; i++)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size / 2, enemies[i].position.x, enemies[i].position.y, enemies[i].size / 2);
			if (colider)
			{
				gameOverScreen = true;
			}
			for (int j = 0; j < 100; j++)
			{
				if(b[j] instanceof Bullet)
				{
				 	if (collision(lars.position.x, lars.position.y, lars.size / 2, b[j].position.x, b[j].position.y, b[j].size / 2))
				 	{
						if( gameManager.lars.life == 0){
							gameOverScreen = true;
						} else {
							gameManager.lars.life -= 1;
						}
				 	}
				}
			}
		}
	}

	void checkEnemyCollision()
	{
		for(int i = 0; i < maxNumberOfEnemies; i++)
		{
			if(enemies[i] instanceof Enemy)
			{
				for(int j = 0; j < 100; j++)
				{
					if(lars.b[j] instanceof Bullet)
					{
						if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, lars.b[j].position.x, lars.b[j].position.y, lars.b[j].size))
						{
							spawnEnemy(i);
							if(enemies[i] instanceof EnemyEasy)
								score++;
							if(enemies[i] instanceof EnemyMedium)
								score += 4;
							if(enemies[i] instanceof EnemyHard)
								score += 8;
						}
					}
				}
			}
		}
		for(int i = 0; i < maxNumberOfEnemies; i++)
		{
			if(enemies[i] instanceof Enemy)
			{
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
					spawnEnemy(i);
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
					spawnEnemy(i);
			  if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
					spawnEnemy(i);
			}
		}
	}

	Enemy[] getEnemyList()
	{
		return enemies;
	}
}
