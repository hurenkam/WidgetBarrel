/*
using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class CompassGauge extends Gauge 
		{
			var heading;
			
		    function initialize(x,y,r,t,w) {
		    	Gauge.initialize(x,y,r,t,w);
		    	self.heading = 0;
		    }
		    
			function draw(dc)
			{
				Gauge.draw(dc);

				var angle = 2 * Math.PI * heading / 360;
				
				drawHand(dc,angle);
			}

			function drawHand(dc,angle)
			{
				var hand = new CompassNeedle(position,r,8,r*0.9,t);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function onUpdate(dc, heading)
			{
				if (heading != null)
				{ updateHeading(heading); }
				
				Gauge.onUpdate(dc);
			}
			
			function updateHeading(heading)
			{
				self.heading = heading;
			}
			
		    function drawFace(dc)
		    {
				Gauge.drawFace(dc);
				
				drawTickMarks(dc,  0, 16,  16, 3, 0, t.DefaultDimmed);
				drawNumbers(dc,Graphics.FONT_SYSTEM_XTINY);
		    }
		    
		    function drawNumbers(dc,font)
		    {
				drawNumber(dc, "N",   0, t.AccentBright,font);
				drawNumber(dc, "E",  90, t.DefaultDimmed,font);
				drawNumber(dc, "S", 180, t.DefaultDimmed,font);
				drawNumber(dc, "W", 270, t.DefaultDimmed,font);
		    }
		}
	}
}
*/