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
}
>>>>>>> d39a45b3dddd302b480c4f2d9321bb2ee0a1118f
