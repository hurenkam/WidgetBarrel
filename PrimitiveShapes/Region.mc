module WidgetBarrel 
{
	(:PrimitiveShapes)
	module PrimitiveShapes
	{
		class Region
		{
			hidden var x1=0, y1=0, x2=-1, y2=-1, valid=false;
			
			function initialize()
			{
			}
			
			function isValid()
			{
				return valid;
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
				valid = true;
			}
			
			function getSurface()
			{
				return (x2-x1+1) * (y2-y1+1);
			}
			
			function getOverlappingClip(x,y,w,h)
			{
				var xr1 = (x < x1) ? x1 : x;
				var yr1 = (y < y1) ? y1 : y; 
				var xr2 = (x + w -1) > x2 ? x2 : x + w -1;
				var yr2 = (y + h -1) > y2 ? y2 : y + h -1;
				
				if ((xr1>xr2) || (yr1>yr2)) { return null; }
				
				var result = new Region();
				result.set(xr1,yr1,xr2-xr1+1,yr2-xr2+1);
				return result;
			}
			
			function getOverlappingRegion(region)
			{
				var r = region.get();
				var xr1 = (r[0] < x1) ? x1 : r[0];
				var yr1 = (r[1] < y1) ? y1 : r[1]; 
				var xr2 = (r[0] + r[2] -1) > x2 ? x2 : r[0] + r[2] -1;
				var yr2 = (r[1] + r[3] -1) > y2 ? y2 : r[1] + r[3] -1;
				
				if ((xr1>xr2) || (yr1>yr2)) { return null; }
				
				var result = new Region();
				result.set(xr1,yr1,xr2-xr1+1,yr2-xr2+1);
				return result;
			}
			
			function extendWithClip(q)
			{
				var x1 = q[0];
				var y1 = q[1];
				var x2 = x1 + q[2] -1;
				var y2 = y1 + q[3] -1;
				
				extendWithXY(x1,y1);
				extendWithXY(x2,y2);
			}
			
			function extendWithRegion(region)
			{
				if ((region == null) || (!region.isValid())) { return; }
				
				var q = region.get();
				var x1 = q[0];
				var y1 = q[1];
				var x2 = x1 + q[2] -1;
				var y2 = y1 + q[3] -1;
				
				extendWithXY(x1,y1);
				extendWithXY(x2,y2);
			}
			
			function extendWithPosition(position)
			{
				var q = position.get();
				var x = q[0];
				var y = q[1];
				
				extendWithXY(x,y);
			}
			
			function extendWithXY(x,y)
			{
				if (valid)
				{
					x1 = (x1 < x)? x1 : x;
					y1 = (y1 < y)? y1 : y;
					
					x2 = (x2 > x)? x2 : x;
					y2 = (y2 > y)? y2 : y;
				}
				else
				{
					x1 = x;
					y1 = y;
					x2 = x;
					y2 = y;
					valid = true;
				}
			}
			
			function contains(position)
			{
				if (!valid) { return false; }
				
				var x = position.get()[0];
				var y = position.get()[1];
				
				if ((x < x1) || (x > x2)) { return false; }
				if ((y < y1) || (y > y2)) { return false; }
				
				return true;
			}
			
			function move(x,y)
			{
				position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				position.rotate(xr,yr,phi);
			}
		}
		
		(:test)
		module TestRegion
		{
			using Toybox.Test;
			
			(:test)
	        function ExtendWithXY(logger) {
	            logger.debug("Hello World!");
	            var r = new Region();
	            r.extendWithXY(10,10);
	            logger.debug("Region.get(): " + r.get()); 
	            r.extendWithXY(10,20);
	            logger.debug("Region.get(): " + r.get()); 
	            r.extendWithXY(20,20);
	            logger.debug("Region.get(): " + r.get()); 
	            r.extendWithXY(20,10);
	            logger.debug("Region.get(): " + r.get());
	            var v = r.get();
	            Test.assertEqual(10,v[0]);
	            Test.assertEqual(10,v[1]);
	            Test.assertEqual(11,v[2]);
	            Test.assertEqual(11,v[3]);
	            return true;
			}
		}
	}
}
