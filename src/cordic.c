#include<stdio.h>
#include<math.h>

int main()
{
	double rangle; 
	const double cos = 0.6072;
	int angle;
	
	float angleArray[16] = {45,26.565, 14.036, 7.125, 3.576, 1.790, 0.8951,0.4476,0.2238, 0.1119, 0.0559, 0.0279, 0.0139, 0.0069, 0.003,0.001};	

	printf("Enter an angle\n");
	scanf("%lf", &rangle);
	
	
	float currAngle = 0.0; 
	int x = 1, y = 0, cx = 1, cy = 0;

	for(int i=0; i<16; ++i)
	{
		if(currAngle < rangle)
		{
			currAngle = currAngle + angleArray[i] ;
			x = cx - (cy << i);
			y = (cx << i) + cy;
			
			if(i == 0)
				printf("X%d: %d Y%d: %d\n",i, x , i , y);	
		}

		else
		{
		
			currAngle = currAngle - angleArray[i];
			x = cx + (cy << i);
			y = cy - (cx << i);	
		
			if(i == 1)
				printf("X%d: %d Y%d: %d\n",i, x , i ,  y);
			
		}
		
		cx = x;
		cy = y;
	}

	printf("Before normalization sine: %d\n",y);
	printf("Before normalization cosine: %d\n",x);

	float fx = (float)x/pow(2,15);
	float fy = (float)y/pow(2,15);
	
	fx *= cos;
	fy *= cos;
	

	printf("Sine %d = %f\n", angle,fy); 
	printf("Cosine %d = %f\n", angle,fx); 
	return 0;
}
