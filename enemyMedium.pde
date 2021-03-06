class EnemyMedium extends Enemy
{
  EnemyMedium(){
    super();
    size = 60;
  }

  void draw()
  {
    noStroke();
    fill(0, 191, 255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size, size);
  }

  void moveToPlayerPosition()
  {
    direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
    direction.normalize();
    direction.mult(1.5);
    position.add(direction);
  }
}
