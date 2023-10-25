import Toybox.Graphics;
import Toybox.Lang;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class FacePlate
		{
			hidden var _decoration;
			hidden var _colors;
			hidden var _background;
			hidden var _x;
			hidden var _y;
			hidden var _r;

			var LowPower = false;
			function initialize(location, decoration, colors, background)
			{
				self._x = location["x"];
				self._y = location["y"];
				self._r = location["r"];
				self._decoration = decoration;
				self._colors = colors;
				self._background = background;
			}

			function setClip(dc)
			{
				dc.setClip(self._x-self._r,self._y-self._r,self._r*2,self._r*2);
			}

			function setDecoration(decoration)
			{
				self._decoration = decoration;
			}

			function draw(dc)
			{
				var backgroundColor = self._colors["Background"].toNumberWithBase(16);
				var textColor =       self._colors["Text"].toNumberWithBase(16);
				var stripesColor =    self._colors["Stripes"].toNumberWithBase(16);
				var dotsColor =       self._colors["Dots"].toNumberWithBase(16);

				// draw background
				self.setClip(dc);
				dc.setColor(backgroundColor, backgroundColor);
				dc.fillCircle(self._x, self._y, self._r);
				if ((self._background != null) && !self.LowPower)
				{
					var background = WatchUi.loadResource(self._background);
					dc.drawBitmap(self._x-self._r, self._y-self._r, background);
				}

				var chars = self._decoration["Format"].toCharArray();
				var font = self._decoration["Font"];
				var argc = 0;
				var angle = 90; // top
				var angle_inc = 360.0 / chars.size();

				// draw dots and numbers
				for (var i = 0; i < chars.size(); i++)
				{
					var text = "" + chars[i];
					var size = self._decoration["Size"]*0.7;
					var pos = self._r * 0.95;

					dc.setColor(dotsColor, backgroundColor);

					if (text.equals("*"))
					{
						text = self._decoration["Args"][argc];
						pos = self._r * 0.90;
						size = self._decoration["Size"];
						argc += 1;
						dc.setColor(textColor, backgroundColor);
					}

					if (text.equals("|"))
					{
						dc.setColor(stripesColor, backgroundColor);
					}

					if (!text.equals(" "))
					{
						dc.drawRadialText(
							self._x, self._y, Graphics.getVectorFont({ :face => font, :size => size }), 
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
