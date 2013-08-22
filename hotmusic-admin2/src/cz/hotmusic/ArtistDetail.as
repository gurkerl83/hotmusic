package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	
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
		
		private var _artistData:Artist;
		public function get artistData():Artist
		{
			return _artistData;
		}
		public function set artistData(value:Artist):void
		{
			_artistData = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		private var artist:FormItem;
		
		public function save():void
		{
			if (!this.artist.value)
				return;
			
			var artist:Artist = new Artist(this.artist.value);
			
			var se:ArtistServiceEvent = new ArtistServiceEvent(artistData == null ? ArtistServiceEvent.CREATE:ArtistServiceEvent.UPDATE, createResult, createFault);
			if (artistData != null) // modify artist
				artist.id = artistData.id;
			se.artist = artist;
			se.sid = Model.getInstance().user.sid;
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
				dispatchEventWith("closeDetail");
			});
			DataHelper.getInstance().getArtists(null,  function onArtistsFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			});
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
			
			artist.textinput.focusManager.focus = artist.textinput;
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
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (artistData && artistData.name)
					artist.value = artistData.name;
				if (artistData == null)
					clear();
			}
		}
	}
}