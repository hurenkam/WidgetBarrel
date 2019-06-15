using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class Hand
		{
			var position,radius,angle;
			
			function initialize(position,radius)
			{
				self.position = position;
				self.radius = radius;
			}
			
			function updateAngle(angle)
			{
				self.angle = angle;
			}
			
			function draw(dc)
			{
			}
		}
	}
}
