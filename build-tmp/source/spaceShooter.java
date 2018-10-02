import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class spaceShooter extends PApplet {

GameManager gameManager;

float deltaTime;
long currentTime;
float time;

public void setup()
{
	
	gameManager = new GameManager();
}

public void draw()
{
	currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;
	background(255);
	gameManager.update();
	time = currentTime;
}




class Bullet extends Objects
{
	boolean firstItt;
	float directionX;
	float directionY;
	float speed = 20;
	float size = 5;

	public Bullet(float x,float y)
	{

		super(x,y);
		firstItt = true;
	}

	public void update()
	{
		setBulletDirection();
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

	public void draw()
	{
		fill(0, 0, 255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

	public void setBulletDirection(){
		if(firstItt){
			directionX += gameManager.lars.getRotation().x;
			directionY += gameManager.lars.getRotation().y;
			firstItt = false;
		}
	}
}
public boolean collision(float x1, float y1, float size1, float x2, float y2, float size2)
{
	float maxDistance = size1 + size2;

	if(abs(x1 - x2) > maxDistance || abs(y1 - y2) > maxDistance)
	{
		return false;
	}
	else if (dist(x1, y1, x2, y2) > maxDistance)
	{
		return false;
	}
	else
	{
		return true;
	}

}
class Enemy extends Objects
{
	PVector direction;
	float size;


	public Enemy()
	{
		super();
		direction = new PVector();
		size = 50;
	}

	public void update()
	{
		moveToPlayerPosition();
		draw();
	}

	public void draw()
	{

		fill(0, 255, 0);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);

	}

	public void moveToPlayerPosition()
	{

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}




}
class EnemyEasy extends Enemy{

  EnemyEasy(){
    super();
  }
}
class EnemyHard extends Enemy{

  EnemyHard(){
    super();
  }
}
class EnemyMedium extends Enemy{

  EnemyMedium(){
    super();
  }
}
class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	boolean firstItt;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
	}

	public void update()
	{

		spawnEnemy();
		checkCollision();
		lars.update();

	}


	public void checkCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; ++i)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size, enemies[i].position.x, enemies[i].position.y, enemies[i].size);
			if (colider)
			{
				gameOver();
			}

			for (int j = 0; j < 100; ++j)
			{
				 if (collision(lars.position.x, lars.position.y, lars.size,enemies[i].b[j].position.x, enemies[i].b[j].position.y, enemies[i].b[j].size))
				 {
				 	gameOver();
				 }

			}

	}
}

	public void spawnEnemy()
	{
		if(firstItt){
			for (int i = 0; i < maxNumberOfEnemies; i++)
			{
				if (i < 6)
				{
					enemies[i] = new EnemyEasy();
				}
				if (i > 5 && i < 9)
				{
					enemies[i] = new EnemyMedium();
				}
				if (i > 8)
				{
					enemies[i] = new EnemyHard();
				}
			}
			firstItt = false;
		}

		for (int i = 0; i < 6; ++i) 
		{
			if (!(enemies[i] instanceof Enemy)) 
			{
				enemies[i] = new EnmeyEasy();
			}
		}

		for (int i = 6; i < 9; ++i) 
		{
			if (!(enemies[i] instanceof Enemy)) 
			{
				enemies[i] = new EnemyMedium();
			}
		}

		if (!(enemies[maxNumberOfEnemies - 1] instanceof Enemy)) 
			{
				enemies[maxNumberOfEnemies - 1] = new EnemyHard();
			}


	}

	public void gameOver()
	{

		currentTime = millis() / 1000;

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/2);

		textAlign(CENTER);
		text("Time: " + currentTime + " seconds", width/2, height/2 + height/10);
	}

}
boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;
boolean fire;

public void keyPressed()
{

	if (key == CODED)
	{
		if (keyCode == RIGHT)
		{
			moveRight = true;
		}
		else if (keyCode == LEFT)
		{
			moveLeft = true;
		}

	}

	if (key == 'd' || key == 'D')
	{
		moveRight = true;
	}
	else if (key == 'a' || key == 'A')
	{
		moveLeft = true;
	}

	if (key == 't')
	{
		fire = true;
	}


	if (key == CODED)
	{
		if (keyCode == UP)
		{
			moveUp = true;
		}
		else if (keyCode == DOWN)
		{
			moveDown = true;
		}
	}

	if (key == 'w' || key == 'W')
	{
		moveUp = true;
	}
	else if (key == 's' || key == 'S')
	{
		moveDown = true;
	}



}

public void keyReleased()
{
	if (key == 'd' || key == 'D')
	{
		moveRight = false;
	}
	else if (key == 'a' || key == 'A')
	{
		moveLeft = false;
	}


	if (key == CODED)
	{
		if (keyCode == RIGHT)
		{
			moveRight = false;
		}
		else if (keyCode == LEFT)
		{
			moveLeft = false;
		}
	}



	if (key == 'w' || key == 'W')
	{
		moveUp = false;
	}
	else if(key == 's' || key == 'S')
	{
		moveDown = false;
	}
	if (key == 't')
	{
		fire = false;
	}


	if (key == CODED)
	{
		if (keyCode == UP)
		{
			moveUp = false;
		}
		else if (keyCode == DOWN)
		{
			moveDown = false;
		}

	}
}

public float getAxisRaw(String axis)
{

	if (axis == "Horizontal")
	{
		if (moveLeft)
		{
			return -1;
		}
		if (moveRight)
		{

			return 1;
		}
	}

	if (axis == "Vertical")
	{
		if (moveDown)
		{
			return 1;
		}
		if (moveUp)
		{

			return -1;
		}
	}

	return 0;

}
class Objects
{

	PVector rotation;
   	PVector velocity;
   	PVector position;

  public Objects()
{
    position = new PVector();

    int side2side = (int)random(1, 4.99f);
    if (side2side == 1)
    {
    	position.x = random(-50, -5);
    	position.y = random(0, height);
    }
    if (side2side == 2)
    {
    	position.x = random(0, width);
    	position.y = random(-50, -5);
    }
    if (side2side == 3)
    {
    	position.x = random(width + 5, width + 50);
    	position.y = random(0, height);
    }
    if (side2side == 4)
    {
    	position.x = random(0, width);
    	position.y = random(height + 5, height + 50);
    }

  }

  public Objects(float x, float y)
  {
    position = new PVector(x, y);
    rotation = new PVector(x, y);
  }

  public PVector getRotation(){
    return rotation;
  }
}
class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;

	Bullet[] b;
	int bulletCounter;
	int maxBullet = 100;
	float size;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;
		b = new Bullet[maxBullet];
		size = 50;
	}

	public void update()
	{

		xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;


		playerRotation();
		fire();
		bulletDraw();
		draw();

	}

	public void draw()
	{

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

	public void playerRotation()
	{
		rotation.set(xMovement, yMovement);
		rotation.normalize();
		position.add(rotation);
		line(position.x, position.y, position.x + rotation.x * 25, position.y + rotation.y * 25);
	}

    public PVector getPlayerPosition()
	{
		return position;
	}

	public void fire()
	{
		if (fire)
		{
			b[bulletCounter] = new Bullet(position.x, position.y);
			bulletCounter++;
			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}
	}

	public void bulletDraw(){

		for(int i = 0; i < maxBullet; i++){
			if(b[i] instanceof Bullet){
				b[i].update();
			}
		}
	}
}
  public void settings() { 	size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "spaceShooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
