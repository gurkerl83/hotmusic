package cz.hotmusic.lib.command.album
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import cz.hotmusic.lib.controller.MyServiceLocator;
	import cz.hotmusic.lib.event.AlbumServiceEvent;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.event.ProfileServiceEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class ListLastMonthAlbumCommand implements ICommand, IResponder
	{
		public function ListLastMonthAlbumCommand()
		{
		}
		
		public var se:AlbumServiceEvent;
		
		public function execute(event:CairngormEvent):void
		{
			se = AlbumServiceEvent(event);
			var service:RemoteObject = MyServiceLocator.getInstance().getService(MyServiceLocator.ALBUM_SERVICE);
			var call:AsyncToken = service.listLastMonth(se.sid);
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