using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class DistanceGauge extends Gauge 
		{
			var distance;
			
		    function initialize(x,y,r,t,w) {
		    	Gauge.initialize(x,y,r,t,w);
		    	self.distance = 0;
		    }
		    
			function draw(dc)
			{
				Gauge.draw(dc);

				var km = self.distance.toLong() / 1000;
				var hm = self.distance.toLong() % 1000;
				var kmAngle = Math.PI + 2 * Math.PI * km / 10;
				var hmAngle = Math.PI + 2 * Math.PI * hm / 1000;
				
				drawKMHand(dc,kmAngle);
				drawHMHand(dc,hmAngle);
			}

			function drawKMHand(dc,angle)
			{
				var hand = new ClockHand(position,r,0.6,t.DefaultDimmed,w);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function drawHMHand(dc,angle)
			{
				var hand = new ClockHand(position,r,0.8,t.DefaultDimmed,w);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function onUpdate(dc, distance)
			{
				if (distance != null)
				{ updateDistance(distance); }
				
				Gauge.onUpdate(dc);
			}
			
			function updateDistance(distance)
			{
				self.distance = distance;
			}
			
		    function drawFace(dc)
		    {
				Gauge.drawFace(dc);
				
				drawTickMarks(dc, 0, 50, 50, 1, 0, t.DefaultDimmed);
				drawTickMarks(dc, 0, 10, 10, 3, 0, t.AccentBright);
				drawNumbers(dc,Graphics.FONT_SYSTEM_XTINY);
		    }
		    
			function drawHoursHand(dc,angle)
			{
				var hand = new ClockHand(position,r,0.6,t.DefaultDimmed,w);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function drawMinutesHand(dc,angle)
			{
				var hand = new ClockHand(position,r,0.8,t.DefaultDimmed,w);
				hand.updateAngle(angle);
				hand.draw(dc);
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