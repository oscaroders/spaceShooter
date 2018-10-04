class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;
	int life;

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
		life = 1000;
	}

	void update()
	{

		playerRotation();
 		if(moveUp || moveDown){
			if(playerSpeed > 3)
				playerSpeed += getAxisRaw("Vertical") * 0.1;
			if(playerSpeed <= 3)
				playerSpeed = 3.1;
		}

		if(moveLeft || moveRight){
			dX = cos(direction) * playerSpeed;
			dY = sin(direction) * playerSpeed;
			direction += 0.05f * getAxisRaw("Horizontal");
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

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
		fill(255, 0, 0);
		text(life, position.x, position.y);
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

	void bounderies(){
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
}
