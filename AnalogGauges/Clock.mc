import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;

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
			hidden var _counter;
			hidden var _timeInfo = { "current" => null, "elapsed" => null };
			hidden var _previousSeconds = 0;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties["Location"], properties["Decoration"], properties["Colors"], bitmaps);

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

				if (properties.hasKey("Counter"))
				{
					var w = properties["Counter"]["w"];
					var wxc = properties["Counter"]["#"]*properties["Counter"]["w"]+2;
					var count = properties["Counter"]["#"];
					var h = properties["Counter"]["h"];
					var x = self._x - wxc/2.0 -1;
					var y = properties["Counter"]["y"];
					var size = properties["Counter"]["size"];
					self._counter = new Counter(
						{   :x => x,
							:y => y,
							:w => wxc,
							:h => h },
						{	:font => "BionicBold",
							//          bacground            high                 low
							:colors => [Graphics.COLOR_TRANSPARENT,Graphics.COLOR_LT_GRAY,Graphics.COLOR_BLUE],
							:dx => w/2.0,
							:width => w,
							:count => count,
							:seperator => ':',
							:position => 2,
							:size => size },
						{   :bitmap => bitmaps[:Counter] }
					);
				}
			}

			function updateInfo(info as Activity.Info)
			{
				Gauge.updateInfo(info);
				self._timeInfo["current"] = getSystemTime();
				self._timeInfo["elapsed"] = getElapsedTime(info);
			}

			function getSystemTime()
			{
				var time = System.getClockTime();
				return { :hours => time.hour, :minutes => time.min, :seconds => time.sec };
			}

			function getElapsedTime(info)
			{
				if ((info == null) || (info.elapsedTime == null) || (info.elapsedTime == 0)) { return null; }

				var hours = info.elapsedTime / (3600 * 1000);
				var minutes = info.elapsedTime / (60 * 1000) - (hours * 60);
				var seconds = info.elapsedTime / 1000 - (hours * 3600) - (minutes * 60);

				return { :hours => hours, :minutes => minutes, :seconds => seconds };
			}

			function drawHands(dc as Dc)
			{
				Gauge.drawHands(dc);
				var hands;
				var counter;

				if (self._timeInfo["elapsed"] != null)
				{
					hands = self._timeInfo["elapsed"];
					counter = self._timeInfo["current"];

				} else {
					hands = self._timeInfo["current"];
					counter = self._timeInfo["current"];
				}

				if (self._counter != null)
				{
					self.drawCounter(dc, counter[:hours], counter[:minutes]);
				}

				self._face.setClip(dc);
				self.drawHoursHand(dc, hands[:hours], hands[:minutes]);
				self.drawMinutesHand(dc, hands[:minutes]);

				if (!self._sleeping)
				{
					self.drawSecondsHand(dc, hands[:seconds]);
				}
			}

			function drawCounter(dc as Dc, hours, minutes)
			{
				var text = Lang.format(
						"$1$$2$",
						[hours.format("%02d"), minutes.format("%02d")]
					);

				self._counter.setText(text);
				self._counter.draw(dc);
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
