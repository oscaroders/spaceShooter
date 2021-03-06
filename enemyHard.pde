class EnemyHard extends Enemy
{
  EnemyHard(){
    super();
    size = 100;
  }

  void draw()
  {
    noStroke();
    fill(0, 255, 154);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size, size);
  }

  void moveToPlayerPosition()
  {
    direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
    direction.normalize();
    direction.mult(0.5);
    position.add(direction);
  }
}
