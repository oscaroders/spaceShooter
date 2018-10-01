class Player extends Objects
{
	float playerSpeed;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;

	}

	void update()
	{

		float xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		float yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;

		draw();
	}

	void draw()
	{


		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);
	}


}
