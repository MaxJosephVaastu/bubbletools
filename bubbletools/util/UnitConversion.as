﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.util {		public class UnitConversion {			public static var hexArray:Array = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];	public static var decArray:Array;		// Converts a decimal number to a hex number	public static function decimalToHex(decimal:Number):String {		var dec:Number = Math.round(decimal);		return(toHex(dec));	}		private static function toHex(dec:Number):String {		var remainder:Number = dec % 16;		var result:String;        if(dec-remainder == 0) {                result = hexArray[remainder];        }	else {                result = toHex( (dec-remainder)/16 )+hexArray[remainder];		}        return result;	}		// Converts a hex number to a decimal number	public static function hexToDecimal(hex:String):Number {		var decValue:Number = 0;		for(var i:Number = 0; i < hex.length; i++) {			var hexChar:String = hex.charAt(i);			decValue += Math.pow(16,hex.length-i-1)*hexValue(hexChar);		}		return(decValue);	}		// Converts a single character hex value to a number	public static function hexValue(hex:String):Number {		if(!decArray) {			decArray = new Array();			decArray["0"] = 0;			decArray["1"] = 1;			decArray["2"] = 2;			decArray["3"] = 3;			decArray["4"] = 4;			decArray["5"] = 5;			decArray["6"] = 6;			decArray["7"] = 7;			decArray["8"] = 8;			decArray["9"] = 9;			decArray["A"] = 10;			decArray["B"] = 11;			decArray["C"] = 12;			decArray["D"] = 13;			decArray["E"] = 14;			decArray["F"] = 15;			decArray["a"] = 10;			decArray["b"] = 11;			decArray["c"] = 12;			decArray["d"] = 13;			decArray["e"] = 14;			decArray["f"] = 15;		}		return(decArray[hex]);	}		public static function secondsToMMSS(totalseconds:Number):String {				var MM:String;		var SS:String;				var seconds:Number = Math.ceil(totalseconds);		var minutes:Number = Math.floor(seconds/60);				seconds = seconds % 60;				MM = String(minutes);				if(seconds < 10) {			SS = "0"+seconds;		} else {			SS = String(seconds);		}				var result:String = MM+":"+SS;		        return result;	}}}