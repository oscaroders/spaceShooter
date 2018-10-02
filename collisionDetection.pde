boolean collision(float x1, float y1, int size1, float x2, float y2, int size2)
{
	int maxDistance = size1 + size2;

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

<<<<<<< HEAD

}
=======
>>>>>>> 1b2a5ba585150f8120bed17918c9db01f5248b97

	if (size1 + size2 <= maxDistance)
	{
		return true;
	}

}
