import Toybox.Graphics;
import Toybox.Lang;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Gauge
		{
			hidden var _location;
			hidden var _decoration;
			hidden var _colors;
			hidden var _background;

			var LowPower = false;
			function initialize(properties, background)
			{
				self._location = properties["Location"];
				self._decoration = properties["Decoration"];
				self._colors = properties["Colors"];
				self._background = background;
			}

			function draw(dc)
			{
				var backgroundColor = self._colors["Background"].toNumber();
				var textColor =       self._colors["Text"].toNumber();
				var stripesColor =    self._colors["Stripes"].toNumber();
				var dotsColor =       self._colors["Dots"].toNumber();

				backgroundColor = Graphics.COLOR_BLACK;
				textColor =       Graphics.COLOR_BLUE;
				stripesColor =    Graphics.COLOR_BLUE;
				dotsColor =       Graphics.COLOR_WHITE;

				// draw background
				dc.setClip(self._location["x"]-self._location["r"],self._location["y"]-self._location["r"],self._location["r"]*2,self._location["r"]*2);
				dc.setColor(backgroundColor, backgroundColor);
				dc.fillCircle(self._location["x"], self._location["y"], self._location["r"]);
				if ((self._background != null) && !self.LowPower)
				{
					var background = WatchUi.loadResource(self._background);
					dc.drawBitmap(self._location["x"]-self._location["r"], self._location["y"]-self._location["r"], background);
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
					var pos = self._location["r"] * 0.95;

					dc.setColor(dotsColor, backgroundColor);

					if (text.equals("*"))
					{
						text = self._decoration["Args"][argc];
						pos = self._location["r"] * 0.90;
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
							self._location["x"], self._location["y"], Graphics.getVectorFont({ :face => font, :size => size }), 
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
