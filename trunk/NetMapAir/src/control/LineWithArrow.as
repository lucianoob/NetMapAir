package control
{
	import flash.display.Graphics;
	
	import mx.graphics.GradientEntry;
	import mx.graphics.GradientStroke;
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Line;
	
	/*
	This component is made available by adamseven GmbH
	http://www.adamseven.de
	under a creative commons license
	http://creativecommons.org/licenses/by/3.0/
	
	You are free:
	to Share — to copy, distribute and transmit the work to Remix — to adapt the work 
	Under the following conditions:
	Attribution. You must attribute the work in the manner specified by the author or 
	licensor (but not in any way that suggests that they endorse you or your use of the work). 
	
	Attribute this work:
	Leave this comment at the top of the file
	*/
	
	/**
	 * Draws a Line with an arrow at the endpoint
	 * 
	 * @author adamseven GmbH
	 * 
	 */    
	public class LineWithArrow extends Line
	{
		public function LineWithArrow()
		{
			super();
		}
		
		/**
		 * The arrow width in pixels
		 * @default 6 
		 */        
		public var arrowWidth:int = 6;
		
		/**
		 * @override
		 */        
		override protected function beginDraw(g:Graphics):void
		{
			var fillColor:uint;
			if(this.stroke is SolidColorStroke)
			{
				fillColor = (this.stroke as SolidColorStroke).color;
			}
			else if(this.stroke is GradientStroke)
			{
				fillColor = ((this.stroke as GradientStroke).entries[0] as GradientEntry).color;
			}
			g.beginFill(fillColor);
			super.beginDraw(g);
		}
		
		/**
		 * @override
		 */                
		override protected function draw(g:Graphics):void
		{
			super.draw(g);
			
			// calculate
			
			var xDist:Number = this.xTo - this.xFrom;
			var yDist:Number = this.yTo- this.yFrom;
			
			var arrRotation:Number = Math.atan(yDist/xDist);
			
			if(xDist < 0) arrRotation += Math.PI;
			
			var radRotation:Number = 30*Math.PI / 180;
			
			var rotationUp:Number = arrRotation + radRotation;
			var rotationDown:Number = arrRotation - radRotation;
			
			var x1:Number = Math.round(this.xTo - Math.cos(rotationUp) * arrowWidth);
			var y1:Number = Math.round(this.yTo - Math.sin(rotationUp) * arrowWidth);
			
			var x2:Number = Math.round(this.xTo - Math.cos(rotationDown) * arrowWidth);
			var y2:Number = Math.round(this.yTo - Math.sin(rotationDown) * arrowWidth);
			
			g.moveTo(this.xTo, this.yTo);
			g.lineTo(x1,y1);
			g.lineTo(x2,y2);
			g.lineTo(this.xTo, this.yTo);
			
		}
	}
}