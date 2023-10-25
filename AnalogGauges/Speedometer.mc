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
		class Speedometer extends Gauge
		{
			hidden var _hand;
			hidden var _maxHand;
			hidden var _counter;
			hidden var _counter2;
			hidden var _averageHand;
			hidden var _speedInfo = {
				"current" => null,
				"average" => null,
				"max" => null
			};
			hidden var _distanceInfo = {
				"elapsed" => null
			};
			hidden var _multiplier;
			hidden var _decorationList;
			hidden var _counterBackground;

			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties["Location"],properties["Decoration"][0],properties["Colors"],bitmaps);
				self._multiplier = properties["Decoration"][0]["Multiplier"];
				self._decorationList = properties["Decoration"];				
				var scale = properties["Location"]["r"]/120.0;

				self._hand = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:SpeedNeedle]}
				);

				self._maxHand = new Hand(
					{:x => self._x, :y => self._y},
					{:dx => self._dx, :dy => self._dy, :scale => self._scale, :reference => bitmaps[:SecondHand]}
				);

				if (properties.hasKey("Counter"))
				{
					var w = properties["Counter"]["w"];
					var wxc = properties["Counter"]["#"]*properties["Counter"]["w"]+2;
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
							:size => size },
						{   :bitmap => bitmaps[:Counter] }
					);
				}
			}

			function mpsToKilometersPerHour(speed)
			{
				if (speed == null) { return null; }
				return speed * 3.6;
			}

			function mpsToMilesPerHour(speed)
			{
				if (speed == null) { return null; }
				return speed * 2.237;
			}

			function updateInfo(info as Activity.Info)
			{
				Gauge.updateInfo(info);
				if (info != null)
				{
					self._speedInfo["average"] = info.averageSpeed;
					self._speedInfo["current"] = info.currentSpeed;
					self._speedInfo["max"] = info.maxSpeed;

					self._distanceInfo["elapsed"] = info.elapsedDistance;
					selectAppropriateDecoration();
				}
			}

			function selectAppropriateDecoration()
			{
				var max = 0;
				//var averageSpeed = self.mpsToKilometersPerHour(self._speedInfo["average"]);
				var currentSpeed = self.mpsToKilometersPerHour(self._speedInfo["current"]);
				var maxSpeed = self.mpsToKilometersPerHour(self._speedInfo["max"]);

				//if ((averageSpeed != null) && (averageSpeed > max)) { max = averageSpeed; }
				if ((currentSpeed != null) && (currentSpeed > max)) { max = currentSpeed; }
				if ((maxSpeed != null)     && (maxSpeed > max))     { max = maxSpeed; }

				var count = self._decorationList.size();
				var i = 0;
				while ((i < count) && (self._decorationList[i]["Range"] < max))
				{
					i = i + 1;
				}

				if (i >= count)
				{
					i = count-1;
				}

				self._face.setDecoration(self._decorationList[i]);
				self._multiplier = self._decorationList[i]["Multiplier"];
			}

			function drawHands(dc)
			{
				Gauge.drawHands(dc);
				if (self._distanceInfo["elapsed"] != null)
				{
					var distance = (self._distanceInfo["elapsed"] / 100).toNumber().toString();
					self._counter.setText(distance);
				}

				if (self._counter != null)
				{
					self._counter.draw(dc);
				}

				self._face.setClip(dc);
				var pace = self.mpsToKilometersPerHour(self._speedInfo["current"]);
				if (pace != null)
				{
					var offset = Math.PI * 1.2;
					var multiplier = (2 * Math.PI) / self._multiplier;
					var angle = offset + pace * multiplier;
					self._hand.draw(dc,angle);
				}

				var max = self.mpsToKilometersPerHour(self._speedInfo["max"]);
				if (max != null)
				{
					var offset = Math.PI * 1.2;
					var multiplier = (2 * Math.PI) / self._multiplier;
					var angle = offset + max * multiplier;
					self._maxHand.draw(dc,angle);
				}
			}
		}
	}
}
