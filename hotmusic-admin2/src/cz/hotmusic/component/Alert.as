package cz.hotmusic.component
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.Theme;
	
	import org.osmf.layout.HorizontalAlign;
	import org.osmf.layout.VerticalAlign;
	
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
		private static var panelButton:Panel;
		private static var okButton:Button;
		private static var label:Label;
		private static var yesButton:Button;
		private static var noButton:Button;
		
		public static function show(msg:String, title:String, yesHandler:Function=null):void {
			if (panel == null)
				initPanel();
			
			if (yesHandler == null)
				showOkButton();
			else
				showYesNoButtons(yesHandler);
				
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
			
			panelButton = new Panel();
			var hl:HorizontalLayout = new HorizontalLayout();
			hl.gap = 20;
			hl.padding = 20;
			hl.verticalAlign = VerticalAlign.MIDDLE;
			panelButton.layout = hl;
			panelButton.customHeaderName = Theme.HEADER_HIDE;
			
			panel.addChild(panelButton);
			
			okButton = new Button();
			okButton.label = "Ok";
			okButton.addEventListener(Event.TRIGGERED, function onTrigger(e:Event):void {
				Alert.hide();
			});

			yesButton = new Button();
			yesButton.label = "Yes";
			
			noButton = new Button();
			noButton.label = "No";
			noButton.addEventListener(Event.TRIGGERED, function onTrigger(e:Event):void {
				Alert.hide();
			});
		}
		
		private static function showOkButton():void 
		{
			// remove buttons
			if (panelButton.getChildIndex(yesButton) >= 0)
				panelButton.removeChild(yesButton);
			if (panelButton.getChildIndex(noButton) >= 0)
				panelButton.addChild(noButton);
			
			// add button
			if (panelButton.getChildIndex(okButton) == -1)
				panelButton.addChild(okButton);
		}
		
		private static function showYesNoButtons(yesHandler:Function):void 
		{
			if (panelButton.getChildIndex(okButton) >= 0)
				panelButton.removeChild(okButton);
			
			if (yesButton.hasEventListener(Event.TRIGGERED))
				yesButton.removeEventListeners(Event.TRIGGERED);
			yesButton.addEventListener(Event.TRIGGERED, function onTrigger(e:Event):void {
				yesHandler.call();
				Alert.hide();
			});
			
			if (panelButton.getChildIndex(yesButton) == -1) {
				panelButton.addChild(yesButton);
				panelButton.addChild(noButton);
			}
		}
	}
}