class Enemy extends Objects
{
	PVector direction;
	float size;
	Bullet[] b;
	int bulletCounter;
	int maxBullet = 100;


	public Enemy()
	{
		super();
		direction = new PVector();
		size = 50;
		b = new Bullet[maxBullet];
	}

	void update()
	{
		moveToPlayerPosition();

		if ((position.x > 0 && position.x < width) && (position.y > 0 && position.y < height))
		{
			enemyfire();
		}

		bulletDraw();
		draw();
	}

	void draw()
	{

		fill(0, 255, 0);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);

	}

	void moveToPlayerPosition()
	{

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}

	void enemyfire()
	{
		if (millis()% 1000 == 0)
		{
			b[bulletCounter] = new Bullet(position.x, position.y);
			bulletCounter++;
			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}
	}

	void bulletDraw()
	{

		for(int i = 0; i < maxBullet; i++)
		{
			if(b[i] instanceof Bullet)
			{
				b[i].update();
			}

		}
	}





}
