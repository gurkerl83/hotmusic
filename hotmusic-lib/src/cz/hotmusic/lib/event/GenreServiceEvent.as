package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;

	public class GenreServiceEvent extends ServiceEvent
	{
		public var genre:Genre;
		
		public static const CREATE			:String = "CREATE_GENRE";
		public static const LOGIN			:String = "LOGIN_GENRE";
		public static const LIST			:String = "LIST_GENRE";
		public static const LIST_COUNT		:String = "LIST_COUNT_GENRE";
		public static const UPDATE			:String = "UPDATE_GENRE";
		public static const REMOVE			:String = "REMOVE_GENRE";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_GENRE";
		
		public function GenreServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:GenreServiceEvent = new GenreServiceEvent(type, resultCallback, faultCallback);
			upe.genre = genre;
			upe.sid = sid;
			upe.sedata = sedata;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}