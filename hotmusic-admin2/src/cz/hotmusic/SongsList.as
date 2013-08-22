package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.component.Alert;
	import cz.hotmusic.component.PageJumper;
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.helper.ErrorHelper;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.SongRenderer;
	import cz.zc.mylib.event.GenericEvent;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class SongsList extends Screen implements IActionButtons
	{
		public function SongsList()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			// reload data
			list.dataProvider = new ListCollection(Model.getInstance().songs);
			pageJumper.totalItems = Model.getInstance().songsTotal;
			pageJumper.actualPage = 0;
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
		private var lastMonthLbl:Label;
		private var lastMonthVal:Label;
		private var totalLbl:Label;
		private var totalVal:Label;
		private var pageJumper:PageJumper;
		
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			lastMonthLbl = new Label();
			lastMonthLbl.text = "Last month added songs:";
			lastMonthLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			lastMonthVal = new Label();
			lastMonthVal.text = Model.getInstance().songsLastMonth.toString();
			lastMonthVal.name = Theme.LARGE_BOLD_WHITE;
			
			totalLbl = new Label();
			totalLbl.text = "Total added songs:";
			totalLbl.name = Theme.SMALL_NORMAL_ORANGE;
			
			totalVal = new Label();
			totalVal.text = Model.getInstance().songsTotal.toString();
			totalVal.name = Theme.LARGE_BOLD_WHITE;
			
			list = new List();
			list.itemRendererType = SongRenderer;
			list.dataProvider = new ListCollection(Model.getInstance().songs);
			list.itemRendererProperties.labelFunction = function (song:Song):String {
				var songName:String = "";
				if (song && song.name.length > 24)
					songName = String(song.name).substr(0, 23) + "...";
				else 
					songName = song.name;
				return songName;
			}
			list.hasElasticEdges = false;
			list.addEventListener("delete", function onDelete(event:Event):void {
				skipOpenDetail = true;
				var se:SongServiceEvent = new SongServiceEvent(SongServiceEvent.REMOVE, removeResult, removeFault);
				se.sid = Model.getInstance().user.sid;
				se.song = Song(SongRenderer(event.target).data);
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
			pageJumper.totalItems = Model.getInstance().songsTotal;
			pageJumper.addEventListener(PageJumper.PAGE_JUMP, function onPageJump(event:Event):void {
				DataHelper.getInstance().getSongs(function onSongs():void {
					list.dataProvider = new ListCollection(Model.getInstance().songs);
				}, function onSongsFault(info:FaultEvent):void {
					Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
				}
				, false, event.data);
			});
			
			addChild(lastMonthLbl);
			addChild(lastMonthVal);
			addChild(totalLbl);
			addChild(totalVal);
			addChild(list);
			addChild(pageJumper);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getSongs(function onData():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().songs);
				pageJumper.actualPage = 0;
				invalidate();
			},  function onSongsFault(info:FaultEvent):void {
				Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
			});
		}
		
		private function removeFault(info:Object):void
		{
			Alert.show(ErrorHelper.getInstance().getMessage(info.fault.faultString), Alert.ERROR);
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
			
			pageJumper.validate();
			pageJumper.y = actualHeight - pageJumper.height;
		}
	}
}