import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Compass extends Gauge
		{
			public var _heading = null;
			hidden var _hand;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties["Location"], properties["Decoration"], properties["Colors"], bitmaps);

				self._hand = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:CompassNeedle]}
				);
			}

			function updateInfo(info as Activity.Info)
			{
				Gauge.updateInfo(info);
				if (info != null)
				{
					self._heading = info.currentHeading;
				}
			}

			function drawHands(dc)
			{
				if (self._heading != null)
				{
					self._face.setClip(dc);
					self._hand.draw(dc,self._heading);
				}
			}
		}
	}
}
