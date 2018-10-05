class Player extends Objects
{
	Bullet[] b;
	float playerSpeed;
	float xMovement;
	float yMovement;
	float size;
	float direction;
	float dY;
	float dX;
	int bulletCounter;
	int life;
	int maxBullet = 100;

	public Player(float x, float y)
	{
		super(x,y);
		b = new Bullet[maxBullet];
		playerSpeed = 3f;
		size = 50;
		life = 500;
	}

	void update()
	{
		playerRotation();
 		if(moveUp || moveDown){
			if(playerSpeed > 3)
				playerSpeed += getAxisRaw("Vertical") * 0.5;
			if(playerSpeed <= 3)
				playerSpeed = 3.1;
		}
		if(moveLeft || moveRight){
			dX = cos(direction) * playerSpeed * deltaTime * 50;
			dY = sin(direction) * playerSpeed * deltaTime * 50;
			direction += 0.05f * getAxisRaw("Horizontal");
			println(playerSpeed);
		}
		position.x += dX;
		position.y += dY;
		fire();
		bulletDraw();
		bounderies();
		draw();
	}

	void draw()
	{
		noStroke();
		fill(255, 100, 50);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
		stroke(0);
		line(position.x, position.y, position.x + rotation.x * 25, position.y + rotation.y * 25);
		noStroke();
		fill(255, 0, 0);
		text(life, position.x, position.y);
	}

	void playerRotation()
	{
		rotation.set(dX, dY);
		rotation.normalize();
		position.add(rotation);
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

	void bulletDraw()
	{
		for(int i = 0; i < maxBullet; i++){
			if(b[i] instanceof Bullet){
				b[i].setBulletDirection(rotation);
				b[i].update();
			}
		}
	}

	void bounderies()
	{
		if(position.x < 0 - size / 2){
			position.x = width;
		}
		if(position.x > width + size / 2){
			position.x = 0;
		}
		if(position.y < 0 - size / 2){
			position.y = height;
		}
		if(position.y > height + size / 2){
			position.y = 0;
		}
	}

  PVector getPlayerPosition()
	{
		return position;
	}
}
