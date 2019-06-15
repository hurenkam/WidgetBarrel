module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Group
		{
			var shapes = [];
			
			function initialize(shapes)
			{
				self.shapes = shapes;
			}
			
			function getClip()
			{
	 			var result = [ 0,0,0,0 ];
				var count = shapes.size();
				if (count == 0)
				{
					return result;
				}
				
				result = shapes[0].getClip();
				for (var i = 1; i<shapes.size(); i++)
				{
					var clip = shapes[i].getClip();
					result[0] = (result[0] < clip[0])? result[0] : clip[0];
					result[1] = (result[1] < clip[1])? result[1] : clip[1];
					result[2] = (result[2] > clip[2])? result[2] : clip[2];
					result[3] = (result[3] > clip[3])? result[3] : clip[3];
				}
				
				return result;
			}
			
			function add(shape)
			{
				shapes.add(shape);
			}
			
			function move(x,y)
			{
				var count = shapes.size();
				for (var i = 1; i<shapes.size(); i++)
				{
					shapes[i].move(x,y);
				}
			}
			
			function rotate(xr,yr,phi)
			{
				var count = shapes.size();
				for (var i = 1; i<shapes.size(); i++)
				{
					shapes[i].rotate(xr,yr,phi);
				}
			}
			
			function draw(dc)
			{
				var count = shapes.size();
				for (var i = 1; i<shapes.size(); i++)
				{
					shapes[i].draw(dc);
				}
			}
		}
	}
}