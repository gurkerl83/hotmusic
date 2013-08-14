package cz.hotmusic.model
{
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;

	public class Model
	{
		public function Model()
		{
		}
		
		private static var _instance:Model;
		public static function getInstance():Model
		{
			if (_instance == null)
				_instance = new Model();
			return _instance;
		}
		
		public var selectedSong:Song;
		
		public function resetModel():void
		{
			selectedSong = new Song();
			selectedSong.album = new Album();
			selectedSong.artist = new Artist();
			selectedSong.genre = new Genre();
		}
	}
}