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
			hidden var _properties;
			hidden var _bitmaps;

			hidden var _face;
			hidden var _altitude;

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
				self._altitude = new Hand(
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

			function drawHands(dc,altitude)
			{
				self.setClip(dc);
				var offset = Math.PI;
				var multiplier = (2 * Math.PI) / 4000.0;
				var angle = offset + altitude * multiplier;

				self._altitude.draw(dc,angle);
			}
		}
	}
}
