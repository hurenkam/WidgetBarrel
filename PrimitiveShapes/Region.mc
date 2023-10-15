module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Region
		{
			hidden var x1, y1, x2, y2;
			
			function initialize()
			{
			}
			
			function get()
			{
				return [x1,y1,x2-x1+1,y2-y1+1];
			}
			
			function set(x,y,w,h)
			{
				x1 = x;
				y1 = y;
				x2 = x+w-1;
				y2 = y+h-1;
			}
			
			function extend(position)
			{
				var q = position.get();
				var x = q[0];
				var y = q[1];
				
				x1 = (x1 < x)? x1 : x;
				y1 = (y1 < y)? y1 : y;
				
				x2 = (x2 > x)? x2 : x;
				y2 = (y2 > y)? y2 : y;
			}
			
			function contains(position)
			{
				var x = position.get()[0];
				var y = position.get()[1];
				
				if ((x < x1) || (x > x2)) { return false; }
				if ((y < y1) || (y > y2)) { return false; }
				
				return true;
			}
			
			function move(x,y)
			{
				//position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				//position.rotate(xr,yr,phi);
			}
		}
	}
}
