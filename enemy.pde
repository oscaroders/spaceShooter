class Enemy extends Objects
{
	PVector direction;



	public Enemy()
	{
		super();
		direction = new PVector();
	}

	void update()
	{
		moveToPlayerPosition();
		draw();
	}

	void draw()
	{

		fill(0, 255, 0);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);

		
		boolean collider = collision(Enemy.position.x, Enemy.position.y);

		if (collider)
		{
			if (Enemy)
			{

			}
		}

	}

	void moveToPlayerPosition()
	{

        direction.set(lars.getPlayerPosition().x - position.x, lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}




}
