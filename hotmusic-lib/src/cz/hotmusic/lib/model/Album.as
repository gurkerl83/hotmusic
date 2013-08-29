package cz.hotmusic.lib.model
{
	import mx.collections.ArrayCollection;

	public class Album
	{
		public function Album(name:String=null)
		{
			this.name = name;
		}
		
		public var id:String;
		public var objectUUID:String;
		public var name:String;
		public var artist:Artist;
		public var genre:Genre;
		public var releaseDate:Date;
		public var itunes:String;
		public var googlePlay:String;
		public var amazon:String;
		public var beatport:String;
		public var songs:ArrayCollection;
		
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
	}
}