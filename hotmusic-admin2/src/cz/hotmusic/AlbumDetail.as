package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.model.Model;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AlbumDetail extends Screen implements IActionButtons, IActions
	{
		public function AlbumDetail()
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
		
		private var _data:Object;
		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			_data = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function save():void
		{
			if (!albumname.value || !artistname.selectedItem || !genre.selectedItem || DateHelper.parsePHPDate(releasedate.value) == null )
				return;
			
			var album:Album = new Album();
			album.name = albumname.value;
			album.artist = Artist(artistname.selectedItem);
			album.genre = Genre(genre.selectedItem);
			album.releaseDate = DateHelper.parsePHPDate(releasedate.value);
			album.itunes = itunes.value;
			album.googlePlay = google.value;
			album.amazon = amazon.value;
			album.beatport = beatport.value;
			
			var se:AlbumServiceEvent = new AlbumServiceEvent(data == null ? AlbumServiceEvent.CREATE:AlbumServiceEvent.UPDATE, createResult, createFault);
			if (data != null) // modify
				album.id = data.id;
			se.album = album;
			se.sid = Model.getInstance().user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.ALBUMS_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.ALBUMS_COMPLETE, sch);
				dispatchEventWith("closeDetail");
			});
			DataHelper.getInstance().getAlbums(null,  function onAlbumsFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			});
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		public function clear():void
		{
			albumname.value = "";
			artistname.selectedItem = null;
			genre.selectedItem = null;
			releasedate.value = DateHelper.formatDateUS(new Date());
			itunes.value = "";
			google.value = "";
			amazon.value = "";
			beatport.value = "";
		}
		
		public function remove():void
		{
			
		}
		
		private var albumname:FormItem;
		private var artistname:FormItem;
		private var genre:FormItem;
		private var releasedate:FormItem;
		private var itunes:FormItem;
		private var google:FormItem;
		private var amazon:FormItem;
		private var beatport:FormItem;
		
		override protected function initialize():void
		{
			super.initialize();
			
			albumname = new FormItem();
			albumname.orderNumber = "1.";
			albumname.label = "Album name";
//			albumname.value = "Slash";

			var ase:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.AUTOCOMPLETE, null, null);
			ase.sid = Model.getInstance().user.sid;
			artistname = new FormItem();
			artistname.orderNumber = "2.";
			artistname.label = "Artist name";
			artistname.isAutocomplete = true;
			artistname.serviceEvent = ase;
			
			var gse:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.AUTOCOMPLETE, null, null);
			gse.sid = Model.getInstance().user.sid;
			genre = new FormItem();
			genre.orderNumber = "3.";
			genre.label = "Genre";
			genre.isAutocomplete = true;
			genre.serviceEvent = gse;
			
			releasedate = new FormItem();
			releasedate.orderNumber = "4.";
			releasedate.label = "Release date";
			
			itunes = new FormItem();
			itunes.orderNumber = "5.";
			itunes.label = "iTunes link to buy";
			
			google = new FormItem();
			google.orderNumber = "6.";
			google.label = "Google Play link to buy";
			
			amazon = new FormItem();
			amazon.orderNumber = "7.";
			amazon.label = "Amazon link to buy";
			
			beatport = new FormItem();
			beatport.orderNumber = "8.";
			beatport.label = "Beatport link to buy";
			
			addChild(beatport);
			addChild(amazon);
			addChild(google);
			addChild(itunes);
			addChild(releasedate);
			addChild(genre);
			addChild(artistname);
			addChild(albumname);
			
			albumname.nextTabFocus = artistname.autocomplete.textinput;
			artistname.nextTabFocus = genre.autocomplete.textinput;
			genre.nextTabFocus = releasedate.textinput;
			releasedate.nextTabFocus = itunes.textinput;
			itunes.nextTabFocus = google.textinput;
			google.nextTabFocus = amazon.textinput;
			amazon.nextTabFocus = beatport.textinput;
			beatport.nextTabFocus = albumname.textinput;
			
			albumname.previousTabFocus = beatport.textinput;
			artistname.previousTabFocus = albumname.textinput;
			genre.previousTabFocus = artistname.autocomplete.textinput;
			releasedate.previousTabFocus = genre.autocomplete.textinput;
			itunes.previousTabFocus = releasedate.textinput;
			google.previousTabFocus = itunes.textinput;
			amazon.previousTabFocus = google.textinput;
			beatport.previousTabFocus = amazon.textinput;
			
			releasedate.textinput.restrict = "0-9\\-";
			
			albumname.textinput.focusManager.focus = albumname.textinput;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
			
			albumname.x = padding;
			albumname.y = padding;
			albumname.width = actualWidth - 2*padding;
			
			artistname.x = padding;
			artistname.y = albumname.y + albumname.height + formgap;
			artistname.width = actualWidth - 2*padding;
			
			genre.x = padding;
			genre.y = artistname.y + artistname.height + formgap;
			genre.width = actualWidth - 2*padding;
			
			releasedate.x = padding;
			releasedate.y = genre.y + genre.height + gap;
			releasedate.width = actualWidth - 2*padding;
			
			itunes.x = padding;
			itunes.y = releasedate.y + releasedate.height + gap;
			itunes.width = actualWidth - 2*padding;
			
			google.x = padding;
			google.y = itunes.y + itunes.height + formgap;
			google.width = actualWidth - 2*padding;
			
			amazon.x = padding;
			amazon.y = google.y + google.height + formgap;
			amazon.width = actualWidth - 2*padding;
			
			beatport.x = padding;
			beatport.y = amazon.y + amazon.height + formgap;
			beatport.width = actualWidth - 2*padding;
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (data && data.name)
					albumname.value = data.name;
				if (data && data.artist)
					artistname.selectedItem = data.artist;
				if (data && data.genre)
					genre.selectedItem = data.genre;
				if (data)
					releasedate.value = DateHelper.formatDateUS(data.releaseDate);
				if (data && data.itunes)
					itunes.value = data.itunes;
				if (data && data.googlePlay)
					google.value = data.googlePlay;
				if (data && data.amazon)
					amazon.value = data.amazon;
				if (data && data.beatport)
					beatport.value = data.beatport;
				if (data == null)
					clear();
			}
		}
	}
}