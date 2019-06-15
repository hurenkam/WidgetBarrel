module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Position 
		{
			hidden var posX, posY;
			
			function initialize(x,y)
			{
				posX = x;
				posY = y;
			}
	
			function get()
			{
				return [ posX, posY ];
			}
			
			function getX()
			{
				return posX;
			}
			
			function getY()
			{
				return posY;
			}
			
			function set(x,y)
			{
				posX = x;
				posY = y;
			}
			
			function move(x,y)
			{
				posX += x;
				posY += y;
			}
			
			function rotate(xr,yr,phi)
			{
				var sin = Math.sin(phi);
				var cos = Math.cos(phi);
				
				var x = posX - xr;
				var y = posY - yr;
				
				var xn = x * cos - y * sin;
				var yn = x * sin + y * cos;
				  
				posX = xn + xr;
				posY = yn + yr;
			}
		}
	}
}
