import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Gauge
		{
			protected var _properties;
			protected var _bitmaps;

			protected var _x;
			protected var _y;
			protected var _r;
			protected var _dx;
			protected var _dy;
			protected var _scale;
			protected var _fontsize;

			protected var _face;
			protected var _supportsPartialUpdate = false;
			protected var _sleeping = false;

			function onEnterSleep()
			{
				self._sleeping = true;
				if (!self._supportsPartialUpdate)
				{
					self._face.LowPower = true;
				}
			}

			function onExitSleep()
			{
				self._sleeping = false;
				if (!self._supportsPartialUpdate)
				{
					self._face.LowPower = false;
				}
			}

			function initialize(properties, bitmaps)
			{
				if (WatchUi.WatchFace has :onPartialUpdate )
				{
					self._supportsPartialUpdate = true;
				}

				self._properties = properties;
				self._bitmaps = bitmaps;

				self._x = properties["Location"]["x"];
				self._y = properties["Location"]["y"];
				self._r = properties["Location"]["r"];
				self._dx = bitmaps[:dx];
				self._dy = bitmaps[:dy];
				self._scale = bitmaps[:scale];
				self._fontsize = properties["Decoration"]["Size"];

				self._face = new FacePlate(properties, bitmaps[:Background]);
			}

			function drawFace(dc)
			{
				self._face.draw(dc);
			}

			function drawHands(dc)
			{
				self._face.setClip(dc);
			}
            
			function setClipRegion(dc as Dc,x,y,o)
			{
				var w = o[:x]-x;
				var h = o[:y]-y;

				if (w < 0)
				{
					x = o[:x];
					w = -1 * w;
				}

				if (h < 0)
				{
					y = o[:y];
					h = -1 * h;
				}

				dc.setClip(x-2,y-2,w+4,h+4);
			}

			function rotate(x,y,xr,yr,phi) as Dictionary<Symbol,Float>
			{
				var sin = Math.sin(phi);
				var cos = Math.cos(phi);
				
				var xt = x - xr;
				var yt = y - yr;
				
				var xn = xt * cos - yt * sin;
				var yn = xt * sin + yt * cos;
					
				x = xn + xr;
				y = yn + yr;

				return {:x => x, :y => y };
			}
		}
	}
}
