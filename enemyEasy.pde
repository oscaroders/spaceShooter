class EnemyEasy extends Enemy
{
  EnemyEasy(){
    super();
    size = 50;
  }

  void draw()
  {
    noStroke();
    fill(218, 165, 32);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size , size );
  }

  void moveToPlayerPosition()
  {
        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        direction.mult(2);
        position.add(direction);
  }
}
