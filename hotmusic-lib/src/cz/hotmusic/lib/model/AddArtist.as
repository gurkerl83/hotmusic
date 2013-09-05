package cz.hotmusic.lib.model
{
	public class AddArtist
	{
		public function AddArtist(name:String=null, date:Date=null)
		{
			if (name != null)
				this.name = name;
			if (date != null)
				this.addedDate = date;
		}
		
		public static const WAITING_STATE:String = "WAITING_STATE";
		public static const ADDED_STATE:String = "ADDED_STATE";
		public static const REJECTED_STATE:String = "REJECTED_STATE";
		
		public var id:String;
		public var objectUUID:String;
		public var name:String;
		public var state:String;
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
	}
}