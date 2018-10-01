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
		moveToCenter();
		draw();
	}

	void draw()
	{

		fill(0, 255, 0);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);

	}

	void moveToCenter()
	{
		
        direction.set(lars.getPlayerPosition().x - position.x, lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}

}
