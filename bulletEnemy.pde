class BulletEnemy extends Bullet{

  float speed;
  float size;

  public BulletEnemy(float x, float y){
    super(x, y);
    speed = 2;
    size = 10;
  }

  void update()
	{
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

  void setBulletDirection(PVector direction){
    if(firstItt){
      directionX += direction.x;
      directionY += direction.y;
      firstItt = false;
    }
  }
}
