package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Autocomplete;
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class SongDetail extends Screen implements IActionButtons, IActions
	{
		public function SongDetail()
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
		
		private var _songData:Song;
		public function get songData():Song
		{
			return _songData;
		}
		public function set songData(value:Song):void
		{
			_songData = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		private var songname:FormItem;
		private var artistname:FormItem;
		private var albumname:FormItem;
		private var genre:FormItem;
		private var releasedate:FormItem;
		private var itunes:FormItem;
		private var google:FormItem;
		private var amazon:FormItem;
		private var beatport:FormItem;
		private var soundcloud:FormItem;
		private var youtube:FormItem;
		private var autocomplete:Autocomplete;
		
		public function save():void
		{
			if (!songname.value || !artistname.selectedItem || !genre.selectedItem )
				return;
			
			var song:Song = new Song();
			song.name = songname.value;
			song.artist = Artist(artistname.selectedItem);
			song.album = Album(albumname.selectedItem);
			song.genre = Genre(genre.selectedItem);
//			song.releaseDate = releasedate.
			song.itunes = itunes.value;
			song.googlePlay = google.value;
			song.amazon = amazon.value;
			song.beatport = beatport.value;
			song.soundcloud = soundcloud.value;
			song.youtube = youtube.value;
			
			var se:SongServiceEvent = new SongServiceEvent(songData == null ? SongServiceEvent.CREATE:SongServiceEvent.UPDATE, createResult, createFault);
			if (songData != null) // modify song
				song.id = songData.id;
			se.song = song;
			se.sid = Model.getInstance().user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		private function createResult(result:Object):void
		{
			DataHelper.getInstance().addEventListener(DataHelper.SONGS_COMPLETE, function sch(event:flash.events.Event):void {
				removeEventListener(DataHelper.SONGS_COMPLETE, sch);
				dispatchEventWith(starling.events.Event.CLOSE);
			});
			DataHelper.getInstance().getSongs();
		}
		
		private function createFault(info:Object):void
		{
			trace("got error");
		}
		
		public function clear():void
		{
			songname.value = "";
			albumname.value = "";
			genre.value = "";
			releasedate.value = "";
			itunes.value = "";
			google.value = "";
			amazon.value = "";
			beatport.value = "";
			soundcloud.value = "";
			youtube.value = "";
		}
		
		public function remove():void
		{
			
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			songname = new FormItem();
			songname.orderNumber = "1.";
			songname.label = "Song name";
			
//			songname.value = "The Adventure Of Rain Dancce Maggie";
			
			var ase:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.AUTOCOMPLETE, null, null);
			ase.sid = Model.getInstance().user.session;
			artistname = new FormItem();
			artistname.orderNumber = "2.";
			artistname.label = "Artist name";
			artistname.isAutocomplete = true;
			artistname.serviceEvent = ase;
			
			var alse:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.AUTOCOMPLETE, null, null);
			alse.sid = Model.getInstance().user.session;
			albumname = new FormItem();
			albumname.orderNumber = "3.";
			albumname.label = "Album name";
			albumname.isAutocomplete = true;
			albumname.serviceEvent = alse;
			
			var gse:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.AUTOCOMPLETE, null, null);
			gse.sid = Model.getInstance().user.session;
			genre = new FormItem();
			genre.orderNumber = "4.";
			genre.label = "Genre";
			genre.isAutocomplete = true;
			genre.serviceEvent = gse;
			
			releasedate = new FormItem();
			releasedate.orderNumber = "5.";
			releasedate.label = "Release date";
			
			itunes = new FormItem();
			itunes.orderNumber = "6.";
			itunes.label = "iTunes link to buy";
			
			google = new FormItem();
			google.orderNumber = "7.";
			google.label = "Google Play link to buy";
			
			amazon = new FormItem();
			amazon.orderNumber = "8.";
			amazon.label = "Amazon link to buy";
			
			beatport = new FormItem();
			beatport.orderNumber = "9.";
			beatport.label = "Beatport link to buy";
			
			soundcloud = new FormItem();
			soundcloud.orderNumber = "10.";
			soundcloud.label = "Soundcloud listen link";
			
			youtube = new FormItem();
			youtube.orderNumber = "11.";
			youtube.label = "YouTube watch link";
			
			// jsou pridany v opacnem poradi kvuli zobrazeni autocomplete listu "na vrchu"
			addChild(youtube);
			addChild(soundcloud);
			addChild(beatport);
			addChild(amazon);
			addChild(google);
			addChild(itunes);
			addChild(releasedate);
			addChild(genre);
			addChild(albumname);
			addChild(artistname);
			addChild(songname);

			// protoze jsou pridany childy v opacnem poradi, je treba rucne nastavit focus order
			songname.nextTabFocus = artistname.autocomplete.textinput;
			artistname.nextTabFocus = albumname.autocomplete.textinput;
			albumname.nextTabFocus = genre.autocomplete.textinput;
			genre.nextTabFocus = releasedate.textinput;
			releasedate.nextTabFocus = itunes.textinput;
			itunes.nextTabFocus = google.textinput;
			google.nextTabFocus = amazon.textinput;
			amazon.nextTabFocus = beatport.textinput;
			beatport.nextTabFocus = soundcloud.textinput;
			soundcloud.nextTabFocus = youtube.textinput;
			youtube.nextTabFocus = songname.textinput;

			songname.previousTabFocus = youtube.textinput;
			artistname.previousTabFocus = songname.textinput;
			albumname.previousTabFocus = artistname.autocomplete.textinput;
			genre.previousTabFocus = albumname.autocomplete.textinput;
			releasedate.previousTabFocus = genre.autocomplete.textinput;
			itunes.previousTabFocus = releasedate.textinput;
			google.previousTabFocus = itunes.textinput;
			amazon.previousTabFocus = google.textinput;
			beatport.previousTabFocus = amazon.textinput;
			soundcloud.previousTabFocus = beatport.textinput;
			youtube.previousTabFocus = soundcloud.textinput;
			
			songname.textinput.focusManager.focus = songname.textinput;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var padding:int = 0;
			var formgap:int = 4;
			var gap:int = 20;
			
			songname.x = padding;
			songname.y = padding;
			songname.width = actualWidth - 2*padding;
			
			artistname.x = padding;
			artistname.y = songname.y + songname.height + formgap;
			artistname.width = actualWidth - 2*padding;
			
			albumname.x = padding;
			albumname.y = artistname.y + artistname.height + formgap;
			albumname.width = actualWidth - 2*padding;
			
			genre.x = padding;
			genre.y = albumname.y + albumname.height + formgap;
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
			
			soundcloud.x = padding;
			soundcloud.y = beatport.y + beatport.height + gap;
			soundcloud.width = actualWidth - 2*padding;
			
			youtube.x = padding;
			youtube.y = soundcloud.y + soundcloud.height + gap;
			youtube.width = actualWidth - 2*padding;
			
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				if (songData && songData.name)
					songname.value = songData.name;
				if (songData && songData.artist)
					artistname.selectedItem = songData.artist;
				if (songData && songData.album)
					albumname.selectedItem = songData.album;
				if (songData && songData.genre)
					genre.selectedItem = songData.genre;
//				if (songData && songData.releaseDate)
//					releasedate.selectedItem = songData.releaseDate;
				if (songData && songData.itunes)
					itunes.value = songData.itunes;
				if (songData && songData.googlePlay)
					google.value = songData.googlePlay;
				if (songData && songData.amazon)
					amazon.value = songData.amazon;
				if (songData && songData.beatport)
					beatport.value = songData.beatport;
				if (songData && songData.soundcloud)
					soundcloud.value = songData.soundcloud;
				if (songData && songData.youtube)
					youtube.value = songData.youtube;
				
			}
		}
	}
}