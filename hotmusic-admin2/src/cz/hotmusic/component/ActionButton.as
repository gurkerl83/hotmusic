package cz.hotmusic.component
{
	import feathers.controls.Button;
	
	import starling.events.Event;
	
	public class ActionButton extends Button
	{
		public static const SAVE_BUTTON		:String = "SAVE_BUTTON";
		public static const CANCEL_BUTTON	:String = "CANCEL_BUTTON";
		public static const CLEAR_BUTTON	:String = "CLEAR_BUTTON";
		public static const ADD_NEW_BUTTON	:String = "ADD_NEW_BUTTON";
		
		private var buttonType:String;
		
		public function ActionButton(buttonType:String)
		{
			super();
			this.buttonType = buttonType;
			addEventListener(Event.TRIGGERED, actionButtonTriggeredHandler);
		}
		
		private function actionButtonTriggeredHandler(event:Event):void
		{
			if (focusManager)
				focusManager.focus = null;
			event.stopImmediatePropagation();
			dispatchEventWith(buttonType, true);
		}
	}
}