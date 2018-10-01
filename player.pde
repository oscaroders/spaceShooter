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

		ellipseMode(CENTER);
		ellipse(position.x, position.y, width/2, height/2);
	}


}