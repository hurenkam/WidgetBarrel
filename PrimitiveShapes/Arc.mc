using Toybox.Graphics;

module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Arc 
		{
			hidden var position, radius, start, end, direction, width, color;
	
			function initialize(position,radius,start,end,direction,width,color)
			{
				self.position = position;
				self.radius = radius;
				self.color = color;
				self.width = width;
				self.start = start;
				self.end = end;
				self.direction = direction;
			}
			
			function getPosition()
			{
				return position;
			}
			
			function getRadius()
			{
				return radius;
			}
			
			function getStart()
			{
				return start;
			}
			
			function getEnd()
			{
				return end;
			}
			
			function getDirection()
			{
				return direction;
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
			}
			
			function move(x,y)
			{
				position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
			}
			
			function draw(dc)
			{
				//var clip = getClip();
				//dc.setClip(clip[0],clip[1],clip[2],clip[3]);
				dc.clearClip();
				
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				dc.drawArc(position.get()[0],position.get()[1],radius,direction,start,end);
			}
		}
	}
}