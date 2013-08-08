package cz.hotmusic
{
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	
	public class AddArtistsList extends Screen
	{
		public function AddArtistsList()
		{
			super();
		}
		
		private var label:Label;
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "AddArtistsList";
			label.name = Theme.SMALL_BOLD_ORANGE;
			
			addChild(label);
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}