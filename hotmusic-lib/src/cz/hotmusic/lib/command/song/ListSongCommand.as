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
	
	public class ListSongCommand implements ICommand, IResponder
	{
		public function ListSongCommand()
		{
		}
		
		public var se:SongServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = SongServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.SONG_SERVICE);
			var call:AsyncToken;
			if (se.sedata != null) {
				var page:int = se.sedata.page;
				var search:String = se.sedata.search;
				var sort:String = se.sedata.sort;
				call = service.list(se.sid, page, search, sort);
			} else {
				call = service.list(se.sid);
			}
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