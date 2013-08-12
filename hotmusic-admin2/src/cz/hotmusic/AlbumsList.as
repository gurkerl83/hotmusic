package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.model.Album;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.AlbumRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class AlbumsList extends Screen implements IActionButtons
	{
		public function AlbumsList()
		{
			super();
		}
		
		// ACTION BUTTONS
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("album")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = AlbumRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().albums);
			list.itemRendererProperties.labelFunction = function (album:Album):String {
				var albumName:String = "";
				var lng:int = 24;
				if (album && album.name.length > lng)
					albumName = String(album.name).substr(0, lng) + "...";
				else 
					albumName = album.name;
				return albumName;
			}
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