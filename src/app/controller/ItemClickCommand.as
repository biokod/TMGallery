package app.controller 
{
	import app.model.BoxItem;
	import app.model.GalleryModel;

	import org.robotlegs.mvcs.Command;
	
	public class ItemClickCommand extends Command
	{
		public function ItemClickCommand() {

		}
		
		[Inject]
		public var item:BoxItem;
		
		[Inject]
		public var galleryModel:GalleryModel;

		override public function execute():void
		{
			galleryModel.clicked(item);
		}
	}
}