package cz.hotmusic.command.song
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.controller.MyServiceLocator;
	import cz.hotmusic.event.AlbumServiceEvent;
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.event.ProfileServiceEvent;
	import cz.hotmusic.event.SongServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class AutocompleteSongCommand implements ICommand, IResponder
	{
		public function AutocompleteSongCommand()
		{
		}
		
		public var se:SongServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = SongServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.SONG_SERVICE);
			var call:AsyncToken = service.autocomplete(se.sid, se.autocomplete);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			se.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			se.faultCallback.call(this, info);
		}
	}
}