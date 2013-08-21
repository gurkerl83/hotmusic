package cz.hotmusic.model
{
	import cz.hotmusic.lib.model.User;

	public class Model
	{
		public function Model()
		{
		}

		public static const ITEMS_ON_PAGE:int = 10; // je treba nastavit i v listCount ve vsech sluzbach stejne
		
		private static var _instance:Model;
		
		public static function getInstance():Model
		{
			if (_instance == null) {
				_instance = new Model();
				_instance.resetModel();	
			}
			return _instance;
		}
		
		public var user:User;
		
		public var songs:Array;
		public var artists:Array;
		public var albums:Array;
		public var genres:Array;
		public var users:Array;
		
		public var songsLastMonth:int;
		public var songsTotal:int;
		public var albumsLastMonth:int;
		public var albumsTotal:int;
		public var artistsLastMonth:int;
		public var artistsTotal:int;
		public var genresTotal:int;
		public var usersTotal:int;
		
		public function resetModel():void
		{
			user = new User();
			songs = [];
			artists = [];
			albums = [];
			genres = [];
			users = [];
		}
	}
}