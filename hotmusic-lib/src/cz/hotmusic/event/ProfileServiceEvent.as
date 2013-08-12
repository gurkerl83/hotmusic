package cz.hotmusic.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.model.User;
	
	import flash.events.Event;

	public class ProfileServiceEvent extends CairngormEvent
	{
		public var user:User;
		public var sid:String;
		public var autocomplete:String;
		public var response:Object;
		public var resultCallback:Function;
		public var faultCallback:Function;
		
		public static const REGISTER		:String = "REGISTER_USER";
		public static const LOGIN			:String = "LOGIN_USER";
		public static const LIST			:String = "LIST_USER";
		public static const LIST_COUNT		:String = "LIST_COUNT_USER";
		public static const UPDATE			:String = "UPDATE_USER";
		public static const REMOVE			:String = "REMOVE_USER";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_USER";
		
		public function ProfileServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
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
			upe.autocomplete = autocomplete;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}