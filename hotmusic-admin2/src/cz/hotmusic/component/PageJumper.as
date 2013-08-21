package cz.hotmusic.component
{
	import cz.hotmusic.model.Model;
	
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	import feathers.themes.Theme;
	
	import starling.events.Event;
	
	public class PageJumper extends FeathersControl
	{
		public function PageJumper()
		{
			super();
		}
		
		public static const PAGE_JUMP:String = "PAGE_JUMP";
		
		private var _totalItems:int;

		public function get actualPage():int
		{
			return _actualPage;
		}

		public function set actualPage(value:int):void
		{
			_actualPage = value;
		}

		public function get totalItems():int
		{
			return _totalItems;
		}

		public function set totalItems(value:int):void
		{
			_totalItems = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		private var firstButton:Button;
		private var prevButton:Button;
		private var nextButton:Button;
		private var lastButton:Button;
		private var buttonsArr:Array;
		
		private var _actualPage:int;
		

		override protected function initialize():void {
			createButtons();
			
			firstButton = new Button();
			firstButton.label = "<<";
			firstButton.name = Theme.PAGE_BUTTON_DARK;
			firstButton.addEventListener(Event.TRIGGERED, function onFist(event:Event):void {
				event.stopImmediatePropagation();
				if (actualPage <= 0)
					return;
				actualPage = 0;
				var ge:Event = new Event(PAGE_JUMP, false, {page:actualPage,count:Model.ITEMS_ON_PAGE});
				dispatchEvent(ge);
				invalidate(INVALIDATION_FLAG_DATA);
			});
			
			prevButton = new Button();
			prevButton.label = "<";
			prevButton.name = Theme.PAGE_BUTTON_DARK;
			prevButton.addEventListener(Event.TRIGGERED, function onPrev(event:Event):void {
				event.stopImmediatePropagation();
				if (actualPage <= 0)
					return;
				actualPage--;
				var ge:Event = new Event(PAGE_JUMP, false, {page:actualPage, count:Model.ITEMS_ON_PAGE});
				dispatchEvent(ge);
				invalidate(INVALIDATION_FLAG_DATA);
			});
			
			nextButton = new Button();
			nextButton.label = ">";
			nextButton.name = Theme.PAGE_BUTTON_DARK;
			nextButton.addEventListener(Event.TRIGGERED, function onNext(event:Event):void {
				event.stopImmediatePropagation();
				if (actualPage >= lastPageNumber)
					return;
				actualPage++;
				var ge:Event = new Event(PAGE_JUMP, false, {page:actualPage, count:Model.ITEMS_ON_PAGE});
				dispatchEvent(ge);
				invalidate(INVALIDATION_FLAG_DATA);
			});
			
			lastButton = new Button();
			lastButton.label = ">>";
			lastButton.name = Theme.PAGE_BUTTON_DARK;
			lastButton.addEventListener(Event.TRIGGERED, function onLast(event:Event):void {
				event.stopImmediatePropagation();
				if (actualPage >= lastPageNumber)
					return;
				actualPage = lastPageNumber;
				var ge:Event = new Event(PAGE_JUMP, false, {page:actualPage,count:Model.ITEMS_ON_PAGE});
				dispatchEvent(ge);
				invalidate(INVALIDATION_FLAG_DATA);
			});
			
			addChild(firstButton);
			addChild(prevButton);
			addChild(nextButton);
			addChild(lastButton);
			
			for each (var b:Button in buttonsArr) {
				addChild(b);
			}
			
			super.initialize();
		}
		
		override protected function draw():void {
			super.draw();
			
			var gap:int = 5;
			
			firstButton.validate();
			prevButton.validate();
			nextButton.validate();
			lastButton.validate();
			
			prevButton.x = firstButton.x + firstButton.width + gap;
			
			var lastNumberButton:Button = prevButton;
			
//			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				updateButtons();
				for each (var pb:Button in buttonsArr) {
					if (!pb.visible)
						continue;
					pb.x = lastNumberButton.x + lastNumberButton.width + gap;
					lastNumberButton = pb;
					lastNumberButton.validate();
					trace("lastNumberButton ", lastNumberButton.width, lastNumberButton.x);
				}
//			}
			nextButton.x = lastNumberButton.x + lastNumberButton.width + gap;
			trace("nextButton ", nextButton.width, nextButton.x);
			
			lastButton.x = nextButton.x + nextButton.width + gap;
			trace("lastButton ", lastButton.width, lastButton.x);
			
			setSize(lastButton.x + lastButton.width, firstButton.height);
//			invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		private function get pagesCount():int {
			var i:int = totalItems / Model.ITEMS_ON_PAGE;
			if (totalItems%Model.ITEMS_ON_PAGE > 0)
				i++;
			if (i == 0)
				i++;
			return i;
		}
		
		private function get lastPageNumber():int {
			return pagesCount - 1;
		}
		
		private function updateButtons():void {
			var maxButtons:int = 10;
			
			var minNumber:int;
			var maxNumber:int;
			
			if (pagesCount <= maxButtons) { // zobrazit vsechny
				minNumber = 1;
				maxNumber = pagesCount;
			} else {
				if (actualPage%maxButtons == 0)
					minNumber = (actualPage/maxButtons-1)*maxButtons+1;
				else
					minNumber = actualPage/maxButtons*maxButtons+1;
				maxNumber = (pagesCount > (minNumber + maxButtons -1)) ? minNumber + maxButtons - 1:pagesCount;
			}
			
			var i:int = minNumber;
			for each (var btn:Button in buttonsArr) {
				if (i > maxNumber) {
					btn.visible = false;
					continue;
				}
				btn.visible = true;
				btn.label = i.toString();
				btn.isEnabled = actualPage != i-1 ? true:false;
//				btn.validate();
				btn.removeEventListeners(Event.TRIGGERED);
				btn.addEventListener(Event.TRIGGERED, function onTrigger(event:Event):void {
					actualPage = int(Button(event.target).label) - 1;
					event.stopImmediatePropagation();
					var ge:Event = new Event(PAGE_JUMP, false, {page:actualPage,count:Model.ITEMS_ON_PAGE});
					dispatchEvent(ge);
					invalidate(INVALIDATION_FLAG_DATA);
				});
				i++;
			}
		}
		
		private function createButtons():void {
			var count:int = 10;
			buttonsArr = [];
			for (var i:int=1; i <= count; i++) {
				var btn:Button = new Button();
				btn.visible = false;
				btn.name = Theme.PAGE_BUTTON_LIGHT;
				buttonsArr.push(btn);
			}
		}
	}
}