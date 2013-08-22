package cz.hotmusic.component
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
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
		
		public static function show(msg:String, title:String):void {
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