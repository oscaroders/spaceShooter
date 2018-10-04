class Asteroid extends Objects
{

	float speedX;
	float speedY;
	int size = 250;

	public Asteroid()
	{
		position = new PVector(random(width), random(height));
		speedX += random(-1 , 1);
		speedY += random(-1, 1);
	}


	void draw()
	{
		bounderies();
		position.x += speedX;
		position.y += speedY;
		image(imgA, position.x, position.y, 250, 250);
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





}