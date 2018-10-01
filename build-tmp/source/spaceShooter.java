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





class Objects
{

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
    position = new PVector(x,y);
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

		float xMovement = getAxsisRaw("Horizontal") * playerSpeed;

		position.x += xMovement;

		float yMovement = getAxsisRaw("Vertical") * playerSpeed;

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
