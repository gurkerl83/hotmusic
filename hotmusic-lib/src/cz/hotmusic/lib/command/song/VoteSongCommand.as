package cz.hotmusic.lib.command.song
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	import cz.hotmusic.lib.event.SongServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class VoteSongCommand implements ICommand, IResponder
	{
		public function VoteSongCommand()
		{
		}
		
		public var se:SongServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = SongServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.SONG_SERVICE);
			var call:AsyncToken = service.vote(se.sid, se.sedata);
			call.addResponder(this);
		}
		
		public function result(data:Object):void {
			if (se.resultCallback != null)
				se.resultCallback.call(this, data);
		}
		
		public function fault(info:Object):void {
			if (se.faultCallback != null)
				se.faultCallback.call(this, info);
		}
	}
}