class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	boolean firstItt;
	int numberOfStars;
	PVector[] starPos;
	int backgcount = 0;


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
		spawnEnemy();
		checkPlayerCollision();
		checkEnemyCollision();

		for(int i = 0; i < maxNumberOfEnemies; i++){
			enemies[i].update();
		}

		lars.update();

	}


	void checkPlayerCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; i++)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size / 2, enemies[i].position.x, enemies[i].position.y, enemies[i].size / 2);
			if (colider)
			{
				gameOver();
			}

			for (int j = 0; j < 100; j++)
			{
				if(enemies[i].b[j] instanceof Bullet){
				 if (collision(lars.position.x, lars.position.y, lars.size, enemies[i].b[j].position.x, enemies[i].b[j].position.y, enemies[i].b[j].size))
				 {
				 	gameOver();
				 }
			 }
			}
		}
	}

	void checkEnemyCollision(){
		for(int i = 0; i < maxNumberOfEnemies; i++){
			if(enemies[i] instanceof Enemy){
				for(int j = 0; j < maxNumberOfEnemies; j++){
					if(lars.b[j] instanceof Bullet){
						if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, lars.b[j].position.x, lars.b[j].position.y, lars.b[j].size)){
							// how to remove enemies?
						}
					}
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
				enemies[i] = new EnemyEasy();
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

	void drawBackground(){
  background(spaceBlue);

  if(firstItt){
    generateBackground();
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

}
