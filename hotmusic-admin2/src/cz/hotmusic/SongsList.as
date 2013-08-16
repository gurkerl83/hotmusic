package cz.hotmusic
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import cz.hotmusic.helper.ButtonHelper;
	import cz.hotmusic.helper.MockDataHelper;
	import cz.hotmusic.lib.data.DataHelper;
	import cz.hotmusic.lib.event.SongServiceEvent;
	import cz.hotmusic.lib.model.Song;
	import cz.hotmusic.model.Model;
	import cz.hotmusic.renderer.SongRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.themes.Theme;
	
	import mx.rpc.events.ResultEvent;
	
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
		private var skipOpenDetail:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
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
				se.sid = Model.getInstance().user.session;
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
			
			addChild(list);
		}
		
		private function removeResult(result:ResultEvent):void
		{
			DataHelper.getInstance().getSongs(function onData():void {
				list.selectedIndex = -1;
				list.dataProvider = new ListCollection(Model.getInstance().songs);
				invalidate();
			});
		}
		
		private function removeFault(info:Object):void
		{
			
		}
		
		override protected function draw():void
		{
			super.draw();
			
			list.width = actualWidth;
		}
	}
}