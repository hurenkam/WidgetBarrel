using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class ClockHand extends Hand
		{
			var length, color, width;
			
			function initialize(position, radius, length, color, width)
			{
				Hand.initialize(position, radius);
				self.length = length;
				self.color = color;
				self.width = width;
			}
			
			function draw(dc)
			{
				var x = position.getX();
				var yt = position.getY() - radius * length;			
				var yb = position.getY() + radius * 0.1;			
			
		    	var bottom = new Shapes.Position(x,yt);
				var top = new Shapes.Position(x,yb);
				
				var hand = new Shapes.Line(bottom,top,color,width);
				hand.rotate(position.getX(),position.getY(),angle);
				hand.draw(dc);
			}
		}
	}
}
