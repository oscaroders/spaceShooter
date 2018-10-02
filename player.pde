class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;
	Bullet[] b;
	int bulletCounter;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;
		b = new Bullet[100];

	}

	void update()
	{

		xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;

		fire();
		playerRotation();
		draw();
	}

	void draw()
	{

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);
	}

	void playerRotation()
	{
		rotation.set(xMovement, yMovement);
		rotation.normalize();
		position.add(rotation);
		line(position.x, position.y, position.x + rotation.x * 25, position.y + rotation.y * 25);
	}

    PVector getPlayerPosition()
	{
		return position;
	}

	void fire()
	{
		if (fire)
		{
			b[bulletCounter] = new Bullet(position.x, position.y);
			b[bulletCounter].update(); // make into a for loop that draws all balls in a function.
			bulletCounter++;
			if (bulletCounter == 99)
			{
				bulletCounter = 0;
			}

		}

	}
}
