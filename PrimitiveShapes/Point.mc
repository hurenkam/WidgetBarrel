using Toybox.Graphics;

module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Point
		{
			hidden var position, width, color;
	
			function initialize(position,color,width)
			{
				self.position = position;
				self.color = color;
				self.width = width;
			}
			
			function getPosition()
			{
				return position;
			}
			
			function getWidth()
			{
				return width;
			}
			
			function getColor()
			{
				return color;
			}
			
			function getClip()
			{
				var d = width/2 - 0.5;
				var x = position.get()[0];
				var y = position.get()[1];
				
				return [ x-d, y-d, width, width ];
			}
			
			function move(x,y)
			{
				position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				position.rotate(xr,yr,phi);
			}
			
			function draw(dc)
			{
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				
				var x = position.get()[0];
				var y = position.get()[1];
				dc.drawPoint(x,y);
			}
		}
	}	
}