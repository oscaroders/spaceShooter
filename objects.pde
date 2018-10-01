class Objects
{

	PVector rotation;
   	PVector velocity;
   	PVector position;

  public Objects()
{
    position = new PVector();

    int side2side = (int)random(1, 4.99);
    if (side2side == 1)
    {
    	position.x = random(-50, -5);
    	position.y = random(0, height);
    }
    if (side2side == 2)
    {
    	position.x = random(0, width);
    	position.y = random(-50, -5);
    }
    if (side2side == 3)
    {
    	position.x = random(width + 5, width + 50);
    	position.y = random(0, height);
    }
    if (side2side == 4)
    {
    	position.x = random(0, width);
    	position.y = random(height + 5, height + 50);
    }

  }

  public Objects(float x, float y)
  {
    position = new PVector(x, y);
    rotation = new PVector(x, y);
  }
}
