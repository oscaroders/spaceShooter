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

	public Player(float x, float y)
	{
		super(x,y);

	}

	public void update()
	{
		draw();
	}

	public void draw()
	{
		fill(255, 100, 50, 30);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, width/2, height/2);
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
