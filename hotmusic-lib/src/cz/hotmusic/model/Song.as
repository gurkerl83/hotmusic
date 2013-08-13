package cz.hotmusic.model
{
	public class Song
	{
		public function Song()
		{
		}
		
		public var id:String;
		public var objectUUID:String;
		public var name				:String;
		public var artist			:Artist;
		public var album			:Album;
		public var genre			:Genre;
		public var hotstatus		:int;
		public var rateUp			:int;
		public var rateDown			:int;
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
		
		public var itunes			:String;
		public var googlePlay		:String;
		public var amazon			:String;
		public var beatport			:String;
		public var soundcloud		:String;
		public var youtube			:String;
	}
}