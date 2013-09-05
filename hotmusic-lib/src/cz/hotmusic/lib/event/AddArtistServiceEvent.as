package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.model.AddArtist;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.lib.model.Genre;
	import cz.hotmusic.lib.model.User;
	
	import flash.events.Event;

	public class AddArtistServiceEvent extends ServiceEvent
	{
		public var addArtist:AddArtist;
		
		public static const CREATE			:String = "CREATE_ADDARTIST";
		public static const LIST			:String = "LIST_ADDARTIST";
		public static const LIST_COUNT		:String = "LIST_COUNT_ADDARTIST";
		public static const LIST_LAST_MONTH	:String = "LIST_LAST_MONTH_ADDARTIST";
		public static const UPDATE			:String = "UPDATE_ADDARTIST";
		public static const REMOVE			:String = "REMOVE_ADDARTIST";
		public static const AUTOCOMPLETE	:String = "AUTOCOMPLETE_ADDARTIST";
		public static const CHANGE_STATE	:String = "CHANGE_STATE_ADDARTIST";
		
		public function AddArtistServiceEvent(type:String, resultCallback:Function, faultCallback:Function)
		{
			super(type);
			this.resultCallback = resultCallback;
			this.faultCallback = faultCallback;
		}
		
		override public function clone():Event
		{
			var upe:AddArtistServiceEvent = new AddArtistServiceEvent(type, resultCallback, faultCallback);
			upe.addArtist = addArtist;
			upe.sid = sid;
			upe.sedata = sedata;
			upe.resultCallback = resultCallback;
			upe.faultCallback = faultCallback;
			upe.response = response;
			return upe;
		}
	}
}