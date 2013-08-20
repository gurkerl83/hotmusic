package cz.hotmusic.lib.model
{
	public class Vote
	{
		public function Vote()
		{
		}
		
		public var id:String;
		public var objectUUID:String;
		public var addedDate:Date;
		public var rate:int;
		public var song:Song;
		public var user:User;
		
	}
}