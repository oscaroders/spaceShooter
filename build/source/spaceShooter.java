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


Player lars;
Enemy knut;

public void setup()
{
	
	lars = new Player(width/2, height/2);
	knut = new Enemy();
}

public void draw()
{
	background(255);
	lars.update();
	knut.update();
}
class Bullet extends Objects
{

	public Bullet(float x,float y)
	{

		super(x,y);

	}

	public void update()
	{
		draw();

	}

	public void draw()
	{
		fill(0, 0, 255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 20, 20);

	}


}

class Enemy extends Objects
{
	PVector direction;



	public Enemy()
	{
		super();
		direction = new PVector();
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
		ellipse(position.x, position.y, 50, 50);

	}

	public void moveToPlayerPosition()
	{

        direction.set(lars.getPlayerPosition().x - position.x, lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}




}



class GameManager
{


	public GameManager()
	{

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
}
class Player extends Objects
{
	float playerSpeed;
	float xMovement;
	float yMovement;

	Bullet[] b;
	int bulletCounter;


	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;
		b = new Bullet[100];

	}

	public void update()
	{

		xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;

		fire();
		playerRotation();
		draw();
		fire();
	}

	public void draw()
	{

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);
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
			b[bulletCounter].update(); // make into a for loop that draws all balls in a function.
			bulletCounter++;
			if (bulletCounter == 99)
			{
				bulletCounter = 0;
			}

		}
		else
		{
			println("ERROR!");
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
