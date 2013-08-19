package cz.hotmusic.lib.data
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
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
		
		public function initModel(model:Object):void
		{
			this.model = model;
//			_songsComplete = _artistsComplete = _albumsComplete = _genresComplete = _usersComplete = false;
			getSongs();
			getArtists();
			getAlbums();
			getGenres();
			getUsers();
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
		private var _usersComplete:Boolean;
		
		public static const INIT_COMPLETE		:String = "INIT_COMPLETE";
		public static const SONGS_COMPLETE		:String = "SONGS_COMPLETE";
		public static const ARTISTS_COMPLETE	:String = "ARTISTS_COMPLETE";
		public static const ALBUMS_COMPLETE		:String = "ALBUMS_COMPLETE";
		public static const GENRES_COMPLETE		:String = "GENRES_COMPLETE";
		public static const USERS_COMPLETE		:String = "USERS_COMPLETE";
		
		private function dispatchInitComplete():void
		{
			if (_songsComplete && _songsTotalComplete && _songsLastMonthComplete && 
				_albumsComplete && _albumsLastMonthComplete && _albumsTotalComplete && 
				_artistsComplete && _artistsLastMonthComplete && _artistsTotalComplete && 
				_genresComplete && _usersComplete)
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
		
		//-------------------------------
		//
		// SONGS
		//
		//-------------------------------
		
		private var songsCallback:Function;
		public function getSongs(callback:Function=null):void
		{
			_songsComplete = _songsTotalComplete = _songsLastMonthComplete = false;
			
			songsCallback = null;
			if (callback != null)
				songsCallback = callback;
			
			// List
			var sse:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST,songResult,songFault);
			sse.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(sse);
			sse = null;
			
			// Total
			var ssecount:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result) {
					model.songsTotal = result.result;
					_songsTotalComplete = true;
					dispatchSongsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			ssecount.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);

			// Last month
			var sselastmonth:SongServiceEvent = new SongServiceEvent(SongServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result) {
					model.songsLastMonth = result.result;
					_songsLastMonthComplete = true;
					dispatchSongsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.session;
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
			
		}

		//-------------------------------
		//
		// ARTISTS
		//
		//-------------------------------
		
		private var artistsCallback:Function;
		public function getArtists(callback:Function=null):void
		{
			_artistsComplete = _artistsTotalComplete = _artistsLastMonthComplete = false;
			
			artistsCallback = null;
			if (callback != null)
				artistsCallback = callback;
			var se:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST,artistResult,artistFault);
			se.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
			// Total
			var ssecount:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result) {
					model.artistsTotal = result.result;
					_artistsTotalComplete = true;
					dispatchArtistsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			ssecount.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
			
			// Last month
			var sselastmonth:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result) {
					model.artistsLastMonth = result.result;
					_artistsLastMonthComplete = true;
					dispatchArtistsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.session;
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
			
		}

		//-------------------------------
		//
		// ALBUM
		//
		//-------------------------------
		
		private var albumsCallback:Function;
		public function getAlbums(callback:Function=null):void
		{
			_albumsComplete = _albumsTotalComplete = _albumsLastMonthComplete = false;
			
			albumsCallback = null;
			if (callback != null)
				albumsCallback = callback;
			var se:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST,albumResult,albumFault);
			se.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
			
			// Total
			var ssecount:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST_COUNT,function listCount(result:ResultEvent):void {
				if (result && result.result) {
					model.albumsTotal = result.result;
					_albumsTotalComplete = true;
					dispatchAlbumsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			ssecount.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(ssecount);
			
			// Last month
			var sselastmonth:AlbumServiceEvent = new AlbumServiceEvent(AlbumServiceEvent.LIST_LAST_MONTH,function listLastMonth(result:ResultEvent):void {
				if (result && result.result) {
					model.albumsLastMonth = result.result;
					_albumsLastMonthComplete = true;
					dispatchAlbumsComplete();
					dispatchInitComplete();
				}
			},function listCountFault(info:Object):void {
				
			});
			sselastmonth.sid = model.user.session;
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
			
		}

		//-------------------------------
		//
		// GENRE
		//
		//-------------------------------
		
		private var genresCallback:Function;
		public function getGenres(callback:Function=null):void
		{
			genresCallback = null;
			if (callback != null)
				genresCallback = callback;
			var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.LIST,genreResult,genreFault);
			se.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
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
			
		}

		//-------------------------------
		//
		// USERS
		//
		//-------------------------------
		
		private var usersCallback:Function;
		public function getUsers(callback:Function=null):void
		{
			usersCallback = null;
			if (callback != null)
				usersCallback = callback;
			var se:ProfileServiceEvent = new ProfileServiceEvent(ProfileServiceEvent.LIST,userResult,userFault);
			se.sid = model.user.session;
			CairngormEventDispatcher.getInstance().dispatchEvent(se);
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
			
		}
		
		public function getData(type:String, cb:Function=null):void
		{
			if (type == "Songs")
				getSongs(cb);
			else if (type == "Artists")
				getArtists(cb);
			else if (type == "Albums")
				getAlbums(cb);
			else if (type == "Genres")
				getGenres(cb);
			else if (type == "Users")
				getUsers(cb);
			else if (type == "+Artists")
				getArtists(cb);
		}
	}
}