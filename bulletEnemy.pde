class BulletEnemy extends Bullet{

  float speed = 5;

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
