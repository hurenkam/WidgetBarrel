import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Hand
		{
			hidden var _location;
			hidden var _bitmap;

			function initialize(
				location as Dictionary<Symbol,Float>,
				bitmap as Dictionary<Symbol,Float or BitmapReference>)
			{
				self._location = location;
				self._bitmap = bitmap;
			}

			function draw(dc,angle) // angle in radians
			{
				var hand = WatchUi.loadResource(self._bitmap[:reference]);
				var transform = new Graphics.AffineTransform();
				transform.scale(self._bitmap[:scale],self._bitmap[:scale]);
				transform.rotate(angle);
				transform.translate(self._bitmap[:dx],self._bitmap[:dy]);
				dc.drawBitmap2(self._location[:x], self._location[:y], hand, {
					:transform => transform
				});
			}
		}
	}
}
