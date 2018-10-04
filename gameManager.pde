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


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
		numberOfStars = 500;
		starPos = new PVector[numberOfStars];
	}

	void update()
	{

		drawBackground();


		if (gameOverScreen == false)
		{
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


		currentTime = millis() / 1000;

		if (gameOverCounter == 0)
		{
		 	endTime = currentTime;
		}

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/2);

		textAlign(CENTER);

		text("Time: " + endTime + " seconds", width/2, height/2 + height/10);
		gameOverCounter++;

		textAlign(CENTER);
		text("Score: " + score, width/2, height/2 + height/20);
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

}
