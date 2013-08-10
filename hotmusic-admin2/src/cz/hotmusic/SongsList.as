package cz.hotmusic
{
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.model.Song;
	import cz.hotmusic.renderer.SongRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class SongsList extends Screen implements IActionButtons
	{
		public function SongsList()
		{
			super();
		}
		
		// ACTION BUTTONS
		
		private var _actionButtons:Array;
		public function get actionButtons():Array
		{
			if (_actionButtons == null)
			{
				_actionButtons = [ButtonHelper.inst().addNewButton("song")];
			}
			return _actionButtons;
		}
		
		// INITIALIZE
		private var list:List;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = SongRenderer;
			list.dataProvider = new ListCollection(DataHelper.getInstance().songs);
			list.itemRendererProperties.labelFunction = function (song:Song):String {
				var songName:String = "";
				if (song && song.name.length > 24)
					songName = String(song.name).substr(0, 23) + "...";
				else 
					songName = song.name;
				return songName;
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