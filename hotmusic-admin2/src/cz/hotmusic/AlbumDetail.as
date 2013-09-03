package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.FormItem;
	import cz.hotmusic.component.SongFormComponent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	import cz.zc.mylib.helper.ArrayHelper;
	import cz.zc.mylib.helper.DateHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.events.FeathersEventType;
	import feathers.themes.Theme;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AlbumDetail extends Screen implements IActionButtons, IActions
	{
		public function AlbumDetail()
		{
			super();
			addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(event:starling.events.Event):void {
			// clean songsToDelete
			initSongsTo();
			
			addEventListener(SongFormComponent.SONG_DELETE_EVENT, onSongDelete);
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
			clear();
		}
		
		public function save():void
		{
			if (!isValid())
				return;
			
			var album:Album = prepareAlbumForSave();
			
			var se:AlbumServiceEvent = new AlbumServiceEvent(data == null ? AlbumServiceEvent.CREATE:AlbumServiceEvent.UPDATE, createResult, Alert.showError);
			
			se.album = album;
			se.sid = Model.getInstance().user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
		}
		
		private function isValid():Boolean 
		{
			albumname.hideValidator();
			artistname.hideValidator()
			genre.hideValidator()
			releasedate.hideValidator()
			
			var valid:Boolean = true;
				
			if (!albumname.value) {
				albumname.showValidator();
				valid = false;
			}
			if (!artistname.selectedItem && !artistname.value && artistname.value.length <= 0 ) {
				artistname.showValidator();
				valid = false;
			}
			if (!genre.selectedItem && !genre.value && genre.value.length <= 0) {
				genre.showValidator();
				valid = false;
			}
			if (DateHelper.parsePHPDate(releasedate.value) == null ) {
				releasedate.showValidator();
				valid = false;
			}
			
			return valid;
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
		
		private var sc:ScrollContainer;
		private var albumname:FormItem;
		private var artistname:FormItem;
		private var genre:FormItem;
		private var releasedate:FormItem;
		private var itunes:FormItem;
		private var google:FormItem;
		private var amazon:FormItem;
		private var beatport:FormItem;
		private var songsLbl:Label;
		private var addSongBtn:Button;
		
		private var sfcList:Array; // store all SongFormComponent objects
		private var sfcDict:Dictionary; // store all SongFormComponent objects
		
		override protected function initialize():void
		{
			super.initialize();
			
			sc = new ScrollContainer();
			sc.scrollerProperties.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
			
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
			
			songsLbl = new Label();
			songsLbl.text = "Album songs";
			songsLbl.name = Theme.SMALL_BOLD_WHITE;
			
			addSongBtn = new Button();
			addSongBtn.label = "Add song";
			addSongBtn.name = Theme.SMALL_BOLD_BLUE;
			addSongBtn.addEventListener(starling.events.Event.TRIGGERED, function onClick(event:starling.events.Event):void {
				songsToAdd.push(new Song());
				invalidate();
			});
			
			
			sc.addChild(beatport);
			sc.addChild(amazon);
			sc.addChild(google);
			sc.addChild(itunes);
			sc.addChild(releasedate);
			sc.addChild(genre);
			sc.addChild(artistname);
			sc.addChild(albumname);
			
			sc.addChild(songsLbl);
			sc.addChild(addSongBtn);
			
			addChild(sc);
			
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
			var prevDO:DisplayObject;
			
			sc.width = actualWidth;
			sc.height = actualHeight;
			
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
			
			songsLbl.x = padding;
			songsLbl.y = beatport.y +  beatport.height + formgap;
			
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
				
				if (data && data.songs) {
//					while (sfcList && sfcList.length > 0) {
//						var sfc:SongFormComponent = sfcList.pop();
//						sfc.removeEventListener(FeathersEventType.RESIZE, onSFCResize);
//						removeChild(sfc);
//					}
					
					// vsechny sfc z displaylistu vymaz
					for (var j:int = (sc.numChildren-1); j>0; j--)
					{
						if (!(sc.getChildAt(j) is SongFormComponent))
							continue;
						
						sc.removeChild(sc.getChildAt(j));
					}
					
					prevDO = songsLbl;
					var i:int = 1;
					if (sfcList == null)
						sfcList = [];
					if (sfcDict == null)
						sfcDict = new Dictionary();
					sfcList.splice(0, sfcList.length);
					
					// priprav si aktualni list s sfc
					for each (var s:Song in getSongs()) {
						var sfc:SongFormComponent;
						sfc = sfcDict[s];
						
						// pokud nebyl v dictionary nalezen, vytvor a uloz do dict
						if (sfc == null) {
							sfc = new SongFormComponent();
							sc.addChild(sfc);
							sfc.addEventListener(FeathersEventType.RESIZE, onSFCResize);
							sfc.song = s;
							sfc.orderNumber = ""+i+".";
							sfc.x = padding;
							sfc.y = prevDO.y + prevDO.height + formgap;
							sfc.width = actualWidth - 2*padding;
							sfcDict[s] = sfc; 
						} else {
							sc.addChild(sfc);
						}
						
						// pridej ho do listu
						sfcList.push(sfc);
						prevDO = sfc;
						i++;
					}
					
					trace("sfcList.length: "+sfcList.length);
				}
				
				if (data == null)
					clear();
			}
			
			if (isInvalid(INVALIDATION_FLAG_SIZE)) {
				prevDO = songsLbl;
				
				for each (var doItem:DisplayObject in sfcList) {
					doItem.y = prevDO.y + prevDO.height + formgap;
					prevDO = doItem;
				}
				
				addSongBtn.x = padding;
				addSongBtn.y = prevDO.y + prevDO.height + gap;
			}
		}
		
		private function onSFCResize(event:starling.events.Event):void 
		{
			trace("onSFCResize");
			invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		private var songsToDelete:Array;
		private var songsToAdd:Array;
		
		private function onSongDelete(event:starling.events.Event):void 
		{
			event.stopImmediatePropagation();
			var song:Song = Song(event.data);
			// pokud odstranuju persistentni, tak pridam do pole
			// ktere se zpracuje pri ukladani
			if (song && song.id != null && song.id.length > 0) {
				songsToDelete.push(song);
				
			// pokud odstranuju nepersistentni, pak ho musim vymazat
			// z pole songsToAdd
			} else {
				ArrayHelper.removeObject(song, songsToAdd);
			}
			invalidate();
		}
		
		private function initSongsTo():void {
			if (songsToDelete == null)
				songsToDelete = [];
			if (songsToAdd == null)
				songsToAdd = [];
			songsToDelete.splice(0, songsToDelete.length);
			songsToAdd.splice(0, songsToAdd.length);
		}
		
		/**
		 * Tato funkce vraci aktualni seznam songu, tj. jsou to songy, ktere puvodne v albu byly
		 * od nich jsou odebrane ty, ktere byly v prubehu vymazane a k nim pridane nove
		 */
		private function getSongs():Array {
			var ar:Array = songsToAdd.concat();
			
			for each (var s:Song in data.songs) {
				var isOk:Boolean = true;
				for each (var sd:Song in songsToDelete) {
					if (s == sd) {
						isOk = false;
						break;
					}
				}
				if (isOk)
					ar.push(s);
			}
			return ar;
		}
		
		/**
		 * Pripravi album pro zaslani na server, predevsim vybere songy a nastavi jim
		 * pozadovane parametry jako vazbu na album, linky, artist.
		 */
		private function prepareAlbumForSave():Album {
			commpitSongsProperties();
			var songs:Array = getSongs();
			var album:Album = new Album();
			
			album.name = albumname.value;
			album.artist = artistname.selectedItem != null ? Artist(artistname.selectedItem):new Artist(artistname.value);
			album.genre = genre.selectedItem != null ? Genre(genre.selectedItem):new Genre(genre.value);
			album.releaseDate = DateHelper.parsePHPDate(releasedate.value);
			album.itunes = itunes.value;
			album.googlePlay = google.value;
			album.amazon = amazon.value;
			album.beatport = beatport.value;
			if (data != null) // modify
				album.id = data.id;
			
			if (album.songs == null)
				album.songs = new ArrayCollection();
			
			for each (var s:Song in songs) {
				if (!(s.id != null && s.id.length > 0)) {
					s.album = album;
					s.itunes = album.itunes;
					s.googlePlay = album.googlePlay;
					s.amazon = album.amazon;
					s.beatport = album.beatport;
					s.artist = album.artist;
				}
				
				album.songs.addItem(s);
			}
			
			return album;
		}
		
		private function commpitSongsProperties():void {
			for each (var sfc:SongFormComponent in sfcList) {
				sfc.commitSongProperties();
			}
		}
	}
}