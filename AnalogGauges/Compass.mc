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

			function initialize(location as Dictionary<Symbol,Float>, bitmaps)
			{
				self._location = location;

				var x = location[:x];
				var y = location[:y];
				var scale = location[:radius] / 227.0;

				// compass on top left dial
				self._face = new Gauge(
					location, 
					{ :dx => -227, :dy => -227, :scale => scale, :reference => bitmaps[:face] },
					{ :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
					["*.|.*.|.*.|.*.|.*.|.*.|.*.|.*.|.","BionicBold","N","|","E","|","S","|","W","|"]
				);
				self._heading = new Hand(
					{:x => x, :y => y},
					{:dx => -15.0, :dy => -200.0, :scale => scale, :reference => bitmaps[:needle]}
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
