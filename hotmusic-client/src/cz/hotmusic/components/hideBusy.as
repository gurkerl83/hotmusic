package cz.hotmusic.components
{
	import feathers.core.PopUpManager;

	public function hideBusy(data:Object=null):void
	{
		if (!PopUpManager.isPopUp(BusyIndicator.getInstance()))
			return;
		
		PopUpManager.removePopUp(BusyIndicator.getInstance());
	}
}