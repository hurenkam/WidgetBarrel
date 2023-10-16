import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Altimeter
		{
			hidden var _location;

			hidden var _face;
			hidden var _altitude;
			hidden var _info;

			function initialize(location as Dictionary<Symbol,Number>)
			{
				self._location = location;

				var x = location[:x].toFloat();
				var y = location[:y].toFloat();
				var scale = location[:radius] / 227.0;

				// compass on top left dial
				self._face = new Gauge(
					location,
					{ :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
					["*....|....*....|         |....*....|....","BionicBold","2k","3k","1k"]
				);
				self._altitude = new Hand(
					{:x => x, :y => y},
					{:dx => -15.0, :dy => -200.0, :scale => scale, :reference => Rez.Drawables.SpeedNeedle}
				);
			}

			function drawFace(dc)
			{
				self._face.draw(dc);
			}

			function drawHands(dc,altitude)
			{
				dc.setClip(_location[:x]-_location[:radius],_location[:y]-_location[:radius],_location[:radius]*2,_location[:radius]*2);
				var offset = Math.PI;
				var multiplier = (2 * Math.PI) / 4000.0;
				var angle = offset + altitude * multiplier;

				self._altitude.draw(dc,angle);
			}
		}
	}
}

/*
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
*/