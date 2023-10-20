import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Clock extends Gauge
		{
			hidden var _hours;
			hidden var _minutes;
			hidden var _seconds;
			hidden var _previousSeconds = 0;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties, bitmaps);

				self._hours = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:HourHand]}
				);
				self._minutes = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:MinuteHand]}
				);
				self._seconds = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:SecondHand]}
				);
			}

			function drawHands(dc)
			{
				Gauge.drawHands(dc);
				var time = System.getClockTime();

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
		}
	}
}
