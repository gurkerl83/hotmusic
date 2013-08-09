package cz.hotmusic
{
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ArtistDetail extends Screen implements IActionButtons
	{
		public function ArtistDetail()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().saveButton, ButtonHelper.inst().cancelButton];
			}
			return _actionButtons;
		}
		
		private var artist:FormItem;
		
		override protected function initialize():void
		{
			super.initialize();
			
			artist = new FormItem();
			artist.orderNumber = "1.";
			artist.label = "Artist name";
			artist.value = "Red Hot Chilli Peppers";
			
			addChild(artist);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
			
			artist.x = padding;
			artist.y = padding;
			artist.width = actualWidth - 2*padding;
		}
	}
}