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
				var count = shape.size();
				if (count == 0)
				{
					return result;
				}
				
				result = shape[0].getClip();
				for (var i = 1; i<shape.size(); i++)
				{
					var clip = shape[i].getClip();
					result[0] = (result[0] < clip[0])? result[0] : clip[0];
					result[1] = (result[1] < clip[1])? result[1] : clip[1];
					result[2] = (result[2] > clip[2])? result[2] : clip[2];
					result[3] = (result[3] > clip[3])? result[3] : clip[3];
				}
				
				return result;
			}
			
			function move(x,y)
			{
				var result = [];
				for (var i = 0; i<shape.size(); i++)
				{
					var p = new Position(shape[i]);
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
					var p = new Position(shape[i]);
					p.rotate(xr,yr,phi);
					result.add(p.get());
				}
				shape = result;
			}
			
			function draw(dc)
			{
				var clip = getClip();
				dc.setClip(clip[0],clip[1],clip[2],clip[3]);
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				dc.fillPolygon(shape);
			}
		}
	}
}