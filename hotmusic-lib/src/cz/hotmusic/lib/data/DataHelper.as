package cz.hotmusic.lib.data
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.lib.event.AddArtistServiceEvent;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.AddArtist;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;
	import mx.rpc.events.ResultEvent;

	public class DataHelper extends EventDispatcher
	{
		public function DataHelper()
		{
		}
		
		private static var _instance:DataHelper;
		private var model:Object;
		public static function getInstance():DataHelper 
		{
			if (_instance == null) {
				_instance = new DataHelper();
			}
			return _instance;
		}
		
		public function initModel(cb:Function, cbf:Function, model:Object, skipCounts:Boolean=false):void
		{
			this.model = model;
//			_songsComplete = _artistsComplete = _albumsComplete = _genresComplete = _usersComplete = false;
			getSongs(cb, cbf, skipCounts, null);
			getArtists(cb, cbf, skipCounts, null);
			getAlbums(cb, cbf, skipCounts, null);
			getGenres(cb, cbf, skipCounts, null);
			getUsers(cb, cbf, skipCounts, null);
			if (model.hasOwnProperty("addArtistsTotal"))
				getAddArtists(cb, cbf, skipCounts, null);
		}
		
		private var _songsComplete:Boolean;
		private var _songsTotalComplete:Boolean;
		private var _songsLastMonthComplete:Boolean;
		private var _artistsComplete:Boolean;
		private var _artistsTotalComplete:Boolean;
		private var _artistsLastMonthComplete:Boolean;
		private var _albumsComplete:Boolean;
		private var _albumsTotalComplete:Boolean;
		private var _albumsLastMonthComplete:Boolean;
		private var _genresComplete:Boolean;
		private var _genresTotalComplete:Boolean;
		private var _usersComplete:Boolean;
		private var _usersTotalComplete:Boolean;
		private var _addArtistsComplete:Boolean;
		private var _addArtistsTotalComplete:Boolean;
		
		public static const INIT_COMPLETE		:String = "INIT_COMPLETE";
		public static const SONGS_COMPLETE		:String = "SONGS_COMPLETE";
		public static const ARTISTS_COMPLETE	:String = "ARTISTS_COMPLETE";
		public static const ALBUMS_COMPLETE		:String = "ALBUMS_COMPLETE";
		public static const GENRES_COMPLETE		:String = "GENRES_COMPLETE";
		public static const USERS_COMPLETE		:String = "USERS_COMPLETE";
		public static const ADDARTISTS_COMPLETE		:String = "ADDARTISTS_COMPLETE";
		
		private function dispatchInitComplete():void
		{
			if (_songsComplete && _songsTotalComplete && _songsLastMonthComplete && 
				_albumsComplete && _albumsLastMonthComplete && _albumsTotalComplete && 
				_artistsComplete && _artistsLastMonthComplete && _artistsTotalComplete && 
				_genresComplete && _genresTotalComplete && 
				_usersComplete && _usersTotalComplete &&
				_artistsComplete && _artistsTotalComplete )
				dispatchEvent(new Event(INIT_COMPLETE));
		}
		
		private function dispatchSongsComplete():void
		{
			if (_songsComplete && _songsTotalComplete && _songsLastMonthComplete)
				dispatchEvent(new Event(SONGS_COMPLETE));
		}
		
		private function dispatchAlbumsComplete():void
		{
			if (_albumsComplete && _albumsLastMonthComplete && _albumsTotalComplete)
				dispatchEvent(new Event(ALBUMS_COMPLETE));
		}
		
		private function dispatchArtistsComplete():void
		{
			if (_artistsComplete && _artistsLastMonthComplete && _artistsTotalComplete)
				dispatchEvent(new Event(ARTISTS_COMPLETE));
		}
		
		private function dispatchGenresComplete():void
		{
			if (_genresComplete && _genresTotalComplete)
				dispatchEvent(new Event(GENRES_COMPLETE));
		}
		
		private function dispatchUsersComplete():void
		{
			if (_usersComplete && _usersTotalComplete)
				dispatchEvent(new Event(USERS_COMPLETE));
		}
		private function dispatchAddArtistsComplete():void
		{
			if (_addArtistsComplete && _addArtistsTotalComplete)
				dispatchEvent(new Event(ADDARTISTS_COMPLETE));
		}
		
		//-------------------------------
		//
		// SONGS
		//
		//-------------------------------
		
		private var songsCallback:Function;
		private var songsCallbackFault:Function;
		public function getSongs(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false,paging:Object=null):void
		{
			_songsComplete = _songsTotalComplete = _songsLastMonthComplete = false;
			
			songsCallback = null;
			songsCallbackFault = null;
			if (callback != null)
				songsCallback = callback;
			if (callbackFault != null)
				songsCallbackFault = callbackFault;
			
			// List
			var sse:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST,songResult,songFault);
			sse.sid = model.user.sid;
			if (paging != null)
				sse.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(sse);
			sse = null;
			
//			if (skipCounts) {
//				_songsLastMonthComplete = true;
//				_songsTotalComplete = true;
//				return;
//			}
			
			// Total
			var ssecount:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("songsTotal"))
						model.songsTotal = result.result;
					_songsTotalComplete = true;
					dispatchSongsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (songsCallbackFault != null) {
					songsCallbackFault.call(this, info);
					songsCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);

			// Last month
			var sselastmonth:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("songsLastMonth"))
						model.songsLastMonth = result.result;
					_songsLastMonthComplete = true;
					dispatchSongsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(sselastmonth);
		}
		
		private function songResult(result:ResultEvent):void
		{
			var songs:Array = model.songs;
			songs.splice(0, songs.length);
			for each (var song:Song in result.result)
			{
				songs.push(song);
			}
			
			_songsComplete = true;
			dispatchSongsComplete();
			dispatchInitComplete();
			
			if (songsCallback != null)
				songsCallback.call();
		}
		private function songFault(info:Object):void
		{
			if (songsCallbackFault != null) {
				songsCallbackFault.call(this, info);
				songsCallbackFault = null; // not call others fault callbacks
			}
		}

		//-------------------------------
		//
		// ARTISTS
		//
		//-------------------------------
		
		private var artistsCallback:Function;
		private var artistsCallbackFault:Function;
		public function getArtists(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false, paging:Object=null):void
		{
			_artistsComplete = _artistsTotalComplete = _artistsLastMonthComplete = false;
			
			artistsCallback = null;
			artistsCallbackFault = null;
			if (callback != null)
				artistsCallback = callback;
			if (callbackFault != null)
				artistsCallbackFault = callbackFault;
			
			var se:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST,artistResult,artistFault);
			se.sid = model.user.sid;
			if (paging != null)
				se.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
//			if (skipCounts) {
//				_artistsLastMonthComplete = true;
//				_artistsTotalComplete = true;
//				return;
//			}
			
			// Total
			var ssecount:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("artistsTotal"))
						model.artistsTotal = result.result;
					_artistsTotalComplete = true;
					dispatchArtistsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (artistsCallbackFault != null) {
					artistsCallbackFault.call(this, info);
					artistsCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
			
			// Last month
			var sselastmonth:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("artistsLastMonth"))
						model.artistsLastMonth = result.result;
					_artistsLastMonthComplete = true;
					dispatchArtistsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(sselastmonth);
			
		}
		
		private function artistResult(result:ResultEvent):void
		{
			var artists:Array = model.artists;
			artists.splice(0, artists.length);
			for each (var artist:Artist in result.result)
			{
				artists.push(artist);
			}
			dispatchEvent(new Event(ARTISTS_COMPLETE));
			_artistsComplete = true;
			dispatchInitComplete();
			if (artistsCallback != null)
				artistsCallback.call();
		}
		
		private function artistFault(info:Object):void
		{
			if (artistsCallbackFault != null) {
				artistsCallbackFault.call(this, info);
				artistsCallbackFault = null; // not call others fault callbacks
			}
		}

		//-------------------------------
		//
		// ALBUM
		//
		//-------------------------------
		
		private var albumsCallback:Function;
		private var albumsCallbackFault:Function;
		public function getAlbums(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false, paging:Object=null):void
		{
			_albumsComplete = _albumsTotalComplete = _albumsLastMonthComplete = false;
			
			albumsCallback = null;
			albumsCallbackFault = null;
			if (callback != null)
				albumsCallback = callback;
			if (callbackFault != null)
				albumsCallbackFault = callbackFault;
			
			var se:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST,albumResult,albumFault);
			se.sid = model.user.sid;
			if (paging != null)
				se.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
//			if (skipCounts) {
//				_albumsLastMonthComplete = true;
//				_albumsTotalComplete = true;
//				return;
//			}
			
			// Total
			var ssecount:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("albumsTotal"))
						model.albumsTotal = result.result;
					_albumsTotalComplete = true;
					dispatchAlbumsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (albumsCallbackFault != null) {
					albumsCallbackFault.call(this, info);
					albumsCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
			
			// Last month
			var sselastmonth:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("albumsLastMonth"))
						model.albumsLastMonth = result.result;
					_albumsLastMonthComplete = true;
					dispatchAlbumsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(sselastmonth);
		}
		
		private function albumResult(result:ResultEvent):void
		{
			var albums:Array = model.albums;
			albums.splice(0, albums.length);
			for each (var album:Album in result.result)
			{
				albums.push(album);
			}
			dispatchEvent(new Event(ALBUMS_COMPLETE));
			_albumsComplete = true;
			dispatchInitComplete();
			if (albumsCallback != null)
				albumsCallback.call();
		}
		
		private function albumFault(info:Object):void
		{
			if (albumsCallbackFault != null) {
				albumsCallbackFault.call(this, info);
				albumsCallbackFault = null; // not call others fault callbacks
			}
		}

		//-------------------------------
		//
		// GENRE
		//
		//-------------------------------
		
		private var genresCallback:Function;
		private var genresCallbackFault:Function;
		public function getGenres(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false, paging:Object=null):void
		{
			_genresComplete = _genresTotalComplete = false;
			
			genresCallback = null;
			genresCallbackFault = null;
			if (callback != null)
				genresCallback = callback;
			if (callbackFault != null)
				genresCallbackFault = callbackFault;
			
			var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.LIST,genreResult,genreFault);
			se.sid = model.user.sid;
			if (paging != null)
				se.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
//			if (skipCounts) {
//				_genresTotalComplete = true;
//				return;
//			}
			
			// Total
			var ssecount:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("genresTotal"))
						model.genresTotal = result.result;
					_genresTotalComplete = true;
					dispatchGenresComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (genresCallbackFault != null) {
					genresCallbackFault.call(this, info);
					genresCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
		}
		
		private function genreResult(result:ResultEvent):void
		{
			var genres:Array = model.genres;
			genres.splice(0, genres.length);
			for each (var genre:Genre in result.result)
			{
				genres.push(genre);
			}
			dispatchEvent(new Event(GENRES_COMPLETE));
			_genresComplete = true;
			dispatchInitComplete();
			if (genresCallback != null)
				genresCallback.call();
		}
		
		private function genreFault(info:Object):void
		{
			if (genresCallbackFault != null) {
				genresCallbackFault.call(this, info);
				genresCallbackFault = null; // not call others fault callbacks
			}
		}

		//-------------------------------
		//
		// USERS
		//
		//-------------------------------
		
		private var usersCallback:Function;
		private var usersCallbackFault:Function;
		public function getUsers(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false, paging:Object=null):void
		{
			_usersComplete = _usersTotalComplete = false;
			
			usersCallback = null;
			usersCallbackFault = null;
			if (callback != null)
				usersCallback = callback;
			if (callbackFault != null)
				usersCallbackFault = callbackFault;
			
			var se:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LIST,userResult,userFault);
			se.sid = model.user.sid;
			if (paging != null)
				se.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
//			if (skipCounts) {
//				_usersTotalComplete = true;
//				return;
//			}
			
			// Total
			var ssecount:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is Number) {
					if (model.hasOwnProperty("usersTotal"))
						model.usersTotal = result.result;
					_usersTotalComplete = true;
					dispatchUsersComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (usersCallbackFault != null) {
					usersCallbackFault.call(this, info);
					usersCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
		}
		
		private function userResult(result:ResultEvent):void
		{
			var users:Array = model.users;
			users.splice(0, users.length);
			for each (var user:User in result.result)
			{
				users.push(user);
			}
			dispatchEvent(new Event(USERS_COMPLETE));
			_usersComplete = true;
			dispatchInitComplete();
			if (usersCallback != null)
				usersCallback.call();
		}
		
		private function userFault(info:Object):void
		{
			if (usersCallbackFault != null) {
				usersCallbackFault.call(this, info);
				usersCallbackFault = null; // not call others fault callbacks
			}
		}
		
		//-------------------------------
		//
		// ADD ARTISTS
		//
		//-------------------------------
		
		private var addArtistsCallback:Function;
		private var addArtistsCallbackFault:Function;
		public function getAddArtists(callback:Function=null, callbackFault:Function=null, skipCounts:Boolean=false, paging:Object=null):void
		{
			_addArtistsComplete = _addArtistsTotalComplete = false;
			
			addArtistsCallback = null;
			addArtistsCallbackFault = null;
			if (callback != null)
				addArtistsCallback = callback;
			if (callbackFault != null)
				addArtistsCallbackFault = callbackFault;
			
			var se:AddArtistServiceEvent = new AddArtistServiceEvent(AddArtistServiceEvent.LIST,addArtistResult,addArtistFault);
			se.sid = model.user.sid;
			if (paging != null)
				se.data = paging;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
			//			if (skipCounts) {
			//				_addArtistsLastMonthComplete = true;
			//				_addArtistsTotalComplete = true;
			//				return;
			//			}
			
			// Total
			var ssecount:AddArtistServiceEvent = new AddArtistServiceEvent(AddArtistServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result is ArrayCollection) {
					if (model.hasOwnProperty("addArtistsTotal")) {
						var resArr:Array = result.result;
						model.addArtistsTotal = resArr[0]; 
						model.addArtistsWaiting = resArr[1]; 
						model.addArtistsAdded = resArr[2]; 
						model.addArtistsRejected = resArr[3]; 
					}
					_addArtistsTotalComplete = true;
					dispatchAddArtistsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				if (addArtistsCallbackFault != null) {
					addArtistsCallbackFault.call(this, info);
					addArtistsCallbackFault = null; // not call others fault callbacks
				}
			});
			ssecount.sid = model.user.sid;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
			
			
		}
		
		private function addArtistResult(result:ResultEvent):void
		{
			var addArtists:Array = model.addArtists;
			addArtists.splice(0, addArtists.length);
			for each (var addArtist:AddArtist in result.result)
			{
				addArtists.push(addArtist);
			}
			dispatchEvent(new Event(ADDARTISTS_COMPLETE));
			_addArtistsComplete = true;
			dispatchInitComplete();
			if (addArtistsCallback != null)
				addArtistsCallback.call();
		}
		
		private function addArtistFault(info:Object):void
		{
			if (addArtistsCallbackFault != null) {
				addArtistsCallbackFault.call(this, info);
				addArtistsCallbackFault = null; // not call others fault callbacks
			}
		}

		
		public function getData(type:String, cb:Function=null, cbf:Function=null):void
		{
			if (type == "Songs")
				getSongs(cb, cbf);
			else if (type == "Artists")
				getArtists(cb, cbf);
			else if (type == "Albums")
				getAlbums(cb, cbf);
			else if (type == "Genres")
				getGenres(cb, cbf);
			else if (type == "Users")
				getUsers(cb, cbf);
			else if (type == "+Artists")
				getAddArtists(cb, cbf);
		}
		
		public static function al2a(al:Object):Array 
		{
			var a:Array = [];
			for each (var i:Object in al) {
				a.push(i);
			}
			return a;
		}
	}
}