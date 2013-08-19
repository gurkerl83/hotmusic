package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.lib.event.ArtistServiceEvent;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.model.Artist;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.ArtistRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.ResultEvent;
	
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
		private var lastMonthLbl:Label;
		private var lastMonthVal:Label;
		private var totalLbl:Label;
		private var totalVal:Label;
		
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			lastMonthLbl = new Label();
			lastMonthLbl.text = "Last month added artists:";
			lastMonthLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			lastMonthVal = new Label();
			lastMonthVal.text = Model.getInstance().albumsLastMonth.toString();
			lastMonthVal.name = Theme.LARGE_BOLD_WHITE;
			
			totalLbl = new Label();
			totalLbl.text = "Total added artists:";
			totalLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			totalVal = new Label();
			totalVal.text = Model.getInstance().albumsTotal.toString();
			totalVal.name = Theme.LARGE_BOLD_WHITE;
			
			list = new List();
			list.itemRendererType = ArtistRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().artists);
			list.itemRendererProperties.labelField = "name";
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:ArtistServiceEvent = new ArtistServiceEvent(ArtistServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.session;
				se.artist = Artist(ArtistRenderer(event.target).data);
				CairngormEventDispatcher.getInstance().dispatchEvent(se);
			});
			list.addEventListener(starling.events.Event.CHANGE, function onChange(event:Event):void {
				if (!skipOpenDetail && list.selectedIndex >= 0)
					dispatchEventWith("showDetail", false, List(event.target).selectedItem);
				skipOpenDetail = false;
				if (list.selectedIndex > -1)
					list.selectedIndex = -1;
			});
			
			addChild(lastMonthLbl);
			addChild(lastMonthVal);
			addChild(totalLbl);
			addChild(totalVal);
			addChild(list);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getArtists(function onArtists():void {
				list.dataProvider = new ListCollection(Model.getInstance().artists);
				invalidate();
			});
		}
		
		private function removeFault(info:Object):void
		{
			
		}
		
		override protected function draw():void
		{
			super.draw();
			
			var gap:int = 20;
			var baseline:int = 4;
			
			lastMonthLbl.validate();
			
			lastMonthVal.x = lastMonthLbl.width;
			lastMonthVal.validate();
			lastMonthVal.y = baseline - lastMonthVal.height + lastMonthLbl.height;
			
			totalLbl.x = lastMonthVal.x + lastMonthVal.width + gap;
			totalLbl.validate();
			
			totalVal.x = totalLbl.x + totalLbl.width;
			totalVal.validate();
			totalVal.y = baseline - totalVal.height + totalLbl.height;
			
			list.y = totalLbl.y + totalLbl.height + gap;
			list.width = actualWidth;
		}
		
	}
}