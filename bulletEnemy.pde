class BulletEnemy extends Bullet
{
  float directionX;
	float directionY;
  float speed;
  float size;

  public BulletEnemy(float x, float y)
  {
    super(x, y);
    speed = 2;
    size = 20;
  }

  void update()
	{
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

  void draw()
  {
    noStroke();
    fill(255, 105, 180);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size / 2, size / 2);
  }

  void setBulletDirection(PVector direction)
  {
    if(first){
      directionX += direction.x;
      directionY += direction.y;
      first = false;
    }
  }
}
