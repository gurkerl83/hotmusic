package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	
	public class AlbumsList extends Screen implements IActionButtons
	{
		public function AlbumsList()
		{
			super();
		}
		
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("album")];
			}
			return _actionButtons;
		}
		
		private var label:Label;
		override protected function initialize():void
		{
			super.initialize();
			label = new Label();
			label.text = "AlbumsList";
			label.name = Theme.SMALL_BOLD_ORANGE;
			
			addChild(label);
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}