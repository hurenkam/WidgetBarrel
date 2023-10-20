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
			hidden var _properties;
			hidden var _bitmaps;

			hidden var _face;
			hidden var _speed;

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
				self._speed = new Hand(
					{:x => x, :y => y},
					{:dx => dx, :dy => dy, :scale => scale, :reference => bitmaps[:SpeedNeedle]}
				);
			}

			function setClip(dc)
			{
				var r = self._properties["Location"]["r"];
				var x = self._properties["Location"]["x"]-r;
				var y = self._properties["Location"]["y"]-r;
				var w = r*2;
				var h = r*2;
				dc.setClip(x,y,w,h);
			}

			function drawFace(dc)
			{
				self.setClip(dc);
				self._face.draw(dc);
			}

			function drawHands(dc,speed)
			{
				self.setClip(dc);

				var offset = Math.PI * 0.8;
				var multiplier = (2 * Math.PI) / -50.0;
				var angle = offset + speed * multiplier;

				self._speed.draw(dc,angle);
			}
		}
	}
}
