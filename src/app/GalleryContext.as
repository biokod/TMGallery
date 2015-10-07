package app  
{
	import app.controller.ImageReadyCommand;
	import app.controller.InitCommand;
	import app.controller.ItemAddedCommand;
	import app.controller.ItemClickCommand;
	import app.model.BoxItem;
	import app.model.GalleryModel;
	import app.model.IBox;
	import app.service.IFactory;
	import app.service.ImageFactory;
	import app.signals.ImageReady;
	import app.signals.ItemAdded;
	import app.signals.ItemClicked;
	import app.view.GalleryMediator;
	import app.view.GalleryView;
	import app.view.ImageMediator;
	import app.view.ImageView;

	import flash.display.DisplayObjectContainer;

	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.SignalContext;

	public class GalleryContext extends SignalContext
	{
		public function GalleryContext(contextView:DisplayObjectContainer) 
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitCommand, ContextEvent, true);

			signalCommandMap.mapSignalClass(ItemClicked, ItemClickCommand);
			signalCommandMap.mapSignalClass(ItemAdded, ItemAddedCommand);
			signalCommandMap.mapSignalClass(ImageReady, ImageReadyCommand);

			injector.mapSingleton(GalleryModel);
			injector.mapSingletonOf(IFactory, ImageFactory);
			injector.mapClass(IBox, BoxItem);

			mediatorMap.mapView(ImageView, ImageMediator, null, false);
			mediatorMap.mapView(GalleryView, GalleryMediator);

			super.startup();
		}
	}
}