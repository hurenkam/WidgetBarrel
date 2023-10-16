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

/*
using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Hand
		{
			var position,radius,angle;
			
			function initialize(position,radius)
			{
				self.position = position;
				self.radius = radius;
			}
			
			function updateAngle(angle)
			{
				self.angle = angle;
			}
			
			function draw(dc)
			{
			}
		}
	}
}
*/