class EnemyEasy extends Enemy{

  EnemyEasy(){
    super();
    size = 25;
  }

  void draw()
  {

    fill(255, 255, 0);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size / 2, size / 2);

  }

  void moveToPlayerPosition()
  {

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        direction.mult(2);
        position.add(direction);

  }
}
