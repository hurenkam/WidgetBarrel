using WidgetBarrel.PrimitiveShapes as Shapes;

module WidgetBarrel
{
	(:AnalogGauges)
	module AnalogGauges
	{
		class DarkTheme
		{
			const Background =    0x000000;
			
			const DefaultBright = 0xffffff;
			const DefaultDimmed = 0xaaaaaa;
			const DefaultDark =   0x555555;
			
			const AccentBright =  Graphics.COLOR_BLUE; //0x00AAFF;
			const AccentDimmed =  Graphics.COLOR_DK_BLUE; //0x0000FF;
			const AccentDark =    0x000055;
		}
		
		class LightTheme
		{
			const Background =    0xFFFFFF;
			
			const DefaultBright = 0x000000;
			const DefaultDimmed = 0x555555;
			const DefaultDark =   0xAAAAAA;
			
			const AccentBright =  0xFF5500;
			const AccentDimmed =  0xFFFF00;
			const AccentDark =    0xFFFFAA;
		}
	}
}