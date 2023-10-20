import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Clock
		{
			hidden var _properties;
			hidden var _bitmaps;

			hidden var _face;
			hidden var _hours;
			hidden var _minutes;
			hidden var _seconds;
			hidden var _supportsPartialUpdate = false;
			hidden var _sleeping = false;
			hidden var _previousSeconds = 0;

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

				var x = properties["Location"]["x"];
				var y = properties["Location"]["y"];
				var r = properties["Location"]["r"];
				var dx = bitmaps[:dx];
				var dy = bitmaps[:dy];
				var scale = bitmaps[:scale];
				var fontsize = properties["Decoration"]["Size"];

				self._face = new Gauge(properties, bitmaps[:Background]);

				self._hours = new Hand(
					{:x => x, :y => y},
					{:dx => dx, :dy => dy, :scale => scale, :reference => bitmaps[:HourHand]}
				);
				self._minutes = new Hand(
					{:x => x, :y => y},
					{:dx => dx, :dy => dy, :scale => scale, :reference => bitmaps[:MinuteHand]}
				);
				self._seconds = new Hand(
					{:x => x, :y => y},
					{:dx => dx, :dy => dy, :scale => scale, :reference => bitmaps[:SecondHand]}
				);
			}

			function drawFace(dc)
			{
				self._face.draw(dc);
			}

			function drawHands(dc,time)
			{
				self._face.setClip(dc);

				self.drawHoursHand(dc,time.hour,time.min);
				self.drawMinutesHand(dc,time.min);
				if (!self._sleeping)
				{
					self.drawSecondsHand(dc, time.sec);
				}
			}

			function drawHoursHand(dc as Dc, hours, minutes)
			{
				var minuteangle = (minutes/60.0) * 2.0 * Math.PI;
				var hourangle = (hours/12.0) * 2.0 * Math.PI + minuteangle/12;
				self._hours.draw(dc,hourangle);
			}

			function drawMinutesHand(dc as Dc, minutes)
			{
				var angle = (minutes/60.0) * 2.0 * Math.PI;
				self._minutes.draw(dc,angle);
			}

			function clearSecondsHand(dc as Dc, buffer as BufferedBitmap)
			{
				var x = dc.getWidth()/2;
				var y = x;
				var r = x * 0.9;
				var a = ((self._previousSeconds)/60.0) * 2.0 * Math.PI;

				var o = self.rotate(x,y-r,x,y,a);
				self.setClipRegion(dc,x,y,o);
				dc.drawBitmap(0,0,buffer);
			}

			function drawSecondsHand(dc as Dc, seconds)
			{
				self._previousSeconds = seconds;

				var x = dc.getWidth()/2;
				var y = x;
				var r = x * 0.9;
				var a = (seconds/60.0) * 2.0 * Math.PI;

				var o = self.rotate(x,y-r,x,y,a);
				if (self._supportsPartialUpdate)
				{
					self.setClipRegion(dc,x,y,o);
					dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLUE);
					dc.setPenWidth(2);
					dc.drawLine(x,y,o[:x],o[:y]);

					// this takes too much cpu time in low power mode...
					//self._seconds.draw(dc,a);
				} else {
					self._seconds.draw(dc,a);
				}
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
