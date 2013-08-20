package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.model.Album;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;

	public class SongServiceEvent extends ServiceEvent
	{
		public var song:Song;
		
		public static const CREATE			:String = "CREATE_SONG";
		public static const LOGIN			:String = "LOGIN_SONG";
		public static const LIST			:String = "LIST_SONG";
		public static const LIST_COUNT		:String = "LIST_COUNT_SONG";
		public static const LIST_LAST_MONTH	:String = "LIST_LAST_MONTH_SONG";
		public static const UPDATE			:String = "UPDATE_SONG";
		public static const REMOVE			:String = "REMOVE_SONG";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_SONG";
		public static const VOTE			:String = "VOTE_SONG";
		
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
			upe.sedata = sedata;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}