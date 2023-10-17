import Toybox.Graphics;
import Toybox.Lang;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Gauge
		{
			hidden var _location as Dictionary<Symbol,Number>;
			hidden var _colors as Dictionary<Symbol,Graphics.ColorValue>;
			hidden var _format as Array<String>;

			var LowPower = false;

			function initialize(location as Dictionary<Symbol,Number>, colors as Dictionary<Symbol,Graphics.ColorValue>, format as Array<String>)
			{
				self._location = location;
				self._colors = colors;
				self._format = format;
			}
			
			function draw(dc)
			{
				// draw background
				dc.setClip(self._location[:x]-self._location[:radius],self._location[:y]-self._location[:radius],self._location[:radius]*2,self._location[:radius]*2);
				dc.setColor(self._colors[:background], self._colors[:background]);
				dc.fillCircle(self._location[:x], self._location[:y], self._location[:radius]);
				if (self._location[:fullscreen]==1 && !self.LowPower)
				{
					var background = WatchUi.loadResource(Rez.Drawables.Background);
					dc.drawBitmap(0, 0, background);
				}

				var chars = self._format[0].toCharArray();
				var font = self._format[1];
				var format_count = 2;
				var angle = 90; // top
				var angle_inc = 360.0 / chars.size();

				// draw dots and numbers
				for (var i = 0; i < chars.size(); i++)
				{
					var text = "" + chars[i];
					var size = self._location[:size]/2;
					var pos = self._location[:radius] * 0.97;

					dc.setColor(self._colors[:dots], self._colors[:background]);

					if (text.equals("*"))
					{
						text = self._format[format_count];
						pos = self._location[:radius] * 0.94;
						size = self._location[:size];
						format_count += 1;
						dc.setColor(self._colors[:text], self._colors[:background]);
					}

					if (text.equals("|"))
					{
						dc.setColor(self._colors[:stripes], self._colors[:background]);
					}

					if (!text.equals(" "))
					{
						dc.drawRadialText(
							self._location[:x], self._location[:y], Graphics.getVectorFont({ :face => font, :size => size }), 
							text, 
							Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER, 
							angle, pos, 
							Graphics.RADIAL_TEXT_DIRECTION_CLOCKWISE
						);
					}

					angle -= angle_inc;
				}
			}
		}
	}
}
