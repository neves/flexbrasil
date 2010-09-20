/**
*
*
*	ScaleBitmapSprite
*	
*	@author		Didier Brun - http://www.bytearray.org
*	@version	1.0
*
*/

package org.bytearray.display {
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;	

	public class ScaleBitmapSprite extends Sprite {
		
				
		// ------------------------------------------------
		//
		// ---o properties
		//
		// ------------------------------------------------
		
		private var _width : Number;
		private var _height : Number;
		private var _inner : Rectangle;
		private var _outer : Rectangle;
		private var _bitmapData : BitmapData;
		private var _outerWidth : Number;
		private var _outerHeight : Number;
		private var _minWidth : Number;
		private var _minHeight : Number;

		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		function ScaleBitmapSprite(	bitmap : BitmapData,
									inner : Rectangle,
									outer : Rectangle=null) {
			
			_inner = inner;
			_outer = outer;
			_bitmapData = bitmap;
			
			if (_outer!=null){		
				_width = outer.width;
				_height = outer.height;
				_outerWidth = bitmap.width - outer.width;
				_outerHeight = bitmap.height - outer.height;
			} else {
				_width = inner.width;
				_height = inner.height;
				_outerWidth = 0;
				_outerHeight = 0;	
			}
			
			_minWidth = bitmap.width - inner.width - _outerWidth;
			_minHeight = bitmap.height - inner.height - _outerHeight;
			
			draw();
		}

		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		 * draw
		 */
		public function draw():void {
			
			graphics.clear();
			
			ScaleBitmap.draw(	_bitmapData,
								graphics,
								Math.floor(_width + _outerWidth),
								Math.floor(_height + _outerHeight),
								_inner,
								_outer);
		}
		
	
		// ------------------------------------------------
		//
		// ---o public methods
		//
		// ------------------------------------------------
		
		/**
		 * get width
		 */
		override public function get width():Number{
			return _width;
		}
		
		/**
		 * set width
		 */
		override public function set width(w:Number):void {
			_width=Math.max(w,_minWidth);
			draw();
		}
		
		/**
		 * get height
		 */
		override public function get height():Number{
			return _height;
		}
		
		/**
		 * set height
		 */
		override public function set height(h:Number):void {
			_height=Math.max(h, _minHeight);
			draw();
		}
		
		/**
		 * get bitmapData
		 */
		public function get bitmapData() : BitmapData{
			return _bitmapData;
		}
		
		/**
		 * set bitmapData
		 */
		public function set bitmapData(b : BitmapData) : void {
			
			_bitmapData=b;
			draw();
			
		}
		
	}
}