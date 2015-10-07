package app.controller 
{
	import app.model.BoxItem;
	import app.model.GalleryModel;
	import app.signals.ImageReady;

	import org.robotlegs.mvcs.SignalCommand;

	public class ImageLoadedCommand extends SignalCommand
	{
		public function ImageLoadedCommand() { }

		[Inject]
		public var item:BoxItem;

		[Inject]
		public var galleryModel:GalleryModel;

		override public function execute():void
		{
			//trace(item.index + " url:" + item.imageURL);
			galleryModel.nextItemReady();
		}
		
	}
}