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
		image(imgA, position.x - size / 2, position.y - size / 2, 250, 250);
	}

	void bounderies()
	{
		if(position.x < 0 - size){
			position.x = width;
		}
		if(position.x > width + size){
			position.x = 0;
		}
		if(position.y < 0 - size){
			position.y = height;
		}
		if(position.y > height + size){
			position.y = 0;
		}
	}





}
