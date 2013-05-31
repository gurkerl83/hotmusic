package cz.hotmusic.model
{
	public class Song
	{
		public function Song()
		{
		}
		
		public var name		:String;
		public var artist	:Artist;
		public var album	:Album;
		public var genre	:Genre;
		public var hotstatus:int;
		public var rateUp	:int;
		public var rateDown	:int;
		public var added	:String;
		
		public var itunesURL:String;
		public var googleURL:String;
		public var amazonURL:String;
		public var beatport:String;
		public var soundcloudURL:String;
		public var youtubeURL:String;
	}
}