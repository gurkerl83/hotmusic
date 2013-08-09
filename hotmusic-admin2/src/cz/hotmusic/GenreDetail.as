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
	
	public class GenreDetail extends Screen implements IActionButtons
	{
		public function GenreDetail()
		{
			super();
		}
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().saveButton, ButtonHelper.inst().cancelButton, ButtonHelper.inst().clearButton];
			}
			return _actionButtons;
		}
		
		private var genre:FormItem;
		
		override protected function initialize():void
		{
			super.initialize();
			
			genre = new FormItem();
			genre.orderNumber = "1.";
			genre.label = "Genre name";
			genre.value = "Pop/Rock";
			
			addChild(genre);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 6;
			var gap:int = 20;
			
			genre.x = padding;
			genre.y = padding;
			genre.width = actualWidth - 2*padding;
		}
	}
}