package cz.hotmusic.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.model.User;
	
	import flash.events.Event;

	public class SongServiceEvent extends CairngormEvent
	{
		public var song:Song;
		public var sid:String;
		public var autocomplete:String;
		public var response:Object;
		public var resultCallback:Function;
		public var faultCallback:Function;
		
		public static const CREATE			:String = "CREATE_SONG";
		public static const LOGIN			:String = "LOGIN_SONG";
		public static const LIST			:String = "LIST_SONG";
		public static const LIST_COUNT		:String = "LIST_COUNT_SONG";
		public static const UPDATE			:String = "UPDATE_SONG";
		public static const REMOVE			:String = "REMOVE_SONG";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_SONG";
		
		public function SongServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:SongServiceEvent = new SongServiceEvent(type, resultCallback, faultCallback);
			upe.song = song;
			upe.sid = sid;
			upe.autocomplete = autocomplete;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}