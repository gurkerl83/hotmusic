package cz.hotmusic.event
{
	import flash.events.Event;

	public class GenericEvent extends Event
	{
		public var data:*;
		public function GenericEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new GenericEvent(type, bubbles, cancelable);
		}
	}
}