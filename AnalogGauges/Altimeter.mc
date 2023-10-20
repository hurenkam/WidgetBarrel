import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Altimeter extends Gauge
		{
			public var Altitude = 2250;
			hidden var _altitude;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties, bitmaps);

				self._altitude = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:SpeedNeedle]}
				);
			}

			function drawHands(dc)
			{
				Gauge.drawHands(dc);

				var offset = Math.PI;
				var multiplier = (2 * Math.PI) / 4000.0;
				var angle = offset + Altitude * multiplier;

				self._altitude.draw(dc,angle);
			}
		}
	}
}
