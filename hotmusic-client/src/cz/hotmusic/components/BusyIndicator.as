package cz.hotmusic.components
{
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	
	import starling.display.graphics.RoundedRectangle;
	import starling.display.materials.FlatColorMaterial;

	public class BusyIndicator extends FeathersControl
	{
		public function BusyIndicator()
		{
		}
		
		private static var _instance:BusyIndicator;
		public static function getInstance():BusyIndicator
		{
			if (_instance == null)
				_instance = new BusyIndicator();
			return _instance;
		}
		
		private var bg:RoundedRectangle;
		public var loading:Label;
		
		override protected function initialize():void
		{
			super.initialize();
			
			bg = new RoundedRectangle(150, 80);
			bg.material = new FlatColorMaterial(0x343434);
			bg.material.alpha = 0.9;
			
			loading = new Label();
			loading.text = "Loading...";
			
			addChild(bg);
			addChild(loading);
			
			setSize(bg.width, bg.height);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			loading.validate();
			loading.x = actualWidth/2 - loading.width/2;
			loading.y = actualHeight/2 - loading.height/2;
		}
	}
}