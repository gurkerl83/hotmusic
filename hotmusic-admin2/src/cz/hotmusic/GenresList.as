package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.GenreServiceEvent;
	import cz.hotmusic.lib.model.Genre;
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
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			// reload data
			list.dataProvider = new ListCollection(Model.getInstance().genres);
			pageJumper.totalItems = Model.getInstance().genresTotal;
			pageJumper.actualPage = 0;
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
		private var pageJumper:PageJumper;
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			list = new List();
			list.itemRendererType = GenreRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().genres);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:GenreServiceEvent = new GenreServiceEvent(GenreServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.sid;
				se.genre = Genre(GenreRenderer(event.target).data);
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			list.addEventListener(starling.events.Event.CHANGE, function onChange(event:Event):void {
				if (!skipOpenDetail && list.selectedIndex >= 0)
					dispatchEventWith("showDetail", false, List(event.target).selectedItem);
				skipOpenDetail = false;
				if (list.selectedIndex > -1)
					list.selectedIndex = -1;
			});
			
			pageJumper = new PageJumper();
			pageJumper.totalItems = Model.getInstance().genresTotal;
			pageJumper.addEventListener(PageJumper.PAGE_JUMP, function onPageJump(event:Event):void {
				DataHelper.getInstance().getGenres(function onGenres():void {
					list.dataProvider = new ListCollection(Model.getInstance().genres);
				}
					, false, event.data);
			});
			
			addChild(list);
			addChild(pageJumper);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getGenres(function onGenres():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().genres);
				pageJumper.actualPage = 0;
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
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
		
	}
}