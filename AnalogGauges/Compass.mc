import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Compass extends Gauge
		{
			public var Heading = 45;
			hidden var _heading;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties, bitmaps);

				self._heading = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:CompassNeedle]}
				);
			}

			function drawHands(dc)
			{
				self._face.setClip(dc);
				var angle = 2 * Math.PI * Heading / 360.0;
				self._heading.draw(dc,angle);
			}
		}
	}
}
