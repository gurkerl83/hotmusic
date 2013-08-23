package cz.hotmusic.lib.model
{
	public class User
	{
		public function User(firstname:String=null, surname:String=null)
		{
			if (firstname != null)
				this.firstname = firstname;
			if (surname != null)
				this.surname = surname;
		}
		
		public var id:String;
		public var objectUUID:String;
		public var nick:String;
		public var email:String;
		public var firstname:String;
		public var surname:String;
		public var version:int;
		public var male:Boolean;
		public var password:String;
		public var facebookId:String;
		public var sessionAdmin:String;
		public var sessionMobile:String;
		public var lastSession:String;
		public var adminRights:Boolean;
		public var genresAuthorized:Boolean;
		public var usersAuthorized:Boolean;
		public var addArtistAuthorized:Boolean;
		
		public var addedDate		:Date;
		public var addedByUser		:User;
		public var addedBySession	:String;
		
		public function get sid():String {
			if (sessionAdmin && sessionAdmin.length > 0)
				return sessionAdmin;
			if (sessionMobile && sessionMobile.length > 0)
				return sessionMobile;
			return null;
		}
	}
}