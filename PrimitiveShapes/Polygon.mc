using Toybox.Graphics;

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
	 			var region = new Region();
	 			for (var i = 0; i<shape.size(); i++)
	 			{
	 				region.extendWithXY(shape[i][0],shape[i][1]);
	 			}
	 			
 				return region.get();
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
					var p = new Position(shape[i][0],shape[i][1]);
					p.rotate(xr,yr,phi);
					result.add(p.get());
				}
				shape = result;
			}
			
			function draw(dc)
			{
				dc.setPenWidth(width);
				dc.setColor(color,Graphics.COLOR_TRANSPARENT);
				dc.fillPolygon(shape);
			}
		}
	
		(:test)
		module TestPolygon
		{
			using Toybox.Test;
			
			(:test)
	        function getClip(logger) {
	            var p = new Polygon([
	            		[10,10],
	            		[10,20],
	            		[20,20],
	            		[20,10]
	            	], Graphics.COLOR_WHITE, 1);
	            var c = p.getClip();
	            logger.debug("GetClip(): " + c);
	            Test.assertEqual(10,c[0]);
	            Test.assertEqual(10,c[1]);
	            Test.assertEqual(11,c[2]);
	            Test.assertEqual(11,c[3]);
	            return true;
			}
		}
	}
}