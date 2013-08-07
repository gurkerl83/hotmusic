package cz.hotmusic
{
	import cz.hotmusic.component.Header;
	
	import feathers.controls.Label;
	import feathers.controls.Screen;
	
	public class MainScreen extends Screen
	{
		public function MainScreen()
		{
			super();
		}
		
		private var label:Label;
		private var header:Header;
		
		override protected function initialize():void {
			super.initialize();
			
			header = new Header();
			
			addChild(header);
		}
		
		override protected function draw():void {
			super.draw();
			
//			header.height = 100;
			header.width = actualWidth;
		}
	}
}