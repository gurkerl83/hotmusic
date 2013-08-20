package cz.hotmusic.lib.model
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
		public var rateUp			:int;
		public var rateDown			:int;
		public var canVote			:Boolean;
		public var releaseDate		:Date;
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
		
		public var itunes			:String;
		public var googlePlay		:String;
		public var amazon			:String;
		public var beatport			:String;
		public var soundcloud		:String;
		public var youtube			:String;
		
		public function get hotstatus():int
		{
			if (!addedDate)
				return 0;
			var now:Date = new Date();
			var dif:Number = now.time - addedDate.time;
			var days:Number = dif/(60*60*24*1000);
			if (days < 2)
				return 3;
			if (days < 4)
				return 2;
			if (days < 6)
				return 1;
			return 0;
		}
	}
}