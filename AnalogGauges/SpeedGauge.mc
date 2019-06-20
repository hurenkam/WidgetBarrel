using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class SpeedGauge extends Gauge 
		{
			var speed;
			
		    function initialize(x,y,r,t,w) {
		    	Gauge.initialize(x,y,r,t,w);
		    	self.speed = 0;
		    }
		    
			function draw(dc,damage)
			{
				Gauge.draw(dc,damage);

				var angle = 2 * Math.PI * speed / 10;
				
				drawHand(dc,angle);
			}

			function drawHand(dc,angle)
			{
				var hand = new SpeedHand(position,r,8,35,t);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function onUpdate(dc, speed)
			{
				if (speed != null)
				{ updateSpeed(speed); }
				
				Gauge.onUpdate(dc);
			}
			
			function updateSpeed(speed)
			{
				if (speed == self.speed) { return null; }
				
				self.speed = speed;
				
    			var result = new Shapes.Region();
				result.extendWithClip(getClip());				
				return result; 
			}
			
		    function drawFace(dc,damage)
		    {
				Gauge.drawFace(dc,damage);
				
				drawTickMarks(dc, 60, 80, 100, 1, 0, t.DefaultDimmed);
				drawTickMarks(dc,  6,  9,  10, 3, 0, t.AccentBright);
				drawNumbers(dc,Graphics.FONT_SYSTEM_XTINY);
		    }
		    
		    function drawNumbers(dc,font)
		    {
				drawNumber(dc, "1", 216, t.DefaultDimmed,font);
				drawNumber(dc, "3", 288, t.DefaultDimmed,font);
				drawNumber(dc, "5",   0, t.DefaultDimmed,font);
				drawNumber(dc, "7",  72, t.DefaultDimmed,font);
				drawNumber(dc, "9", 144, t.DefaultDimmed,font);
		    }
		}
	}
}