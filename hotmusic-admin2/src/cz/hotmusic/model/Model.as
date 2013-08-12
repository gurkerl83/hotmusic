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