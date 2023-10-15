/*
using WidgetBarrel.PrimitiveShapes as Shapes;
using WidgetBarrel.AnalogGauges as Gauges;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class AnalogTime extends Gauge
		{
			hidden var hours,minutes,seconds,bright;
			
			function initialize(x, y, r, t, w)
			{
				Gauge.initialize(x,y,r,t,w);
				
				self.hours = 0;
				self.minutes = 0;
				self.seconds = 0;
			}
			
			function updateHours(hours)
			{
				self.hours = hours;
			}
			
			function updateMinutes(minutes)
			{
				self.minutes = minutes;
			}
			
			function updateSeconds(seconds)
			{
				self.seconds = seconds;
			}

			function onUpdate(dc, time)
			{
				updateHours(time.hour);
				updateMinutes(time.min);
				updateSeconds(time.sec);
				
				Gauge.onUpdate(dc);
			}
			
			function draw(dc)
			{
				Gauge.draw(dc);

				var minutesAngle = 2 * Math.PI * minutes / 60.0;
				var hoursAngle = 2 * Math.PI * hours / 12.0 + minutesAngle/12.0;
				
				drawHoursHand(dc,hoursAngle,t.DefaultDimmed);
				drawMinutesHand(dc,minutesAngle,t.DefaultDimmed);
			}

			function drawFace(dc)
			{
				Gauge.drawFace(dc);
				
				drawTickMarks(dc, 0, 60, 60, 1, 0, t.DefaultDimmed);
				drawTickMarks(dc, 0, 12, 12, 3, 0, t.AccentBright);
				
				drawNumbers(dc,Graphics.FONT_XTINY,t.DefaultDimmed);
			}
			
			function drawHoursHand(dc,angle,color)
			{
				var hand = new ClockHand(position,r,0.6,color,w);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
			function drawMinutesHand(dc,angle,color)
			{
				var hand = new ClockHand(position,r,0.8,color,w);
				hand.updateAngle(angle);
				hand.draw(dc);
			}
			
		    function drawNumbers(dc,font,color)
		    {
				drawNumber(dc, "12", 0, color,font);
				drawNumber(dc, "3", 90, color,font);
				drawNumber(dc, "6", 180, color,font);
				drawNumber(dc, "9", 270, color,font);
		    }
		}
	}
}
*/