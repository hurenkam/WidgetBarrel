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
		class Altimeter extends Gauge
		{
			hidden var _hand;
			hidden var _maxHand;
			hidden var _counter;
			hidden var _averageHand;
			hidden var _altitude = {
				"current" => null,
				"destination" => null,
				"nextpoint" => null,
				"ascent" => null,
				"descent" => null
				// would like to have a max but doesn't seem to be available...
			};
			hidden var _multiplier;
			hidden var _decorationList;


			function initialize(properties, bitmaps)
			{
				Gauge.initialize(properties["Location"],properties["Decoration"][0],properties["Colors"],bitmaps);
				self._multiplier = properties["Decoration"][0]["Multiplier"];

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

			function selectAppropriateDecoration()
			{
				var max = 0;
				var current = self._altitude["current"];
				var destination = self._altitude["destination"];
				//var nextpoint = self._altitude["nextpoint"];
				//var ascent = self._altitude["ascent"];
				//var descent = self._altitude["descent"];

				if ((current     != null) && (current     > max)) { max = current; }
				if ((destination != null) && (destination > max)) { max = destination; }
				//if ((nextpoint   != null) && (nextpoint   > max)) { max = nextpoint; }
				//if ((ascent      != null) && (ascent      > max)) { max = ascent; }
				//if ((descent     != null) && (descent     > max)) { max = descent; }

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


			function updateInfo(info as Activity.Info)
			{
				Gauge.updateInfo(info);
				if (info != null)
				{
					self._altitude["current"] = info.altitude;
					self._altitude["destination"] = info.elevationAtDestination;
					self._altitude["nextpoint"] = info.elevationAtNextPoint;
					self._altitude["ascent"] = info.totalAscent;
					self._altitude["descent"] = info.totalDescent;
				}
			}

			function drawHands(dc)
			{
				Gauge.drawHands(dc);

				if (self._altitude["ascent"] != null)
				{
					var ascent = (self._altitude["ascent"] / 100).toNumber().toString();
					self._counter.setText(ascent);
				}

				if (self._counter != null)
				{
					self._counter.draw(dc);
				}

				self._face.setClip(dc);
				var current = self._altitude["current"];
				if (current != null)
				{
					var offset = Math.PI;
					var multiplier = (2 * Math.PI) / self._multiplier;
					var angle = offset + current * multiplier;
					self._hand.draw(dc,angle);
				}

				self._face.setClip(dc);
				var destination = self._altitude["destination"];
				if (destination != null)
				{
					var offset = Math.PI * 1;
					var multiplier = (2 * Math.PI) / self._multiplier;
					var angle = offset + destination * multiplier;
					self._maxHand.draw(dc,angle);
				}
			}
		}
	}
}
