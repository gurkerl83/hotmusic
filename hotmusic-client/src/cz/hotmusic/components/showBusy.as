package cz.hotmusic.components
{
	import feathers.core.PopUpManager;

	public function showBusy():void
	{
		if (PopUpManager.isPopUp(BusyIndicator.getInstance()))
			return;
			
		PopUpManager.addPopUp(BusyIndicator.getInstance(), true);
	}
}