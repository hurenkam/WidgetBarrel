using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Gauge
		{
			var position,r,t,w;
			
			function initialize(x, y, r, t, w)
			{
				position = new Shapes.Position(x,y);
				self.r = r;
				self.t = t;
				self.w = w;
			}
			
			function move(x,y)
			{
				position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				position.rotate(xr,yr,phi);
			}
			
			function onUpdate(dc)
			{
				draw(dc);
			}
			
			function draw(dc)
			{
				drawFace(dc);
			}
			
			function drawFace(dc)
			{
				var p = position.get();
				var x = p[0];
				var y = p[1];
				
				dc.setClip(x-r, y-r, r*2, r*2);
				dc.setColor(t.Background, t.Background);
		    	dc.setPenWidth(1);
				dc.fillCircle(x, y, r);
			}
			
		    function drawTickMarks(dc, start, count, divider, width, length, color)
		    {
				var p = position.get();
				var x = p[0];
				var y = p[1];
				
				dc.setClip(x-r, y-r, r*2, r*2);
		    	dc.setPenWidth(width);
		    	dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		    	
		    	for (var tick = start; tick < start+count; tick++)
		    	{
		    		var angle = 2 * Math.PI * tick / divider;
			    	var x1 = (r-3) * Math.sin(angle);
			    	var y1 = (r-3) * Math.cos(angle + Math.PI);
			    	
			    	var x2 = (r-3-length) * Math.sin(angle);
			    	var y2 = (r-3-length) * Math.cos(angle + Math.PI);
			    	
			    	if (length <= 1)
			    	{
		    			dc.drawPoint(x+x1,y+y1);
		    		}
		    		else
		    		{
				    	dc.drawLine(x+x1,y+y1,x+x2,y+y2);
				    }
		    	}
		    }
		    
		    function drawNumber(dc, number, degrees, color, font)
		    {
				var radians = 2 * Math.PI * degrees / 360.0;
				
		        var dimensions = dc.getTextDimensions(number,font);
		        var w = dimensions[0];
		        var h = dimensions[1];
		        
		    	var x = position.getX() + 0.8 * (r-w/2) * Math.sin(radians);
		    	var y = position.getY() + 0.9 * (r-h/2) * Math.cos(radians + Math.PI);
				
		    	dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		        dc.drawText(x,y,font,number,Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		    }
		    
			function drawHand(dc, style, angle)
			{
				var hand = new Hand(style,t);
				hand.rotate(angle);
				hand.draw(dc);
			}
		}
	}
}
