/**
*
*
*	ScaleBitmap
*	
*	@author		Didier Brun - http://www.bytearray.org
*	@version	1.0
*
*/

package org.bytearray.display {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;	

	public class ScaleBitmap {
		
		// ------------------------------------------------
		//
		// ---o public static methods
		//
		// ------------------------------------------------
		
		/**
		*	draw
		*/
		public static function draw(bitmap : BitmapData,			// bitmap data source
									graphic:Graphics,				// graphic to draw
									width:Number,					// draw width
									height:Number,					// draw height
									inner : Rectangle,				// inner rectangle (relative to 0,0)
									outer : Rectangle=null):void{	// outer rectangle (relative to 0,0)
			
			// some useful local vars
			var x:int, y:int, i:int, j:int;
			var ox:Number=0, oy:Number;
			var dx : Number = 0, dy : Number;
			var wid:Number, hei:Number;
			var dwid:Number, dhei : Number;
			var sw : int = bitmap.width;
			var sh : int = bitmap.height;
			
			// outer null ?
			if (outer==null){
				outer = new Rectangle(0,0,sw,sh);
			}
			
			
			// matrix creation
			var mat : Matrix = new Matrix();
			
			// pre-calculate widths
			var widths : Array=[	inner.left,
									inner.width,
									sw - inner.right];

			// pre-calculate heights
			var heights : Array=[	inner.top,
									inner.height,
									sh - inner.bottom];
									
			// resized part 
			var resize : Point=new Point(	width - widths[0] - widths[2],
											height - heights[0] - heights[2]);
	
			// let's draw
			for (x=0;x<3;x++){
				
				// original width
				wid = widths[x];
				
				// draw width						
				dwid = x==1 ? resize.x : widths[x];
				

				// original & draw offset
				dy=oy=0;
				
				for (y=0;y<3;y++){
					
					// original & draw height
					hei = heights[y];
					dhei = y==1 ? resize.y : heights[y];
		
					if (dwid > 0 && dhei>0){
						
						// some matrix computation
						mat.a=dwid/wid;
						mat.d=dhei/hei;
						mat.tx=-ox*mat.a + dx;
						mat.ty=-oy*mat.d + dy;
						mat.translate(-outer.left,-outer.top);
						
						// draw the cell
						graphic.beginBitmapFill(bitmap,mat,false,true);
						graphic.drawRect(dx - outer.left, dy - outer.top, dwid, dhei);
						graphic.endFill();
					}
					
					
					// offset incrementation
					oy += hei;
					dy += dhei;
				}
				
				// offset incrementation
				ox += wid;
				dx += dwid;
			}
		}
	}
}