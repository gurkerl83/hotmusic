package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ArtistDetail extends Screen implements IActionButtons, IActions
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
		
		public function save():void
		{
			if (!this.artist.value)
				return;
			
			var artist:Artist = new Artist(this.artist.value);
			
			var se:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.CREATE, createResult, createFault);
			se.artist = artist;
			se.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		public function clear():void
		{
			artist.value = "";
		}
		
		public function remove():void
		{
			
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.ARTISTS_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.ARTISTS_COMPLETE, sch);
				dispatchEventWith(starling.events.Event.CLOSE);
			});
			DataHelper.getInstance().getArtists();
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			artist = new FormItem();
			artist.orderNumber = "1.";
			artist.label = "Artist name";
//			artist.value = "Red Hot Chilli Peppers";
			
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