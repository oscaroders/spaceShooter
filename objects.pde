class Objects
{

	PVector rotation;
   	PVector velocity;
   	PVector position;

  public Objects()
{
    position = new PVector();
     position.x = random(2000, 1600);
     position.y = random(2000, 1600);
  }

  public Objects(float x, float y)
  {
    position = new PVector(x, y);
    rotation = new PVector(x, y);
  }
}
