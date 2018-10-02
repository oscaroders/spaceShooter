class Bullet extends Objects
{

	public Bullet(float x,float y)
	{

		super(x,y);

	}

	void update()
	{
		draw();

	}

	void draw()
	{
		fill(0, 0, 255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 20, 20);

	}


}
