package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.renderer.GenreRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GenresList extends Screen implements IActionButtons
	{
		public function GenresList()
		{
			super();
		}

		// ACTION BUTTONS
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("genre")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = GenreRenderer;
			list.dataProvider = new ListCollection(DataHelper.getInstance().genres);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			
			addChild(list);
		}
		
		// DRAW
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
		}
		
	}
}