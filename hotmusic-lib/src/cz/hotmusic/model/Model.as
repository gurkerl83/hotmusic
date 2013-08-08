package cz.hotmusic.model
{
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