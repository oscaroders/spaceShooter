class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;

	}

	void update()
	{

		xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;

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
}
