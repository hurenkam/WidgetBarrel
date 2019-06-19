using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class ClockHand extends Hand
		{
			var hand;
			
			function initialize(position, radius, length, color, width)
			{
				Hand.initialize(position, radius);
				var x = position.getX();
				var yt = position.getY() - radius * length;			
				var yb = position.getY() + radius * 0.1;			
			
		    	var bottom = new Shapes.Position(x,yt);
				var top = new Shapes.Position(x,yb);
				hand = new Shapes.Line(bottom,top,color,width);
			}
			
			function getClip()
			{
				return hand.getClip();
			}
			
			function rotate(x,y,phi)
			{
				hand.rotate(x,y,phi);
			}
			
			function onUpdateDamage(dc,damage)
			{
				draw(dc,damage);
			}

			function draw(dc,damage)
			{
				hand.draw(dc);
			}
		}
	}
}
