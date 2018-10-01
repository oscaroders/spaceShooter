class Objects
{

	PVector velocity;
  PVector position;

  public Objects()
{
    position = new PVector();
    position.x = random(); // ???
    position.y = random(); // ????
  }

  public Objects(float x, float y)
  {
    position = new PVector(x,y);
  }
}
