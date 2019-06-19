module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Polygon 
		{
			hidden var shape, width, color;
	
			function getShape()
			{
				return shape;
			}
			
			function getWidth()
			{
				return width;
			}
			
			function getColor()
			{
				return color;
			}
			
			function initialize(shape,color,width)
			{
				self.shape = shape;
				self.color = color;
				self.width = width;
			}
			
			function getClip()
			{
	 			var result = [ 0,0,0,0 ];
				return result;
			}
			
			function move(x,y)
			{
				var result = [];
				for (var i = 0; i<shape.size(); i++)
				{
					var p = new Position(shape[i][0],shape[i][1]);
					p.move(x,y);
					result.add(p.get());
				}
				shape = result;
			}
			
			function rotate(xr,yr,phi)
			{
				var result = [];
				for (var i = 0; i<shape.size(); i++)
				{
					var p = new Position(shape[i][0],shape[i][1]);
					p.rotate(xr,yr,phi);
					result.add(p.get());
				}
				shape = result;
			}
			
			function draw(dc)
			{
				//var clip = getClip();
				//dc.setClip(clip[0],clip[1],clip[2],clip[3]);
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				dc.fillPolygon(shape);
			}
		}
	}
}