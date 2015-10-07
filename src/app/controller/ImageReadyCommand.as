package app.controller 
{
	import app.model.BoxItem;
	import app.model.GalleryModel;
	import app.signals.ImageReady;

	import org.robotlegs.mvcs.SignalCommand;

	public class ImageReadyCommand extends SignalCommand
	{
		public function ImageReadyCommand() { }

		[Inject]
		public var item:BoxItem;

		[Inject]
		public var galleryModel:GalleryModel;

		override public function execute():void
		{
			galleryModel.nextItemReady();
		}
		
	}
}