﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.util {	import flash.display.Sprite;	import flash.events.*;	import flash.utils.getTimer;	import bubbletools.ui.main.BTCanvas;	public class MouseEventCapture {		public var lastEvent:MouseEvent;		private var target:MouseInteractive;		private var sprite:Sprite;		private var isOver:Boolean = false;		private var pressed:Boolean = false;		private var dragging:Boolean = false;		private var clickTimer:Number;		public function MouseEventCapture(target:MouseInteractive) {			this.target = target;		}		public function cleanup():void {			sprite = null;			target = null;		}		public function stopCapture():void {			sprite.removeEventListener(MouseEvent.MOUSE_WHEEL, captureWheel);			sprite.removeEventListener(MouseEvent.MOUSE_UP, captureUp);			sprite.removeEventListener(MouseEvent.MOUSE_DOWN, captureDown);			sprite.removeEventListener(MouseEvent.MOUSE_OVER, captureOver);			sprite.removeEventListener(MouseEvent.MOUSE_OUT, captureOut);			sprite.removeEventListener(MouseEvent.MOUSE_MOVE, captureMove);			sprite.removeEventListener(MouseEvent.CLICK, captureClick);			//sprite.removeEventListener(MouseEvent.DOUBLE_CLICK, captureDoubleClick);		}		public function resumeCapture():void {			startCapture(this.sprite, this.sprite.buttonMode);		}		public function startCapture(sprite:Sprite, cursorMode:Boolean):void {			this.sprite = sprite;			sprite.addEventListener(MouseEvent.MOUSE_WHEEL, captureWheel);			sprite.addEventListener(MouseEvent.MOUSE_UP, captureUp);			sprite.addEventListener(MouseEvent.MOUSE_DOWN, captureDown);			sprite.addEventListener(MouseEvent.MOUSE_OVER, captureOver);			sprite.addEventListener(MouseEvent.MOUSE_OUT, captureOut);			sprite.addEventListener(MouseEvent.MOUSE_MOVE, captureMove);			sprite.addEventListener(MouseEvent.CLICK, captureClick);			//sprite.addEventListener(MouseEvent.DOUBLE_CLICK, captureDoubleClick);			BTCanvas._instance.addEventListener(MouseEvent.MOUSE_UP, captureGlobalUp);			sprite.useHandCursor = cursorMode;			sprite.buttonMode = cursorMode;			sprite.tabEnabled = false;		}		//  Global events		//		public function captureGlobalUp(event:MouseEvent):void {			if (pressed) {				target.updateMouseState("up");				target.handleMouseEvent("release_outside");				pressed = false;			}		}		//  Local target sprite events		//		public function captureWheel(event:MouseEvent):void {			if (isOver) {				lastEvent = event;				if (event.delta < 0) {					target.handleMouseEvent("wheel_up");				} else {					target.handleMouseEvent("wheel_down");				}			}		}		public function captureUp(event:MouseEvent):void {			if (event.currentTarget == sprite) {				captureClick(event);				target.updateMouseState("up");				if (pressed) {					if (isOver) {						target.handleMouseEvent("release");					} else {						target.handleMouseEvent("release_outside");					}				}				pressed = false;			}		}		public function captureDown(event:MouseEvent):void {			if (event.currentTarget == sprite) {				pressed = true;				target.updateMouseState("down");				target.handleMouseEvent("press");			}		}		public function captureMove(event:MouseEvent):void {			if (event.currentTarget == sprite) {				if (isOver) {					target.handleMouseEvent("move");				}			}		}		public function captureOver(event:MouseEvent):void {			if (event.currentTarget == sprite) {				if (!isOver) {					//Debug.output(this, "OVER CAPTURED ON "+sprite["id"]);					target.updateMouseState("over");					target.handleMouseEvent("over");					isOver = true;				}			}		}		public function captureOut(event:MouseEvent):void {			if (event.currentTarget == sprite) {				isOver = false;				if (pressed) {					target.updateMouseState("out");					target.handleMouseEvent("dragout");						//pressed = false;				} else {					//Debug.output(this, "OUT CAPTURED ON "+sprite["id"]);					target.updateMouseState("out");					target.handleMouseEvent("out");				}			}		}		public function captureClick(event:MouseEvent):void {			target.updateMouseState("up");			if (event.shiftKey) {				target.handleMouseEvent("shiftclick");			} else if (event.ctrlKey) {				target.handleMouseEvent("ctrlclick");			} else {				target.handleMouseEvent("click");			}		}	/*	public function captureClick(event:MouseEvent):void {		if ((getTimer() - clickTimer) < 500) {			target.updateMouseState("up");			target.handleMouseEvent("doubleclick");		} else {			clickTimer = getTimer();			if (event.shiftKey) {				//target.updateMouseState("up");				target.handleMouseEvent("shiftclick");			} else if (event.ctrlKey) {				//target.updateMouseState("up");				target.handleMouseEvent("ctrlclick");			} else {				//target.updateMouseState("up");				target.handleMouseEvent("click");			}		}	*/	}}