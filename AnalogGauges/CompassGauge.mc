import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Compass
		{
			hidden var _location;

			hidden var _face;
			hidden var _heading;
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
					["*.|.*.|.*.|.*.|.*.|.*.|.*.|.*.|.","BionicBold","N","|","E","|","S","|","W","|"]
				);
				self._heading = new Hand(
					{:x => x, :y => y},
					{:dx => -15.0, :dy => -200.0, :scale => scale, :reference => Rez.Drawables.CompassNeedle}
				);
			}

			function drawFace(dc)
			{
				dc.setClip(_location[:x]-_location[:radius],_location[:x]-_location[:radius],_location[:radius]*2,_location[:radius]*2);
				self._face.draw(dc);
			}

			function drawHands(dc,heading)
			{
				dc.setClip(_location[:x]-_location[:radius],_location[:x]-_location[:radius],_location[:radius]*2,_location[:radius]*2);

				var angle = 2 * Math.PI * heading / 360.0;
				self._heading.draw(dc,angle);
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