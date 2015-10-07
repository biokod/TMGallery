package 
{
	import app.GalleryContext;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	[SWF(width="1000", height="800", frameRate="30", quality="high", backgroundColor="#FFFFFF")]

	public class Main extends Sprite 
	{
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//--------------------------------------------------------------------------
		//
		// PRIVATE SECTION 
		//
		//--------------------------------------------------------------------------
		private var _context:GalleryContext;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_context = new GalleryContext(this);
		}
	}
}