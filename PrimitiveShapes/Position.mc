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

/*
		class Position62
		{
			var _properties = {};
			
			function initialize(properties as Dictionary)
			{
				self.set(properties);
			}
	
			function get()
			{
				return _properties;
			}
			
			function set(properties as Dictionary)
			{
				self._properties = properties;
			}
			
			function move(x,y)
			{
				self._properties[:x] += x;
				self._properties[:y] += y;
			}
			
			function rotate(xr,yr,phi)
			{
				var sin = Math.sin(phi);
				var cos = Math.cos(phi);
				
				var x = self._properties[:x] - xr;
				var y = self._properties[:y] - yr;
				
				var xn = x * cos - y * sin;
				var yn = x * sin + y * cos;
				  
				self._properties[:x] = xn + xr;
				self._properties[:y] = yn + yr;
			}
		}
*/
	}
}
