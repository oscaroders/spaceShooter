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

PImage img1;
PImage img2;
PImage imgA;
float deltaTime;
long currentTime;
float time;

public void setup()
{
	
	img1 = loadImage("spaceShip.jpg");
	img2 = loadImage("sun.jpg");
	imgA = loadImage("asteroid.png");
	gameManager = new GameManager();
}

public void draw()
{
	currentTime = millis();
	deltaTime = (currentTime - time) * 0.001f;

	gameManager.update();
	
	time = currentTime;
}
class Asteroid extends Objects
{

	float speedX;
	float speedY;
	int size = 250;

	public Asteroid()
	{
		position = new PVector(random(width), random(height));
		speedX += random(-1 , 1);
		speedY += random(-1, 1);
	}


	public void draw()
	{
		bounderies();
		position.x += speedX;
		position.y += speedY;
		image(imgA, position.x - size / 2, position.y - size / 2, 250, 250);
	}

	public void bounderies()
	{
		if(position.x < 0 - size){
			position.x = width + size;
		}
		if(position.x > width + size){
			position.x = 0 - size;
		}
		if(position.y < 0 - size){
			position.y = height + size/2;
		}
		if(position.y > height + size){
			position.y = 0 - size;
		}
	}





}
class Bullet extends Objects
{
	boolean first;
	float directionX;
	float directionY;
	float speed;
	float size;

	public Bullet(float x,float y)
	{
		super(x,y);
		first = true;
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
		if(first){
			directionX += direction.x;
			directionY += direction.y;
			first = false;
		}
	}
}
class BulletEnemy extends Bullet{

  float directionX;
	float directionY;
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

  public void draw()
  {
    fill(0, 0, 255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, size / 2, size / 2);
  }

  public void setBulletDirection(PVector direction){
    if(first){
      directionX += direction.x;
      directionY += direction.y;
      first = false;
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
	else if(dist(x1, y1, x2, y2) < size1){
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

class Enemy extends Objects{
	PVector direction;
	float size;

	public Enemy(){
		super();
		direction = new PVector();
		size = 50;
	}

	public void update(){
		moveToPlayerPosition();

		if ((position.x > 0 && position.x < width) && (position.y > 0 && position.y < height)){
			enemyfire();
		}

		draw();
	}

	public void draw(){
		fill(0, 255, 0);
		ellipseMode(CENTER);
		ellipse(position.x, position.y, size, size);
	}

	public void moveToPlayerPosition(){
    direction.set(gameManager.lars.getPlayerPosition().x - position.x, gameManager.lars.getPlayerPosition().y - position.y);
    direction.normalize();
    position.add(direction);
	}

	public void enemyfire(){
		enemySpawnBullet();
	}

	public PVector getDirection(){
		return direction;
	}

	public PVector getPosition(){
		return position;
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
		int[] highScore;
		highScore = new int[3];
		highScore = getHighScore();

		if(highScore[0] < score){
			 highScore[0] = score;
		}

		textSize(20);
		textAlign(LEFT);
		fill(255, 255, 255);
		text(" Score: " + score +
				"\n" + " High Score:" +
				"\n 1st: " + highScore[0], 100, 100);


	}

	public void enemyBulletDraw()
	{

			for(int i = 0; i < maxBullet; i++)
			{
				if(b[i] instanceof Bullet)
				{
					b[i].update();
				}
			}
		}


	public void enemySpawnBullet()
	{
		if (shootCounter % 1000 == 0)
		{
			for (int j = 0; j < 10; j++)
			{
				b[bulletCounter] = new BulletEnemy(gameManager.getEnemyList()[j].getPosition().x, gameManager.getEnemyList()[j].getPosition().y);
				b[bulletCounter].setBulletDirection(gameManager.getEnemyList()[j].getDirection());
				bulletCounter++;

				if (bulletCounter == maxBullet - 1)
				{
					bulletCounter = 0;
				}
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
	Asteroid asteroid;
	Asteroid asteroid2;
	Asteroid asteroid3;


	public GameManager()
	{
		enemies = new Enemy[maxNumberOfEnemies];
		lars = new Player(width/2, height/2);
		firstItt = true;
		numberOfStars = 500;
		starPos = new PVector[numberOfStars];
		score = 0;
		asteroid = new Asteroid();
		asteroid2 = new Asteroid();
		asteroid3 = new Asteroid();
	}

	public void update()
	{
		if (!play)
		{
			startScreen();

		}

		else
		{

			drawBackground();
			asteroid.draw();
			asteroid2.draw();
			asteroid3.draw();

			if (gameOverScreen == false)
			{
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
					gameOverScreen = true;
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
					gameOverScreen = true;
				if(collision(lars.position.x, lars.position.y, lars.size / 2, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
					gameOverScreen = true;

				if (millis() > 5000)
				{

					if(firstSpawn)
					{
						b = new Bullet[maxBullet];
						spawnEnemy(10);
						firstSpawn = false;
					}

					checkPlayerCollision();

					checkEnemyCollision();
					enemyBulletDraw();
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
				if(keyPressed && key == 'r')
				setup();
			}

		}


	}


	public void checkPlayerCollision()
	{
		for (int i = 0; i < maxNumberOfEnemies; i++)
		{
			boolean colider = collision(lars.position.x, lars.position.y, lars.size / 2, enemies[i].position.x, enemies[i].position.y, enemies[i].size / 2);
			if (colider)
			{
				gameOverScreen = true;
			}

			for (int j = 0; j < 100; j++)
			{
				if(b[j] instanceof Bullet)
				{

				 	if (collision(lars.position.x, lars.position.y, lars.size / 2, b[j].position.x, b[j].position.y, b[j].size / 2))
				 	{
						if( gameManager.lars.life == 0){
							gameOverScreen = true;
						} else {
							gameManager.lars.life -= 1;
						}
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
		for(int i = 0; i < maxNumberOfEnemies; i++){
			if(enemies[i] instanceof Enemy){
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid.position.x, asteroid.position.y, asteroid.size / 2))
					spawnEnemy(i);
				if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid2.position.x, asteroid2.position.y, asteroid2.size / 2))
					spawnEnemy(i);
			  if(collision(enemies[i].position.x, enemies[i].position.y, enemies[i].size, asteroid3.position.x, asteroid3.position.y, asteroid3.size / 2))
					spawnEnemy(i);
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
		int[] highScore;
		highScore = new int[3];
		highScore = getHighScore();

		currentTime = millis() / 1000;

		if (gameOverCounter == 0)
		{
		 	endTime = currentTime;
			saveHighScore();
		}

		textSize(50);
		textAlign(CENTER);
		fill(255, 255, 255);
		text("Game Over", width/2, height/10);

		textAlign(CENTER);

		text("Time: " + endTime + " seconds", width/2,  height/6);
		gameOverCounter++;

		textAlign(CENTER);
		text("Score: " + score + "\n High Score: \n 1st: " + highScore[0] + "\n 2nd: " + highScore[1] + "\n 3rd: " + highScore[2], width/2,  height/4);

		fill(255, 0, 0);
		textAlign(CENTER);
		text("Press r to reset the game!", width/2,  height/2 + height /5);
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


	public void startScreen()
	{
		background(0);

  		image(img1, 50, 500, width/2, height/2);

  		image(img2, 900, 100, width/2, height/2);

		textSize(50);
		textAlign(CENTER);
		fill(255, 100, 255);
		text("Space Shooter 1.0", width/2, height/5);

		textAlign(CENTER);
		fill(255, 100, 255);
		text("-----------------", width/2, height/4.5f);

		textAlign(CENTER);
		fill(255, 150, 0);
		text("PRESS P TO START THE GAME!", width/2, height/2 + height/20);
	}

}
int s1, s2, s3;

public void saveHighScore(){

  int[] temp = new int[3];
  temp = getHighScore();
  if(score >= temp[0]){
    temp[2] = temp[1];
    temp[1] = temp[0];
    temp[0] = score;
  } else if(score >= temp[1]){
    temp[2] = temp[1];
    temp[1] = score;
  } else if (score >= temp[2]){
    temp[2] = score;
  }

  String[] highScore = new String[3];
  highScore[0] = Integer.toString(temp[0]);
  highScore[1] = Integer.toString(temp[1]);
  highScore[2] = Integer.toString(temp[2]);
  saveStrings("score.txt", highScore);
}

public int[] getHighScore(){
  int[] temp = new int[3];
  String[] highScore = loadStrings("score.txt");
  temp[0] = Integer.valueOf(highScore[0]);
  temp[1] = Integer.valueOf(highScore[1]);
  temp[2] = Integer.valueOf(highScore[2]);
  return temp;
}
boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;
boolean fire;
boolean enter;
boolean play;

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
		if(keyCode == ENTER){
			enter = true;
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

	if (key == 'n')
	{
		fire = true;
	}

	if (key == 'p' || key == 'P')
	{
		play = true;
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
		if(keyCode == ENTER){
			enter = false;
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
	if (key == 'n')
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
class Objects{

	  PVector rotation;
   	PVector velocity;
   	PVector position;

  public Objects(){
    position = new PVector();

    int side2side = (int)random(1, 4.99f);
    if (side2side == 1){
    	position.x = random(-50, -5);
    	position.y = random(0, height);
    }
    if (side2side == 2){
    	position.x = random(0, width);
    	position.y = random(-50, -5);
    }
    if (side2side == 3){
    	position.x = random(width + 5, width + 50);
    	position.y = random(0, height);
    }
    if (side2side == 4){
    	position.x = random(0, width);
    	position.y = random(height + 5, height + 50);
    }
  }

  public Objects(float x, float y){
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
	int life;

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
		life = 500;
	}

	public void update()
	{

		playerRotation();
 		if(moveUp || moveDown){
			if(playerSpeed > 3)
				playerSpeed += getAxisRaw("Vertical") * 0.1f;
			if(playerSpeed <= 3)
				playerSpeed = 3.1f;
		}

		if(moveLeft || moveRight){
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
		fill(255, 0, 0);
		text(life, position.x, position.y);
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
