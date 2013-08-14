package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;

	public class ArtistServiceEvent extends ServiceEvent
	{
		public var artist:Artist;
		
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