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
					["*....|....*....|         |....*....|....","BionicBold","2k","3k","1k"]
				);
				self._altitude = new Hand(
					{:x => x, :y => y},
					{:dx => -15.0, :dy => -200.0, :scale => scale, :reference => bitmaps[:needle]}
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
