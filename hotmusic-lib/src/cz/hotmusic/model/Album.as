package cz.hotmusic.model
{
	public class Album
	{
		public function Album(name:String=null, artist:Artist=null, date:Date=null)
		{
			if (name != null)
				this.name = name;
			if (artist != null)
				this.artist = artist;
			if (date != null)
				this.addedDate = date;
					
		}
		
		public var id:String;
		public var objectUUID:String;
		public var name:String;
		public var artist:Artist;
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
	}
}