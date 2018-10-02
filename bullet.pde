class Bullet extends Objects
{
	boolean firstItt;
	float directionX;
	float directionY;
	float speed = 20;
	float size = 5;

	public Bullet(float x,float y)
	{

		super(x,y);
		firstItt = true;
	}

	void update()
	{
		//setBulletDirection();
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

	void draw()
	{
		fill(0, 0, 255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size / 2, size / 2);
	}

	void setBulletDirection(PVector direction){
		if(firstItt){
			directionX += direction.x;
			directionY += direction.y;
			firstItt = false;
		}
	}
}
