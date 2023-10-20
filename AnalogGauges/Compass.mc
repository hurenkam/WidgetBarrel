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
			hidden var _properties;
			hidden var _bitmaps;
			hidden var _face;
			hidden var _needle;

			hidden var _heading;
			hidden var _info;			

			function initialize(properties, bitmaps)
			{
				self._properties = properties;
				self._bitmaps = bitmaps;

				var x = properties["Location"]["x"];
				var y = properties["Location"]["y"];
				var r = properties["Location"]["r"];
				var dx = bitmaps[:dx];
				var dy = bitmaps[:dy];
				var scale = bitmaps[:scale];

				var fontsize = properties["Decoration"]["Size"];

				self._face = new Gauge(properties, bitmaps[:Background]);
				self._heading = new Hand(
					{:x => x, :y => y},
					{:dx => dx, :dy => dy, :scale => scale, :reference => bitmaps[:CompassNeedle]}
				);
			}

			function drawFace(dc)
			{
				self._face.draw(dc);
			}

			function drawHands(dc,heading)
			{
				self._face.setClip(dc);
				var angle = 2 * Math.PI * heading / 360.0;
				self._heading.draw(dc,angle);
			}
		}
	}
}
