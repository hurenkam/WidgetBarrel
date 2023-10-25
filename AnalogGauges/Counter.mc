import Toybox.Graphics;
import Toybox.Lang;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Counter
		{
			hidden var _x;
			hidden var _y;
            hidden var _w;
            hidden var _h;
            hidden var _digit;
			hidden var _count = 6;
			hidden var _seperator = '.';
			hidden var _position = 5;
            hidden var _background;
            hidden var _chars = [ '0','0','0','0','0','0' ];

			var LowPower = false;
			function initialize(bounds,digit,background)
			{
				self._x = bounds[:x];
				self._y = bounds[:y];
                self._w = bounds[:w];
                self._h = bounds[:h];
                self._digit = digit;
				if (digit.hasKey(:count))
				{
					self._count = digit[:count];
				}
				if (digit.hasKey(:seperator))
				{
					self._seperator = digit[:seperator];
					self._position = digit[:position];
				}
                self._background = background;
			}

			function setClip(dc)
			{
				dc.setClip(self._x,self._y,self._w,self._h);
			}

            function setText(text as String)
            {
                var s = "000000000000000000000";
                if (text != null)
                {
                    s = s + text;
                    s = s.substring(-1*self._count,null);
                }
                self._chars = s.toCharArray();
            }

			function draw(dc)
			{
				// draw background
				self.setClip(dc);
				dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
                dc.fillRectangle(self._x, self._y, self._w, self._h);

				if ((self._background[:bitmap] != null) && !self.LowPower)
				{
					//var background = WatchUi.loadResource(self._background[:bitmap]);
					//dc.drawBitmap(self._x, self._y, background);
					var background = WatchUi.loadResource(self._background[:bitmap]);
					var wscale = self._w / background.getWidth();
					var hscale = self._h / background.getHeight();
					var transform = new Graphics.AffineTransform();
					transform.scale(wscale,hscale);
					transform.translate(-0.5 * background.getWidth(),-0.5 * background.getHeight());
					dc.drawBitmap2(self._x+0.5*self._w, self._y+0.5*self._h, background, {
						:transform => transform
					});
				}

                // draw digits
				dc.setColor(self._digit[:colors][1], _digit[:colors][0]);
				for (var i=0; i<self._count; i++)
				{
					var x = self._x + self._digit[:dx] + self._digit[:width]*i;
					var y = self._y + self._h / 2.0;
                    var text = "" + self._chars[i];
					var font = Graphics.getVectorFont({ :face => self._digit[:font], :size => self._digit[:size] });
					if (i==self._position)
					{
                        text = self._seperator+text;
					}
					dc.drawText(x,y,font,text,Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
				}
			}
		}
	}
}
