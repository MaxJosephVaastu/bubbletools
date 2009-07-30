﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.tools {		import bubbletools.util.Pointdata;		public class Arrange {				public static var position:Number = 1;		public static var rows:Number = 1;		public static var columns:Number = 1;		public static var cellSize:Pointdata;		public static var padding:Number = 0;				/* Example Use				Arrange.Grid(myWindow.getCurrentSize(), 50, 50, 5);				while(Arrange.position) {							var placeAt:Pointdata = Arrange.nextPosition();					}				*/				public static function Grid(containerSize:Pointdata, itemW:Number, itemH:Number, padding:Number):void {						columns = Math.ceil(containerSize.X/itemW);			rows = Math.ceil(containerSize.Y/itemH);						cellSize = new Pointdata(itemW, itemH);						Arrange.padding = padding;			Arrange.position = 1;					}				public static function nextPosition():Pointdata {						var currentRow:Number = Math.ceil(position/columns);			var currentCol:Number = position-(currentRow-1)*columns;						trace(currentRow,currentCol);						var placement:Pointdata = new Pointdata((currentCol-1)*(cellSize.X+padding), (currentRow-1)*(cellSize.Y+padding));						if((currentRow <= rows) && (currentCol <= columns)) {								position++;						} else {								position = new Number(null);							} 						return placement;					}	}}