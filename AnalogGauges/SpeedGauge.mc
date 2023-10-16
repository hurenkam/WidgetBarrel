import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Speedometer
		{
			hidden var _location;

			hidden var _face;
			hidden var _speed;
			hidden var _info;

			function initialize(location as Dictionary<Symbol,Number>)
			{
				self._location = location;

				var x = location[:x].toFloat();
				var y = location[:y].toFloat();
				var scale = location[:radius] / 227.0;

				self._face = new Gauge(
					location,
					{ :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
					["*|*|*|*       *|*|*|","BionicBold","20","15","10","5","35","30","25"]
				);
				self._speed = new Hand(
					{:x => x, :y => y},
					{:dx => -15.0, :dy => -200.0, :scale => scale, :reference => Rez.Drawables.SpeedNeedle}
				);
			}

			function drawFace(dc)
			{
				self._face.draw(dc);
			}

			function drawHands(dc,speed)
			{
				dc.setClip(_location[:x]-_location[:radius],_location[:y]-_location[:radius],_location[:radius]*2,_location[:radius]*2);

				var offset = Math.PI * 0.8;
				var multiplier = (2 * Math.PI) / -50.0;
				var angle = offset + speed * multiplier;

				self._speed.draw(dc,angle);
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
		class SpeedGauge extends Gauge 
		{
			var speed;
			
		    function initialize(x,y,r,t,w) {
		    	Gauge.initialize(x,y,r,t,w);
		    	self.speed = 0;
		    }
		    
			function draw(dc)
			{
				Gauge.draw(dc);
				var angle = 180;

				if (speed < 9)
				{
					angle = 2 * Math.PI * speed / 10;
				}
				else if (speed < 45)
				{
					angle = 2 * Math.PI * speed / 50;
				}
				else if (speed < 180)
				{
					angle = 2 * Math.PI * speed / 200;
				}
				else if (speed < 450)
				{
					angle = 2 * Math.PI * speed / 500;
				}
				drawHand(dc,angle);
			}

			function drawHand(dc,angle)
			{
				var hand = new SpeedHand(position,r,8,r*0.9,t);
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
				self.speed = speed;
			}
			
		    function drawFace(dc)
		    {
				Gauge.drawFace(dc);
				
				//                         Divde the circle in 50 ticks
				//                    Draw 40 of them
				//                Starting at position of the 30th tick clockwise from top
				drawTickMarks(dc, 30, 40,  50, 1, 0, t.DefaultDimmed);
				drawTickMarks(dc,  6,  9,  10, 3, 0, t.AccentBright);
				drawNumbers(dc,Graphics.FONT_XTINY);
		    }
		    
		    function drawNumbers(dc,font)
		    {
		    	//System.println(Lang.format("SpeedGauge.drawNumbers() radius:$1$, speed:$2$", [r, speed]));
		    	if (speed < 9)
		    	{
					drawNumber(dc, "1", 216, t.DefaultDimmed,font);
					drawNumber(dc, "3", 288, t.DefaultDimmed,font);
					drawNumber(dc, "5",   0, t.DefaultDimmed,font);
					drawNumber(dc, "7",  72, t.DefaultDimmed,font);
					drawNumber(dc, "9", 144, t.DefaultDimmed,font);
				}
				else if (speed < 45)
				{
					drawNumber(dc, "5", 216, t.DefaultDimmed,font);
					drawNumber(dc, "15", 288, t.DefaultDimmed,font);
					drawNumber(dc, "25",   0, t.DefaultDimmed,font);
					drawNumber(dc, "35",  72, t.DefaultDimmed,font);
					drawNumber(dc, "45", 144, t.DefaultDimmed,font);
				}
				else if (speed < 180)
				{
					drawNumber(dc, "100", 0, t.DefaultDimmed,font);
					if (r > 45)
					{
						drawNumber(dc, "20", 216, t.DefaultDimmed,font);
						drawNumber(dc, "60", 288, t.DefaultDimmed,font);
						drawNumber(dc, "140",  72, t.DefaultDimmed,font);
						drawNumber(dc, "180", 144, t.DefaultDimmed,font);
					}
				}
				else if (speed < 450)
				{
					drawNumber(dc, "250", 0, t.DefaultDimmed,font);
					if (r > 45)
					{
						drawNumber(dc, "50", 216, t.DefaultDimmed,font);
						drawNumber(dc, "150", 288, t.DefaultDimmed,font);
						drawNumber(dc, "350",  72, t.DefaultDimmed,font);
						drawNumber(dc, "450", 144, t.DefaultDimmed,font);
					}
				}
		    }
		}
	}
}
*/