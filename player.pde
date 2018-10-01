class Player extends Objects
{

	public Player(float x, float y)
	{
		super(x,y);

	}

	void update()
	{
		draw();
	}

	void draw()
	{
		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);
	}


}