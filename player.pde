class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;

	Bullet[] b;
	int bulletCounter;
	int maxBullet = 100;


	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;
		b = new Bullet[maxBullet];

	}

	void update()
	{

		xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;


		playerRotation();
		draw();
		fire();
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
			bulletDraw();
			bulletCounter++;
			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}
	}

	void bulletDraw(){

		for(int i = 0; i < maxBullet; i++){
			if(b[i] intanceOf Bullet)
				b[i].update();
		}
	}
}
