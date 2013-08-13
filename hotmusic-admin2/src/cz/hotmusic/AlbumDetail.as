package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.event.AlbumServiceEvent;
	import cz.hotmusic.event.ArtistServiceEvent;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
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
		
		public function save():void
		{
			if (!albumname.value || !artistname.selectedItem || !genre.selectedItem )
				return;
			
			var album:Album = new Album();
			album.name = albumname.value;
			album.artist = Artist(artistname.selectedItem);
			album.genre = Genre(genre.selectedItem);
			album.itunes = itunes.value;
			album.googlePlay = google.value;
			album.amazon = amazon.value;
			album.beatport = beatport.value;
			
			var se:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.CREATE, createResult, createFault);
			se.album = album;
			se.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.ALBUMS_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.ALBUMS_COMPLETE, sch);
				dispatchEventWith(starling.events.Event.CLOSE);
			});
			DataHelper.getInstance().getAlbums();
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		public function clear():void
		{
			albumname.value = "";
			artistname.value = "";
			genre.value = "";
			releasedate.value = "";
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
			ase.sid = Model.getInstance().user.session;
			artistname = new FormItem();
			artistname.orderNumber = "2.";
			artistname.label = "Artist name";
			artistname.isAutocomplete = true;
			artistname.serviceEvent = ase;
			
			var gse:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.AUTOCOMPLETE, null, null);
			gse.sid = Model.getInstance().user.session;
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
			
			albumname.nextTabFocus = artistname;
			artistname.nextTabFocus = genre;
			genre.nextTabFocus = releasedate;
			releasedate.nextTabFocus = itunes;
			itunes.nextTabFocus = google;
			google.nextTabFocus = amazon;
			amazon.nextTabFocus = beatport;
			beatport.nextTabFocus = albumname;
			
			albumname.previousTabFocus = beatport;
			artistname.previousTabFocus = albumname;
			genre.previousTabFocus = artistname;
			releasedate.previousTabFocus = genre;
			itunes.previousTabFocus = releasedate;
			google.previousTabFocus = itunes;
			amazon.previousTabFocus = google;
			beatport.previousTabFocus = amazon;
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
		}
	}
}