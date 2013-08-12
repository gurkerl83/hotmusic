package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.event.GenreServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.DataHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.model.Genre;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.GenreRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.ResultEvent;
	
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
			list.dataProvider = new ListCollection(Model.getInstance().genres);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.session;
				se.genre = Genre(GenreRenderer(event.target).data);
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			
			addChild(list);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getGenres(function onGenres():void {
				list.dataProvider = new ListCollection(Model.getInstance().genres);
				invalidate();
			});
		}
		
		private function removeFault(info:Object):void
		{
			
		}
		
		// DRAW
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
		}
		
	}
}