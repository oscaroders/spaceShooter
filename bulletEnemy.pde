class BulletEnemy extends Bullet{

  float speed = 2;
  float size = 10;

  public BulletEnemy(float x, float y){
    super(x, y);
  }

  void setBulletDirection(PVector direction){
    if(firstItt){
      directionX += direction.x;
      directionY += direction.y;
      firstItt = false;
    }
  }
}
