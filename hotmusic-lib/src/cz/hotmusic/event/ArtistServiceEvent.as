package cz.hotmusic.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.model.Artist;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.User;
	
	import flash.events.Event;

	public class ArtistServiceEvent extends CairngormEvent
	{
		public var artist:Artist;
		public var sid:String;
		public var autocomplete:String;
		public var response:Object;
		public var resultCallback:Function;
		public var faultCallback:Function;
		
		public static const CREATE			:String = "CREATE_ARTIST";
		public static const LOGIN			:String = "LOGIN_ARTIST";
		public static const LIST			:String = "LIST_ARTIST";
		public static const LIST_COUNT		:String = "LIST_COUNT_ARTIST";
		public static const UPDATE			:String = "UPDATE_ARTIST";
		public static const REMOVE			:String = "REMOVE_ARTIST";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_ARTIST";
		
		public function ArtistServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:ArtistServiceEvent = new ArtistServiceEvent(type, resultCallback, faultCallback);
			upe.artist = artist;
			upe.sid = sid;
			upe.autocomplete = autocomplete;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}