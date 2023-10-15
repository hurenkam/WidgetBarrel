/*
using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class SpeedHand extends Hand
		{
			var w, h, t;
			
			function initialize(position, radius, width, height, theme)
			{
				Hand.initialize(position, radius);
				self.w = width;
				self.h = height;
				self.t = theme;
			}
			
			function getGroup()
			{
				var x = position.getX();
				var y = position.getY();
				
				return new Shapes.Group([
						new Shapes.Polygon( [[x, y+h*0.7], [x-w/2, y-h*0.1], [x,     y-h*0.1]], t.AccentDimmed, 1),
						new Shapes.Polygon( [[x, y+h*0.7], [x,     y-h*0.1], [x+w/2, y-h*0.1]], t.AccentBright, 1),
						new Shapes.Point(new Shapes.Position(x+1,y),t.Background,5)
					]);
			}
			
			function draw(dc)
			{
				var g = getGroup();
				g.rotate(position.getX(),position.getY(),angle);
				g.draw(dc);
			}
		}
	}
}
*/