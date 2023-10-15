/*
// ------------------------------
// Example use of the Gauge class
// ------------------------------

import Toybox.WatchUi;

using WidgetBarrel.AnalogGauges as Gauges;

class WatchFaceView extends WatchUi.WatchFace {
    hidden var _outer;
    hidden var _topleft;
    hidden var _topright;
    hidden var _bottom;

    function initialize() {
        WatchFace.initialize();

        self._outer = new Gauges.Gauge(
            { :x => 227, :y => 227, :radius => 227, :size => 48, :fullscreen => 1 },
            { :text => Graphics.COLOR_BLUE, :stripes => Graphics.COLOR_BLUE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
            ["*....|....|....*....|....|         |....|....*....|....|....","12","3","9"]
        );

        self._topleft = new Gauges.Gauge(
            { :x => 227-90, :y => 227-80, :radius => 70, :size => 24, :fullscreen => 0 },
            { :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
            ["*.|.*.|.*.|.*.|.*.|.*.|.*.|.*.|.","N","|","E","|","S","|","W","|"]
        );

        self._topright = new Gauges.Gauge(
            //{ :x => 227+90, :y => 227-80, :radius => 70, :size => 24 },
            { :x => 227+90, :y => 227-80, :radius => 70, :size => 24, :fullscreen => 0 },
            { :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
            ["*....|....*....|         |....*....|....","2k","3k","1k"]
            // Analog Clock:   ["*....|....|....*....|....|....*....|....|....*....|....|....","12","3","6","9"]
            // Altitude:       ["*....|....*....|....*         *....|....*....|....","5k","7k","9k","1k","3k"]
            // Heading:        ["*.|.*.|.*.|.*.|.*.|.*.|.*.|.*.|.","N","|","E","|","S","|","W","|"]
        );

        self._bottom = new Gauges.Gauge(
            { :x => 227, :y => 227+140, :radius => 120, :size => 28, :fullscreen => 0 },
            { :text => Graphics.COLOR_WHITE, :stripes => Graphics.COLOR_WHITE, :dots => Graphics.COLOR_WHITE, :background => Graphics.COLOR_BLACK },
            ["*|*|*|*       *|*|*|","20","15","10","5","35","30","25"]
            //["* ...|... * ...|... * ...|... *                                       * ...|... * ...|... * ...|... ","70","90","110","130","10","30","50"]
            // Hiking pace:          ["*|*|*|*       *|*|*|","20","15","10","5","35","30","25"]
            // Cycling speed:        ["*|*|*|*       *|*|*|","20","25","30","35","5","10","15"]
            // Car speed:            ["*|*|*|*       *|*|*|","70","90","110","130","10","30","50"]
            // Analog Clock:         ["*....|....|....*....|....|         |....|....*....|....|....","12","3","9"]
        );
    }

    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        self._outer.draw(dc);
        self._topleft.draw(dc);
        self._topright.draw(dc);
        self._bottom.draw(dc);
    }
}
*/

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
//import Toybox.WatchUi;
using WidgetBarrel.PrimitiveShapes as Shapes;

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

			function initialize(location as Dictionary<Symbol,Number>, colors as Dictionary<Symbol,Graphics.ColorValue>, format as Array<String>)
			{
				self._location = location;
				self._colors = colors;
				self._format = format;
			}
			
			//function drawGauge(dc as Dc, location as Dictionary<Symbol,Number>, colors as Dictionary<Symbol,Graphics.ColorValue>, format as Array<String>) as Void {
			function draw(dc)
			{
				// draw background
				if (self._location[:fullscreen] == 0)
				{
					dc.setColor(self._colors[:background], self._colors[:background]);
					dc.fillCircle(self._location[:x], self._location[:y], self._location[:radius]);
				} else {
					var background = WatchUi.loadResource(Rez.Drawables.Background_454);
					dc.drawBitmap(0, 0, background);
				}

				var chars = self._format[0].toCharArray();
				var format_count = 1;
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
							self._location[:x], self._location[:y], Graphics.getVectorFont({ :face => "BionicBold", :size => size }), 
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

/*		
// ------------------
// v0.0.1 Gauge class
// ------------------

using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Gauge
		{
			var position,r,t,w;
			
			function initialize(x, y, r, t, w)
			{
				position = new Shapes.Position(x,y);
				self.r = r;
				self.t = t;
				self.w = w;
			}
			
			function move(x,y)
			{
				position.move(x,y);
			}
			
			function rotate(xr,yr,phi)
			{
				position.rotate(xr,yr,phi);
			}
			
			function onUpdate(dc)
			{
				draw(dc);
			}
			
			function draw(dc)
			{
				drawFace(dc);
			}
			
			function drawFace(dc)
			{
				var p = position.get();
				var x = p[0];
				var y = p[1];
				
				dc.setClip(x-r, y-r, r*2, r*2);
				dc.setColor(t.Background, t.Background);
		    	dc.setPenWidth(1);
				dc.fillCircle(x, y, r);
			}
			
		    function drawTickMarks(dc, start, count, divider, width, length, color)
		    {
				// Divide the circle in <divider> ticks
				// Draw <count> of them
				// Starting at position of the <start> tick clockwise from top
				
				var p = position.get();
				var x = p[0];
				var y = p[1];
				
				dc.setClip(x-r, y-r, r*2, r*2);
		    	dc.setPenWidth(width);
		    	dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		    	
		    	for (var tick = start; tick < start+count; tick++)
		    	{
		    		var angle = 2 * Math.PI * tick / divider;
			    	var x1 = (r-3) * Math.sin(angle);
			    	var y1 = (r-3) * Math.cos(angle + Math.PI);
			    	
			    	var x2 = (r-3-length) * Math.sin(angle);
			    	var y2 = (r-3-length) * Math.cos(angle + Math.PI);
			    	
			    	if (length <= 1)
			    	{
		    			dc.drawPoint(x+x1,y+y1);
		    		}
		    		else
		    		{
				    	dc.drawLine(x+x1,y+y1,x+x2,y+y2);
				    }
		    	}
		    }
		    
		    function drawNumber(dc, number, degrees, color, font)
		    {
				var radians = 2 * Math.PI * degrees / 360.0;
				
		        var dimensions = dc.getTextDimensions(number,font);
		        var w = dimensions[0];
		        var h = dimensions[1];
		        
		    	var x = position.getX() + 0.8 * (r-w/2) * Math.sin(radians);
		    	var y = position.getY() + 0.9 * (r-h/2) * Math.cos(radians + Math.PI);
				
		    	dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		        dc.drawText(x,y,font,number,Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		    }
		    
			function drawHand(dc, style, angle)
			{
				var hand = new Hand(style,t);
				hand.rotate(angle);
				hand.draw(dc);
			}
		}
	}
}
*/
