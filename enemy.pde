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

        direction.set(lars.getPlayerPosition().x - position.x, lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}




}
