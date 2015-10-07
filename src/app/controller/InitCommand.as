package app.controller 
{
	import app.model.GalleryModel;
	import app.view.GalleryView;

	import flash.display.Sprite;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import org.robotlegs.mvcs.Command;

	public class InitCommand extends Command
	{
		public function InitCommand() { }

		[Inject]
		public var galleryModel:GalleryModel;

		private var urlLoader:URLLoader;
		private var galleryView:Sprite;

		override public function execute():void
		{
			galleryView = contextView.addChild(new GalleryView()) as Sprite;

			urlLoader = new URLLoader(new URLRequest("files.xml"));
			urlLoader.addEventListener("complete", xmlLoaded);

		}
		

		private function xmlLoaded(event:Event):void
		{
			var fileList:XML = new XML();
			fileList = XML(urlLoader.data);
			galleryModel.init(fileList, galleryView);

		}
		
		private function errorHandler(event:ErrorEvent):void
		{
			throw new Error("bad link or internet disconnect");
		}
	}
}