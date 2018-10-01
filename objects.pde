class Objects
{

	PVector rotation;
   	PVector velocity;
   	PVector position;

  public Objects()
{
    position = new PVector();
     position.x = random(size * 2);
     position.y = random(size * 2);
  }

  public Objects(float x, float y)
  {
    position = new PVector(x, y);
    rotation = new PVector(x, y);
  }
}
