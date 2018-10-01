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

public void setup()
{
	
	lars = new Player(width/2, height/2);
}

public void draw()
{
	background(255);
	lars.update();
}
class Bullet extends Objects
{

	public Bullet(float x,float y)
	{

		super(x,y);
		
	}


}

/*class Enemy extends Objects
{
	public Objects()
	{
		super();
	}
}
*/




boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;

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

	if (key == 'd')
	{
		moveRight = true;
	}
	else if (key == 'a')
	{
		moveLeft = true;
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

	if (key == 'w')
	{
		moveUp = true;
	}
	else if (key == 's')
	{
		moveDown = true;
	}



}

public void keyReleased()
{
	if (key == 'd')
	{
		moveRight = false;
	}
	else if (key == 'a')
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



	if (key == 'w')
	{
		moveUp = false;
	}
	else if (key == 's')
	{
		moveDown = false;
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
    // position.x = random(); // ???
    // position.x = random(); // ????
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

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 5f;

	}

	public void update()
	{

		float xMovement = getAxisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		float yMovement = getAxisRaw("Vertical") * playerSpeed;

		position.y += yMovement;

		draw();
	}

	public void draw()
	{

		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, 50, 50);
	}


}
  public void settings() { 	size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "spaceShooter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
