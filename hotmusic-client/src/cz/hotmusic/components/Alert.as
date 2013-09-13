package cz.hotmusic.components
{
	import cz.hotmusic.lib.helper.ErrorHelper;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import mx.rpc.events.FaultEvent;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.events.Event;

	public class Alert
	{
		public function Alert()
		{
			
		}
		
		public static const ERROR:String = "Error";
		public static const INFO:String = "Info";
		public static const WARN:String = "Warning";
		
		private static var panel:Panel;
		private static var okButton:Button;
		private static var label:Label;
		
		public static function showError(error:Object):void 
		{
			hideBusy();
			var msg:String;
			if (error is FaultEvent) {
				msg = FaultEvent(error).fault.faultString;
			} else if (error is String) {
				msg = String(error);
			} else {
				throw new Error("Unknown error object");
			}
			
			//			if (msg && msg.length > 200)
			//				msg = msg.substr(0, 200);
			
			show(ErrorHelper.getInstance().getMessage(msg), ERROR);
		}
		
		public static function show(msg:String, title:String):void {
			hideBusy();
			if (panel == null)
				initPanel();
			
			panel.headerProperties.title = title;
			label.text = msg;
			
			PopUpManager.addPopUp(panel);
		}
		
		public static function hide():void {
			PopUpManager.removePopUp(panel);
		}
		
		private static function initPanel():void {
			panel = new Panel();
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 20;
			layout.padding = 20;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			panel.layout = layout;
			
			label = new Label();
			panel.addChild( label );
			
			okButton = new Button();
			okButton.label = "Ok";
			okButton.addEventListener(Event.TRIGGERED, function onTrigger(e:Event):void {
				Alert.hide();
			});
			panel.addChild( okButton );

		}
	}
}