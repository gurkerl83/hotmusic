package cz.hotmusic.lib.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ServiceEvent extends CairngormEvent
	{
		
		public var sid:String;
		public var sedata:Object;
		public var response:Object;
		public var resultCallback:Function;
		public var faultCallback:Function;
		
		public function ServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}