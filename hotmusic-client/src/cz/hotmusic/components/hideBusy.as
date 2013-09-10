package cz.hotmusic.components
{
	import feathers.core.PopUpManager;

	public function hideBusy():void
	{
		if (!PopUpManager.isPopUp(BusyIndicator.getInstance()))
			return;
		
		PopUpManager.removePopUp(BusyIndicator.getInstance());
	}
}