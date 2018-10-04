class GameManager
{
	Player lars;
	int life = 100;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	boolean firstItt;
	int numberOfStars;
	PVector[] starPos;
	int backgcount = 0;
	boolean gameOverScreen = false;
	float endTime;
	int gameOverCounter = 0;
	boolean firstSpawn = true;
	Asteroid asteroid;
	Asteroid asteroid2;
	Asteroid asteroid3;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
		numberOfStars = 500;
		starPos = new PVector[numberOfStars];
		score = 0;
		asteroid = new Asteroid();
		asteroid2 = new Asteroid();
		asteroid3 = new Asteroid();
	}

	void update()
	{
		if (!play)
		{
			startScreen();

		}

		else
		{

			drawBackground();
			asteroid.draw();
			asteroid2.draw();
			asteroid3.draw();

			if (gameOverScreen == false)
			{
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
					gameOverScreen = true;
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
					gameOverScreen = true;
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
					gameOverScreen = true;

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

	void checkEnemyCollision(){
		for(int i = 0; i < maxNumberOfEnemies; i++){
			if(enemies[i] instanceof Enemy){
				for(int j = 0; j < 100; j++){
					if(lars.b[j] instanceof Bullet){
						if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, lars.b[j].position.x, lars.b[j].position.y, lars.b[j].size)){
							spawnEnemy(i);
						}
					}
				}
			}
		}
		for(int i = 0; i < maxNumberOfEnemies; i++){
			if(enemies[i] instanceof Enemy){
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
					spawnEnemy(i);
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
					spawnEnemy(i);
			  if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
					spawnEnemy(i);
			}
		}
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
				score++;
			}
		}

		if(w > 5 && w < 9)
		{
			if ((enemies[w] instanceof Enemy))
			{
				enemies[w] = new EnemyMedium();
				score += 2;
			}
		}

		if(w == 9)
		{
				if ((enemies[maxNumberOfEnemies - 1] instanceof Enemy))
				{
					enemies[maxNumberOfEnemies - 1] = new EnemyHard();
					score += 3;
				}
		}
	}

	void gameOver()
	{
		int[] highScore;
		highScore = new int[3];
		highScore = getHighScore();

		currentTime = millis() / 1000;

		if (gameOverCounter == 0)
		{
		 	endTime = currentTime;
			saveHighScore();
		}

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/10);

		textAlign(CENTER);

		text("Time: " + endTime + " seconds", width/2,  height/6);
		gameOverCounter++;

		textAlign(CENTER);
		text("Score: " + score + "\n High Score: \n 1st: " + highScore[0] + "\n 2nd: " + highScore[1] + "\n 3rd: " + highScore[2], width/2,  height/4);

		fill(255, 0, 0);
		textAlign(CENTER);
		text("Press r to reset the game!", width/2,  height/2 + height /5);
	}

	void drawBackground(){
  background(spaceBlue);

  if(firstItt){
    generateBackground();
    firstItt = false;
  }

  for(int i = 0; i < numberOfStars; i++){
    if(backgcount % (int)random(7, 23) == 0){
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

void generateBackground(){
  for(int i = 0; i < numberOfStars; i++){
    starPos[i] = new PVector(random(0, width),
                             random(0, height));
  }
}


	Enemy[] getEnemyList()
	{
		return enemies;
	}


	void startScreen()
	{
		background(0);

  		image(img1, 50, 500, width/2, height/2);

  		image(img2, 900, 100, width/2, height/2);

		textSize(50);
		textAlign(CENTER);
		fill(255, 100, 255);
		text("Space Shooter 1.0", width/2, height/5);

		textAlign(CENTER);
		fill(255, 100, 255);
		text("-----------------", width/2, height/4.5);

		textAlign(CENTER);
		fill(255, 150, 0);
		text("PRESS P TO START THE GAME!", width/2, height/2 + height/20);
	}

}
