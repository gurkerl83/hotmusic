package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;

	public class ProfileServiceEvent extends ServiceEvent
	{
		public var user:User;
		
		public static const REGISTER		:String = "REGISTER_USER";
		public static const LOGIN			:String = "LOGIN_USER";
		public static const LIST			:String = "LIST_USER";
		public static const LIST_COUNT		:String = "LIST_COUNT_USER";
		public static const UPDATE			:String = "UPDATE_USER";
		public static const REMOVE			:String = "REMOVE_USER";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_USER";
		public static const FEEDBACK		:String = "FEEDBACK_USER";
		public static const RESET_PASSWORD	:String = "RESET_PASSWORD_USER";
		
		// login types
		public static const MOBILE_TYPE		:String = "MOBILE_TYPE";
		public static const ADMIN_TYPE		:String = "ADMIN_TYPE";
		
		public function ProfileServiceEvent(type:String, resultCallback:Function=null, faultCallback:Function=null)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:ProfileServiceEvent = new ProfileServiceEvent(type, resultCallback, faultCallback);
			upe.user = user;
			upe.sid = sid;
			upe.sedata = sedata;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}