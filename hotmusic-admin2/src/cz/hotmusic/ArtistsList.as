package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.renderer.ArtistRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ArtistsList extends Screen implements IActionButtons
	{
		public function ArtistsList()
		{
			super();
		}
		
		// ACTION BUTTONS
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("artist")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = ArtistRenderer;
			list.dataProvider = new ListCollection(DataHelper.getInstance().artists);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			
			addChild(list);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
		}
		
	}
}