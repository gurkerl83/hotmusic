package cz.hotmusic.model
{
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;

	public class Model
	{
		public function Model()
		{
		}
		
		private static var _instance:Model;
		public static function getInstance():Model
		{
			if (_instance == null) {
				_instance = new Model();
				_instance.resetModel();
			}
			return _instance;
		}
		
		public var selectedSong:Song;
		public var user:User;
		
		public var songs:Array;
		public var artists:Array;
		public var albums:Array;
		public var genres:Array;
		public var users:Array;
		
		private function resetModel():void
		{
			user = new User();
			user.version = 0;
			songs = [];
			artists = [];
			albums = [];
			genres = [];
			users = [];
			selectedSong = new Song();
			selectedSong.album = new Album();
			selectedSong.artist = new Artist();
			selectedSong.genre = new Genre();
		}
	}
}