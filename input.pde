boolean moveLeft;
boolean moveRight;
boolean moveUp;
boolean moveDown;

void keyPressed()
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

void keyReleased()
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
		moveDown = false;
	}
	else if (key == 's') 
	{
		moveUp = false;
	}


	if (key == CODED) 
	{
		if (keyCode == UP) 
		{
			moveDown = false;	
		}
		else if (keyCode == DOWN) 
		{
			moveUp = false;
		}
	}
}

float getAxisRaw(String axis)
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