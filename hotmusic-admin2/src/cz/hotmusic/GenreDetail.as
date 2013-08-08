package cz.hotmusic
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GenreDetail extends Screen
	{
		public function GenreDetail()
		{
			super();
		}
		
		private var label:Label;
		
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "GenreDetail";
			label.name = Theme.SMALL_BOLD_ORANGE;
			
			addChild(label);
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}