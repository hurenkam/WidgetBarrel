import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Speedometer extends Gauge
		{
			public var Speed = 12;
			hidden var _speed;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties, bitmaps);

				self._speed = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:SpeedNeedle]}
				);
			}

			function drawHands(dc)
			{
				Gauge.drawHands(dc);

				var offset = Math.PI * 0.8;
				var multiplier = (2 * Math.PI) / -50.0;
				var angle = offset + Speed * multiplier;

				self._speed.draw(dc,angle);
			}
		}
	}
}
