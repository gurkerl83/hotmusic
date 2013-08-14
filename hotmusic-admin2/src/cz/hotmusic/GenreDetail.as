package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GenreDetail extends Screen implements IActionButtons, IActions
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
		
		public function save():void
		{
			if (!this.genre.value)
				return;
			
			var genre:Genre = new Genre(this.genre.value);
			
			var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.CREATE, createResult, createFault);
			se.genre = genre;
			se.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		public function clear():void
		{
			genre.value = "";
		}
		
		public function remove():void
		{
			
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.GENRES_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.GENRES_COMPLETE, sch);
				dispatchEventWith(starling.events.Event.CLOSE);
			});
			DataHelper.getInstance().getGenres();
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			genre = new FormItem();
			genre.orderNumber = "1.";
			genre.label = "Genre name";
//			genre.value = "Pop/Rock";
			
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