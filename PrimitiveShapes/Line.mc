using Toybox.Graphics;

module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Line 
		{
			hidden var source, destination, width, color;
	
			function getSource()
			{
				return source;
			}
			
			function getDestination()
			{
				return destination;
			}
			
			function getWidth()
			{
				return width;
			}
			
			function getColor()
			{
				return color;
			}
			
			function initialize(source,destination,color,width)
			{
				self.source = source;
				self.destination = destination;
				self.color = color;
				self.width = width;
			}
			
			function getClip()
			{
				var d = width/2 - 0.5;
				
				var p1 = source.get();
				var p2 = destination.get();
				
				var x1 = (p1[0]<p2[0]? p1[0] : p2[0]);
				var y1 = (p1[1]<p2[1]? p1[1] : p2[1]);
				var x2 = (p1[0]>p2[0]? p1[0] : p2[0]);
				var y2 = (p1[1]>p2[1]? p1[1] : p2[1]);
				
				return [ x1-d-1, y1-d-1, x2-x1+width+2, y2-y1+width+2 ];
			}
			
			function move(x,y)
			{
				source.move(x,y);
				destination.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				source.rotate(xr,yr,phi);
				destination.rotate(xr,yr,phi);
			}
			
			function draw(dc)
			{
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				dc.drawLine(source.get()[0],source.get()[1],destination.get()[0],destination.get()[1]);
			}
		}
	}
}