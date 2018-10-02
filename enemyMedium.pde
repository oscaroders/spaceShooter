class EnemyMedium extends Enemy{

  EnemyMedium(){
    super();
    size = 50;
  }

  void draw()
  {

    fill(255, 255, 0);
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
