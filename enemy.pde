class Enemy extends Objects
{
	PVector direction;
	float size;


	public Enemy()
	{
		super();
		direction = new PVector();
		size = 50;

	}

	void update()
	{
		moveToPlayerPosition();

		if ((position.x > 0 && position.x < width) && (position.y > 0 && position.y < height))
		{
			enemyfire();
		}

		draw();
	}

	void draw()
	{

		fill(0, 255, 0);
		//ellipseMode(CENTER);
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
		enemySpawnBullet();
	}

	PVector getDirection(){
		return direction;
	}
}
