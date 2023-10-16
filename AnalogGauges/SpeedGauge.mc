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
