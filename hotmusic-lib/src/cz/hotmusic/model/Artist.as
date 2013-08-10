package cz.hotmusic.model
{
	public class Artist
	{
		public function Artist(name:String=null, date:Date=null)
		{
			if (name != null)
				this.name = name;
			if (date != null)
				this.addedDate = date;
		}
		
		public var id:String;
		public var name:String;
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
	}
}