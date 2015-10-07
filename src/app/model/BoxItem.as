package app.model 
{
	import app.signals.ImageReady;
	import app.view.ImageView;

	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Actor;

	[Bindable]
	public class BoxItem extends Actor implements IBox
	{
		//[Inject]
		//public var imageReadySignal:ImageReady;

		private var _index:int;
		private var _columnIndex:int;
		private var _width:int;
		private var _originalWidth:int;
		private var _height:int;
		private var _originalHeight:int;
		private var _aspectRatio:Number;
		private var _displayObject:DisplayObject;
		private var _imageURL:String;

		public function BoxItem(url:String) {
			_imageURL = url;
		}

		public function addImage(img:ImageView):void
		{
			_displayObject = img;
			_originalWidth = img.width;
			_originalHeight = img.height;
			_aspectRatio = originalWidth/originalHeight;
			img.visible = false;
			//imageReadySignal.dispatch(this);
		}

		public function destroy():void
		{

		}

		public function resetSize():void
		{
			_width = _displayObject.width = originalWidth;
			_height = _displayObject.height = originalHeight;
		}

		public function get width():int
		{
			return _width;
		}

		public function set width(n:int):void
		{
			_width = _displayObject.width = n;
			_height = _displayObject.height = n*aspectRatio;
		}

		public function get height():int
		{
			return _height;
		}

		public function set height(n:int):void
		{
			_height = _displayObject.height = n;
			_width = _displayObject.width = n*aspectRatio;
		}

		public function get originalWidth():int
		{
			return _originalWidth;
		}

		public function get originalHeight():int
		{
			return _originalHeight;
		}

		public function get aspectRatio():Number
		{
			return _aspectRatio;
		}

		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}

		public function get columnIndex():int
		{
			return _columnIndex;
		}

		public function set columnIndex(value:int):void
		{
			_columnIndex = value;
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		public function get imageURL():String
		{
			return _imageURL;
		}
	}
}