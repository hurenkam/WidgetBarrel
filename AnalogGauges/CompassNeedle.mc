using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class CompassNeedle extends SpeedHand
		{
			function initialize(position, radius, width, height, theme)
			{
				SpeedHand.initialize(position, radius, width, height, theme);
			}
			
			function getGroup()
			{
				var x = position.getX();
				var y = position.getY();
				
				return new Shapes.Group([
						new Shapes.Polygon( [[x, y-h*0.7], [x-w/2, y], [x,     y]], t.AccentDimmed, 1),
						new Shapes.Polygon( [[x, y-h*0.7], [x,     y], [x+w/2, y]], t.AccentBright, 1),
						new Shapes.Polygon( [[x, y+h*0.7], [x-w/2, y], [x,     y]], t.DefaultDark, 1),
						new Shapes.Polygon( [[x, y+h*0.7], [x,     y], [x+w/2, y]], t.DefaultDimmed, 1),
						new Shapes.Point(new Shapes.Position(x+1,y),t.Background,5)
					]);
			}
		}
	}
}
