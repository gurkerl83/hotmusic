package cz.hotmusic.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.User;
	
	import flash.events.Event;

	public class AlbumServiceEvent extends CairngormEvent
	{
		public var album:Album;
		public var sid:String;
		public var autocomplete:String;
		public var response:Object;
		public var resultCallback:Function;
		public var faultCallback:Function;
		
		public static const CREATE			:String = "CREATE_ALBUM";
		public static const LOGIN			:String = "LOGIN_ALBUM";
		public static const LIST			:String = "LIST_ALBUM";
		public static const LIST_COUNT		:String = "LIST_COUNT_ALBUM";
		public static const UPDATE			:String = "UPDATE_ALBUM";
		public static const REMOVE			:String = "REMOVE_ALBUM";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_ALBUM";
		
		public function AlbumServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:AlbumServiceEvent = new AlbumServiceEvent(type, resultCallback, faultCallback);
			upe.album = album;
			upe.sid = sid;
			upe.autocomplete = autocomplete;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}