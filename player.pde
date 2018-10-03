class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;

	Bullet[] b;
	int bulletCounter;
	int maxBullet = 100;
	float size;

	float direction;
	float dY;
	float dX;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 6f;
		b = new Bullet[maxBullet];
		size = 50;
	}

	void update()
	{

		// xMovement = getAxisRaw("Horizontal") * playerSpeed;
		//
		// position.x += xMovement;
		//
		// yMovement = getAxisRaw("Vertical") * playerSpeed;
		//
		// position.y += yMovement;
		playerRotation();

		if(keyPressed && (key == 'a' || key == 'd')){
			dX = cos(direction * getAxisRaw("Horizontal")) * playerSpeed;
			dY = sin(direction * getAxisRaw("Horizontal")) * playerSpeed;
			direction += 0.05f;
		}

			position.x += dX;
			position.y += dY;




		fire();
		bulletDraw();
		draw();

	}

	void draw()
	{

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

	void playerRotation()
	{
		rotation.set(dX, dY);
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
			bulletCounter++;
			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}
	}

	void bulletDraw(){

		for(int i = 0; i < maxBullet; i++){
			if(b[i] instanceof Bullet){
				b[i].setBulletDirection(rotation);
				b[i].update();
			}
		}
	}
}
