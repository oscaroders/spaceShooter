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

	gameManager.update();

	time = currentTime;
}
class Bullet extends Objects
{
	boolean firstItt;
	float directionX;
	float directionY;
	float speed;
	float size;

	public Bullet(float x,float y)
	{
		super(x,y);
		firstItt = true;
		speed = 20;
		size = 5;
	}

	public void update()
	{
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

	public void draw()
	{
		fill(0, 0, 255);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size / 2, size / 2);
	}

	public void setBulletDirection(PVector direction){
		if(firstItt){
			directionX += direction.x;
			directionY += direction.y;
			firstItt = false;
		}
	}
}
class BulletEnemy extends Bullet{

  float speed;
  float size;

  public BulletEnemy(float x, float y){
    super(x, y);
    speed = 2;
    size = 10;
  }

  public void update()
	{
		position.set(position.x + directionX * speed, position.y + directionY * speed);
		if(!(directionX == 0 && directionY == 0))
			draw();
	}

  public void setBulletDirection(PVector direction){
    if(firstItt){
      directionX += direction.x;
      directionY += direction.y;
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
int yellow = color(255, 255, 102);
int lightYellow = color(255, 255, 204);
int spaceBlue = color(12, 36, 39);
int spaceDotPurple = color(102, 0, 102);
int spaceAppleRed = color(255, 77, 77);
int scoreTextGreen = color(0, 102, 0);
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

		if ((position.x > 0 && position.x < width) && (position.y > 0 && position.y < height))
		{
			enemyfire();
		}

		draw();
	}

	public void draw()
	{

		fill(0, 255, 0);
		//ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);

	}

	public void moveToPlayerPosition()
	{

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        position.add(direction);

	}

	public void enemyfire()
	{
		enemySpawnBullet();
	}

	public PVector getDirection(){
		return direction;
	}
}
class EnemyEasy extends Enemy{

  EnemyEasy(){
    super();
    size = 50;
  }

  public void draw()
  {

    fill(0, 0, 255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size , size );

  }

  public void moveToPlayerPosition()
  {

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        direction.mult(2);
        position.add(direction);

  }
}
class EnemyHard extends Enemy{

  EnemyHard(){
    super();
    size = 100;
  }

  public void draw()
  {

    fill(255, 0, 0);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size, size);

  }

  public void moveToPlayerPosition()
  {

        direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
        direction.normalize();
        direction.mult(0.5f);
        position.add(direction);

  }
}
class EnemyMedium extends Enemy{

  EnemyMedium(){
    super();
    size = 60;
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
        direction.mult(1.5f);
        position.add(direction);

  }
}
int score;
Bullet[] b;
int bulletCounter;
int maxBullet = 100;
int shootCounter;
int bulletSpray;	

	public void checkAndWriteScore()
	{

		textSize(20);
		textAlign(LEFT);
		fill(255, 255, 255);
		text("Score: " + score, 100, 100);

	}

	public void enemyBulletDraw()
	{
		b = new Bullet[maxBullet];

		for(int i = 0; i < maxBullet; i++)
		{

			if(b[i] instanceof Bullet)
			{
				b[i].setBulletDirection(gameManager.getEnemyList().getDirection());
				b[i].update();
			}

		}
	}

	public void enemySpawnBullet()
	{	
		if (shootCounter % 100 == 0)
		{
			b[bulletCounter] = new BulletEnemy(position.x, position.y);
			bulletCounter++;

			if (bulletCounter == maxBullet - 1)
			{
				bulletCounter = 0;
			}
		}

		shootCounter++;
	}



class GameManager
{
	Player lars;
	Enemy[] enemies;
	int maxNumberOfEnemies = 10;
	boolean firstItt;
	int numberOfStars;
	PVector[] starPos;
	int backgcount = 0;
	boolean gameOverScreen = false;
	float endTime;
	int gameOverCounter = 0;
	boolean firstSpawn = true;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
		numberOfStars = 500;
		starPos = new PVector[numberOfStars];
	}

	public void update()
	{

		drawBackground();

		if (gameOverScreen == false)
		{
			if (millis() > 5000)
			{

				if(firstSpawn)
				{
					spawnEnemy(10);
					firstSpawn = false;
				}



				checkPlayerCollision();
					enemyBulletDraw();
				checkEnemyCollision();

				for(int i = 0; i < maxNumberOfEnemies; i++)
				{
					enemies[i].update();
				}


			}

			lars.update();
			checkAndWriteScore();
		}

		if (gameOverScreen == true)
		{
			gameOver();
		}


	}


	public void checkPlayerCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; i++)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size / 2, enemies[i].position.x, enemies[i].position.y, enemies[i].size / 2);
			if (colider)
			{
				//gameOverScreen = true;
			}

			for (int j = 0; j < 100; j++)
			{
				if(enemies[i].b[j] instanceof Bullet)
				{

				 	if (collision(lars.position.x, lars.position.y, lars.size, enemies[i].b[j].position.x, enemies[i].b[j].position.y, enemies[i].b[j].size))
				 	{
				 		//gameOverScreen = true;
				 	}
				}
			}
		}
	}

	public void checkEnemyCollision(){
		for(int i = 0; i < maxNumberOfEnemies; i++){
			if(enemies[i] instanceof Enemy){
				for(int j = 0; j < 100; j++){
					if(lars.b[j] instanceof Bullet){
						if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, lars.b[j].position.x, lars.b[j].position.y, lars.b[j].size)){
							spawnEnemy(i);
						}
					}
				}
			}
		}
	}

	public void spawnEnemy(int w)
	{
		if(w == 10){
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
		}

		if(w < 7)
		{
			if ((enemies[w] instanceof Enemy))
			{
				enemies[w] = new EnemyEasy();
				score++;
			}
		}

		if(w > 5 && w < 9)
		{
			if ((enemies[w] instanceof Enemy))
			{
				enemies[w] = new EnemyMedium();
				score += 2;
			}
		}

		if(w == 9)
		{
				if ((enemies[maxNumberOfEnemies - 1] instanceof Enemy))
				{
					enemies[maxNumberOfEnemies - 1] = new EnemyHard();
					score += 3;
				}
		}
	}

	public void gameOver()
	{

		//gameOverScreen = true;
		currentTime = millis() / 1000;

		if (gameOverCounter == 0)
		{
		 	endTime = currentTime;
		}

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/2);

		textAlign(CENTER);

		text("Time: " + endTime + " seconds", width/2, height/2 + height/10);
		gameOverCounter++;

		textAlign(CENTER);
		text("Score: " + score, width/2, height/2 + height/20);


	}

	public void drawBackground(){
  background(spaceBlue);

  if(firstItt){
    generateBackground();
    firstItt = false;
  }

  for(int i = 0; i < numberOfStars; i++){
    if(backgcount % (int)random(7, 23) == 0){
      stroke(lightYellow);
      strokeWeight(random(2, 5));
    } else {
      stroke(yellow);
      strokeWeight(2);
    }
    point(starPos[i].x, starPos[i].y);
    backgcount++;
  }
}

public void generateBackground(){
  for(int i = 0; i < numberOfStars; i++){
    starPos[i] = new PVector(random(0, width),
                             random(0, height));
  }
}


	public Enemy[] getEnemyList()
	{
		return enemies;
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
			return -1;
		}
		if (moveUp)
		{

			return 1;
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

	float direction;
	float dY;
	float dX;

	public Player(float x, float y)
	{
		super(x,y);
		playerSpeed = 6f;
		b = new Bullet[maxBullet];
		size = 50;
	}

	public void update()
	{

		playerRotation();
 		if(keyPressed && (key == 'w' || key == 's')){
			if(playerSpeed > 3)
				playerSpeed += getAxisRaw("Vertical") * 0.1f;
			if(playerSpeed < 3)
				playerSpeed = 3.1f;
		}

   // fix so you can start turn while shooting!!!!
		if(keyPressed && (key == 'a' || key == 'd')){
			dX = cos(direction) * playerSpeed;
			dY = sin(direction) * playerSpeed;
			direction += 0.05f * getAxisRaw("Horizontal");
		}

		position.x += dX;
		position.y += dY;

		fire();
		bulletDraw();
		bounderies();
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
		rotation.set(dX, dY);
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
				b[i].setBulletDirection(rotation);
				b[i].update();
			}
		}
	}

	public void bounderies(){
		if(position.x < 0 - size / 2){
			position.x = width;
		}
		if(position.x > width + size / 2){
			position.x = 0;
		}
		if(position.y < 0 - size / 2){
			position.y = height;
		}
		if(position.y > height + size / 2){
			position.y = 0;
		}
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
