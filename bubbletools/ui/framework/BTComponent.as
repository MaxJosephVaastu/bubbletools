﻿// bubbletools.* ===============================================================================// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.// Developer : Michael Szypula// Contact : michael.szypula@gmail.com// License Information : Contact Developer to obtain license agreement.// =================================================================================================package bubbletools.ui.framework {	import bubbletools.ui.eventing.*;	import bubbletools.ui.interfaces.IComponent;	import bubbletools.ui.interfaces.IParameters;	import bubbletools.ui.interfaces.Reporter;	import bubbletools.ui.interfaces.UIControl;	import bubbletools.ui.main.ComponentTypes;	import bubbletools.ui.parameters.*;	import bubbletools.util.Debug;	import bubbletools.util.MouseEventCapture;	import bubbletools.util.MouseInteractive;	import bubbletools.util.Pointdata;	import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.events.MouseEvent;	public class BTComponent extends MouseInteractive implements IComponent {		private var _subComponents:Array;		private var _parentComponentId:String;		private var _allowSubselection:Boolean = true;		public static var DESCRIPTION:String = "Main Component class from which all other components are derived.";		public var traceEvents:Boolean = false;		public var globalParameters:IParameters;		public var selectedComponent:BTComponent;		public var isSelected:Boolean = false;		public var isVisible:Boolean = true;		private var respondsTo:Array;		public var displayExists:Boolean = false;		public var contentSize:Pointdata;		public var view:ComponentView;		public var componentType:String;		public var allowSubcomponents:Boolean;		public var mouseEvents:MouseEventCapture;		public var handCursorMode:Boolean = false;		public var clickOffset:Pointdata;		public var initPosition:Pointdata; // Stores original position		public var currentSize:Pointdata; // Temp var for scaling		public function BTComponent(c:BTComponent) {			if (c) {				_parentComponentId = c.getId();			}			contentSize = new Pointdata(0, 0);			_subComponents = new Array();			respondsTo = new Array();		}		public function get allowSubselection():Boolean {			return _allowSubselection;		}		public function get parentComponent():IComponent {			return IComponent(BTUI.component(_parentComponentId));		}		public function set parentComponent(c:IComponent):void {			if (c == null) {				_parentComponentId = null;					//Debug.output(this, "parent component set to null for " + getId());			} else {				_parentComponentId = c.getId();			}		}		public function get subComponents():Array {			return _subComponents;		}		public function createComponentView():void {			if (id == "User_Interface") {				Debug.output(this, "Created top level component view");				view = new ComponentView(id);				BTUI.canvas().addChild(view);			} else {				if (parentComponent != null) {					view = parentComponent.getView().addSubView(id);				} else {					Debug.output(this, "Creating component view where there is no parent component");					view = new ComponentView(id);				}			}		}		public function checkId():void {			if (getParameters().getId() != null) {				id = getParameters().getId();			}		}		public function getStage():Sprite {			return (BTUI.canvas());		}		// Returns a custom class contstructor for components that use other Adobe libraries such as Air		public function customConstructor(className:String):Class {			return ComponentTypes.instance().getType(className).getConstructor();		}		//  =====================================================================================================		//  Main		//		public function addComponent(componentType:String, componentParameters:InterfaceParameters):IComponent {			if (allowSubcomponents) {				// Assign id if supplied in skin, otherwise pass null to use auto-generated id				var suppliedId:String = null;				if (componentParameters.getId() != null) {					suppliedId = componentParameters.getId();				}				// Create the component and fetch the newly created component's id				var newComponentId:String = BTUI.createComponent(componentType, suppliedId, this);				// Set new components to initially hidden if their parent is hidden				if (!getParameters().getVisible()) {					BTUI.component(newComponentId).isVisible = false;				}				//  Set the parameters for the new component				BTUI.component(newComponentId).setParameters(componentParameters);				//  Store the id of the new component in this component's subcomponents list				subComponents.push(newComponentId);				calculateContentSize();				//	Return a reference to the new component				return getSubcomponentByIndex(subComponents.length - 1);			} else {				Debug.output(this, "Sub components not allowed in UI type : " + getType());				return (null);			}		}		public function getSubcomponentByIndex(index:Number):BTComponent {			var cId:String = subComponents[index];			return BTComponent(BTUI.component(cId));		}		public function getIndexForSubcomponentById(id:String):Number {			var index:Number = -1;			for (var i:Number = 0; i < subComponents.length; i++) {				if (subComponents[i] == id) {					index = i;					break;				}			}			return index;		}		public function destroyView():void {			view = null;		}		public function destroyNestedComponents():void {			// override in subclasses			Debug.output(this, "destroyNestedComponents not implemented for " + getId());		}		protected function destroyNestedIfComponentExists(c:BTComponent):void {			if (c) {				c.destroyNestedComponents();			}		}		public function deleteMouseEventCapture():void {			mouseEvents.stopCapture();			mouseEvents = null;		}		public function removeSubcomponent(index:Number):void {			removeComponentObjects(index);			removeComponentReference(index);			subComponents.splice(index, 1);			BTUI.clearNulls();		}		private function removeComponentObjects(index:Number):void {			var removalComponent:IComponent = IComponent(BTUI.component(subComponents[index]));			// Remove subcomponets			if (removalComponent.subComponents.length > 0) {				var removalSubComponents:Array = removalComponent.subComponents;				for (var s:Number = 0; s < removalSubComponents.length; s++) {					removalComponent.removeSubcomponent(s);				}			}			// Remove parent link			removalComponent.parentComponent = null;			// Remove custom nested components and parameters			removalComponent.destroyNestedComponents();			// Remove event listeners 			removalComponent.deleteMouseEventCapture();			// Remove subview and all internal elements of subview			view.destroySubview(removalComponent.getView());			//  Null the view reference in the component			removalComponent.destroyView();		}		private function removeComponentReference(index:Number):void {			// Gather the component at index and all its subcomponents for deletion from top level component list			// References to the component in the top level array will be set to null			var removalsArray:Array = collectRemovals(index);			for (var i:Number = 0; i < removalsArray.length; i++) {				BTUI.remove(removalsArray[i]);			}		}		private function collectRemovals(index:Number):Array {			// Create id list of nested subcomponents to remove			var removals:Array = new Array();			// Start with the component at index			var removalComponent:IComponent = IComponent(getSubcomponentByIndex(index));			removals.push(removalComponent.getId());			// Gather the ids of its subcomponents			if (removalComponent.subComponents.length > 0) {				for (var i:Number = 0; i < getSubcomponentByIndex(index).subComponents.length; i++) {					removals = removals.concat(getSubcomponentByIndex(index).collectRemovals(i));				}			}			return (removals);		}		public function select():void {			isSelected = true;		}		public function deselect():void {			isSelected = false;		}		public function disableMouseEventsExcluding(exclusion:BTComponent):void {			if (mouseEvents) {				handleMouseEvent("out");				mouseEvents.stopCapture();			}			if (subComponents.length > 0) {				for (var i:Number = 0; i < subComponents.length; i++) {					if (BTComponent(getSubcomponentByIndex(i)) != exclusion) {						getSubcomponentByIndex(i).disableMouseEventsExcluding(exclusion);					}				}			}		}		public function disableMouseEvents():void {			if (mouseEvents) {				handleMouseEvent("out");				mouseEvents.stopCapture();			}			if (subComponents.length > 0) {				for (var i:Number = 0; i < subComponents.length; i++) {					getSubcomponentByIndex(i).disableMouseEvents();				}			}		}		public function resumeMouseEvents():void {			if (mouseEvents) {				mouseEvents.resumeCapture();			}			if (subComponents.length > 0) {				for (var i:Number = 0; i < subComponents.length; i++) {					getSubcomponentByIndex(i).resumeMouseEvents();				}			}		}		// fix		public function reset():void {		/*		for(var i:Number = 0; i<subComponents.length; i++) {			if(getSub(i).subComponents.length > 0) {				getSub(i).reset();			}			if(getSub(i).getView()) {				getSub(i).getView().removeContainer();			} else {				Debug.output(this, "resetting component "+getId()+" had no view");			}		}		*/		}		//  =====================================================================================================		//	Reparenting		//		public function reParent(newParent:BTComponent):void {			var childId:Number;			for (var i:Number = 0; i < parentComponent.getComponents().length; i++) {				if (parentComponent.getSubcomponentByIndex(i) == this) {					childId = i;					break;				}			}			parentComponent.releaseComponent(newParent, childId);		}		public function releaseComponent(newParent:BTComponent, childId:Number):void {			// create positioning offset			var positionOffset:Pointdata = getGlobalLocation(null);			// remove			var transferComponent:BTComponent = getSubcomponentByIndex(childId);			subComponents.splice(childId, 1);			// remove view			view.removeView(transferComponent.getView());			// assign to the new parent			newParent.acceptComponent(transferComponent, positionOffset);		}		public function acceptComponent(transferComponent:BTComponent, positionOffset:Pointdata):void {			// set the items parent to this component			transferComponent.parentComponent = this;			transferComponent.updatePosition(-getGlobalLocation(null).X + positionOffset.X, -getGlobalLocation(null).Y + positionOffset.Y);			// insert view			view.insertView(transferComponent.getView());			transferComponent.display();			subComponents.push(transferComponent.getId());		}		//  =====================================================================================================		//	Parameters		//		public function setParameters(globalParameters:IParameters):void {		}		public function extendParameters():void {		}		public function getContainedItems():Number {			var containedCount:int = 0;			for (var i:Number = 0; i < subComponents.length; i++) {				containedCount += getSubcomponentByIndex(i).getContainedItems();				containedCount++;			}			return containedCount;		}		public function setToTop():void {			var subviewCount:Number = parentComponent.getView().getSubview().numChildren;			//Debug.output(this, "Setting "+getId()+" to top of "+subviewCount+" items in "+parentComponent.getId());			parentComponent.getView().getSubview().setChildIndex(view, subviewCount - 1);		}		public function setToBottom():void {			var subviewCount:Number = parentComponent.getView().getSubview().numChildren;			//Debug.output(this, "Setting "+getId()+" to top of "+subviewCount+" items in "+parentComponent.getId());			parentComponent.getView().getSubview().setChildIndex(view, 0);		}		//  =====================================================================================================		//  Interaction		//		public function startDragging():void {			updateMouseState("drag");			var xOffset:Number = getParameters().getLocation().X - BTUI.canvas().mouseX;			var yOffset:Number = getParameters().getLocation().Y - BTUI.canvas().mouseY;			clickOffset = new Pointdata(xOffset, yOffset);		}		public override function isDragging(event:MouseEvent):void {			Debug.output(this, "Dragging");			var newLocalPosition:Pointdata = new Pointdata(BTUI.canvas().mouseX + clickOffset.X, BTUI.canvas().mouseY + clickOffset.Y);			if (getParameters().getDragRestricted()) {				if (!exceedsAllowableDragArea(newLocalPosition.X, newLocalPosition.Y)) {					setNewPosition(newLocalPosition.X, newLocalPosition.Y);				} else {					if (exceedsYMin(BTUI.canvas().mouseY + clickOffset.Y)) {						newLocalPosition.Y = 0;					} else if (exceedsYMax(BTUI.canvas().mouseY + clickOffset.Y)) {						newLocalPosition.Y = parentComponent.getParameters().getScaledSize().Y - getParameters().getScaledSize().Y;					}					if (exceedsXMin(BTUI.canvas().mouseX + clickOffset.X)) {						newLocalPosition.X = 0;					} else if (exceedsXMax(BTUI.canvas().mouseX + clickOffset.X)) {						newLocalPosition.X = parentComponent.getParameters().getScaledSize().X - getParameters().getScaledSize().X;					}					setNewPosition(newLocalPosition.X, newLocalPosition.Y);				}			} else {				setNewPosition(newLocalPosition.X, newLocalPosition.Y);			}		}		public function exceedsAllowableDragArea(X:Number, Y:Number):Boolean {			var exceeds:Boolean = false;			if (exceedsXMin(X)) {				exceeds = true;			}			if (exceedsXMax(X)) {				exceeds = true;			}			if (exceedsYMin(Y)) {				exceeds = true;			}			if (exceedsYMax(Y)) {				exceeds = true;			}			return exceeds;		}		public function exceedsXMin(X:Number):Boolean {			var exceeds:Boolean = false;			if (X < 0) {				exceeds = true;			}			return exceeds;		}		public function exceedsXMax(X:Number):Boolean {			var exceeds:Boolean = false;			if (X > (parentComponent.getParameters().getScaledSize().X - getParameters().getScaledSize().X)) {				exceeds = true;			}			return exceeds;		}		public function exceedsYMin(Y:Number):Boolean {			var exceeds:Boolean = false;			if (Y < 0) {				exceeds = true;			}			return exceeds;		}		public function exceedsYMax(Y:Number):Boolean {			var exceeds:Boolean = false;			if (Y > (parentComponent.getParameters().getScaledSize().Y - getParameters().getScaledSize().Y)) {				exceeds = true;			}			return exceeds;		}		public function stopDragging():void {			updateMouseState("stopdrag");			parentComponent.calculateContentSize();		}		//  =====================================================================================================		//  Display		//		//  Initial display =======================================================================================		public function displayComponents():void {			for (var i:Number = 0; i < subComponents.length; i++) {				switch (getSubcomponentByIndex(i).getType()) {					case "ScrollBar":						getSubcomponentByIndex(i).setToTop();						break;					case "TitleBar":						getSubcomponentByIndex(i).setToTop();						break;					default:						break;				}				//  If the component is set as initially hidden, set all subcomponent BTComponent isVisible value				//  to false for initial rendering.				if (!getParameters().getVisible() || !isVisible) {					getSubcomponentByIndex(i).isVisible = false;				}				getSubcomponentByIndex(i).display();			}		}		// Main render methods  =======================================================================================		public function update():void {			updateDraw();			updateDrawComponents();		}		public function updateDrawComponents():void {			for (var i:Number = 0; i < subComponents.length; i++) {				getSubcomponentByIndex(i).updateDraw();			}			for (var j:Number = 0; j < subComponents.length; j++) {				getSubcomponentByIndex(j).updateDrawComponents();			}		}		public function updateDraw():void {			view.setCoordinates(getParameters().getLocation());		}		public function getGlobalLocation(basePoint:Pointdata):Pointdata {			var loc:Pointdata;			if (basePoint == null) {				basePoint = getParameters().getLocation();			}			if (parentComponent == null) {				return basePoint;			} else {				loc = new Pointdata(basePoint.X + parentComponent.getParameters().getLocation().X,									basePoint.Y + parentComponent.getParameters().getLocation().Y);				return (parentComponent.getGlobalLocation(loc));			}		}		public function calculateContentSize():void {			var minX:Number = 0;			var minY:Number = 0;			var maxX:Number = 0;			var maxY:Number = 0;			for (var i:Number = 0; i < subComponents.length; i++) {				if (getSubcomponentByIndex(i) != null) {					if (!getSubcomponentByIndex(i).getParameters().getFixedPosition()) {						var componentParameters:IParameters = getSubcomponentByIndex(i).getParameters();						if (componentParameters.getLocation().X < minX) {							minX = componentParameters.getLocation().X;						}						if (componentParameters.getLocation().Y < minY) {							minY = componentParameters.getLocation().Y;						}						if ((componentParameters.getLocation().X + componentParameters.getSize().X) > maxX) {							maxX = componentParameters.getLocation().X + componentParameters.getSize().X;						}						if ((componentParameters.getLocation().Y + componentParameters.getSize().Y) > maxY) {							maxY = componentParameters.getLocation().Y + componentParameters.getSize().Y;						}					}				} else {					Debug.output(this, "Error : Null component inside of " + getId());				}			}			var sizeX:Number = maxX - minX;			var sizeY:Number = maxY - minY;			contentSize.X = sizeX;			contentSize.Y = sizeY;		}		public function getContentSize():Pointdata {			return contentSize;		}		// Custom Views		public function addCustomView(s:Sprite):void {			view.addCustomView(s);		}		public function removeCustomView(s:Sprite):void {			view.removeCustomView(s);		}		public function getCustomView():DisplayObject {			return view.getCustomView();		}		// Color and Outline Color =======================================================================================		public function updateColor(c:uint):void {			getParameters().setColor(c);			view.changeColor(c);		}		public function updateOutlineColor(c:uint):void {			getParameters().setOutlineColor(c);			view.changeOutlineColor(c);		}		// Reszing and repositioning =======================================================================================		public function resize(W:Number, H:Number):void {			Debug.output(this, "W/H: " + W + "/" + H);			currentSize = new Pointdata(W, H);			getParameters().setScaledSize(new Pointdata(W, H));			propagateResize(W, H);			view.scale(new Pointdata(W, H));		}		public function propagateResize(W:Number, H:Number):void {			for (var i:Number = 0; i < subComponents.length; i++) {				var inherit:Boolean = false;				var subWidth:Number = getSubcomponentByIndex(i).getParameters().getScaledSize().X;				var subHeight:Number = getSubcomponentByIndex(i).getParameters().getScaledSize().Y;				if (getSubcomponentByIndex(i).getParameters().getInheritWidth()) {					inherit = true;					if (getId() == "User_Interface") {						subWidth = W;					} else {						if (subWidth != W) {							var startPercentage:Number = getSubcomponentByIndex(i).initPosition.X / getParameters().getSize().X;							var endPercentage:Number = (getSubcomponentByIndex(i).initPosition.X + getSubcomponentByIndex(i).getParameters().getSize().X) / getParameters().getSize().X;							if ((startPercentage > 0) && (endPercentage == 100)) {								subWidth = W * startPercentage;							} else if ((startPercentage > 0) && (endPercentage < 100)) {								subWidth = W * (endPercentage - startPercentage);							} else if ((startPercentage == 0) && (endPercentage < 100)) {								subWidth = W - ((1 - endPercentage) * getSubcomponentByIndex(i).getParameters().getSize().X);							} else {								subWidth = W;							}						}					}				}				if (getSubcomponentByIndex(i).getParameters().getInheritHeight()) {					inherit = true;					var subOffsetY:Number = getSubcomponentByIndex(i).getParameters().getLocation().Y;					if (subOffsetY > 0) {						subHeight = H * ((H - subOffsetY) / H);					} else {						subHeight = H;					}				}				if (inherit) {					getSubcomponentByIndex(i).resize(subWidth, subHeight);				}				if (getSubcomponentByIndex(i).getParameters().getAnchor() != "none") {					switch (getSubcomponentByIndex(i).getParameters().getAnchor()) {						case "topright":							var offsetFromRight:Number = getParameters().getSize().X - getSubcomponentByIndex(i).initPosition.X - getSubcomponentByIndex(i).getParameters().getSize().X;							var offsetFromTop:Number = getSubcomponentByIndex(i).getParameters().getLocation().Y;							getSubcomponentByIndex(i).setNewPosition(getParameters().getScaledSize().X - offsetFromRight - getSubcomponentByIndex(i).getParameters().getSize().X, offsetFromTop);							break;						default:							break;					}				}			}		}		public function getCurrentSize():Pointdata {			var size:Pointdata;			if (currentSize) {				size = currentSize;			} else {				size = getParameters().getSize();			}			return (size);		}		public function position():Pointdata {			return (getParameters().getLocation());		}		public function setDefaultPosition(W:Number, H:Number):void {			initPosition = new Pointdata(W, H);		}		public function setComponentSize(W:Number, H:Number):void {			getParameters().getSize().X = W;			getParameters().getSize().Y = H;			resize(W, H);		}		public function restoreSize():void {			resize(getParameters().getSize().X, getParameters().getSize().Y);		}		public function rebuild(p:IParameters):void {			view.removeContainer();			Debug.output(this, "REBUILD : " + getId() + " size=" + p.getSize());			setParameters(p);			displayExists = false;			display();		}		public function setNewPosition(X:Number, Y:Number):void {			getParameters().getLocation().X = X;			getParameters().getLocation().Y = Y;			update();		}		public function restorePosition():void {			setNewPosition(initPosition.X, initPosition.Y);		}		public function updatePosition(X:Number, Y:Number):void {			getParameters().getLocation().X += X;			getParameters().getLocation().Y += Y;			update();		}		// Visibility =======================================================================================      		public function isFading():Boolean {			return view.isFading();		}		public function hide():void {			// Tells the ComponentView to hide, and sets InterfaceParameters "visible" to false.			// Subcomponents will have their ComponentView hidden, but their parameters will not be altered.			// This allows us to hide, for example, a window and everything inside it, while preserving the			// internal state of the items inside the window for the next time we open it.			hideView();			isVisible = false;			getParameters().setVisible(false);			if (allowSubcomponents) {				hideComponents();			}		}		public function show():void {			// Tells the ComponentView to show, and sets InterfaceParameters "visible" to true.			// Subcomponents will have their ComponentView shown only if their InterfaceParameters "visble" is also true.			// This allows us to show a component with some items inside of it remaining hidden.			showView();			isVisible = true;			getParameters().setVisible(true);			if (allowSubcomponents) {				showComponents();			}		}		public function hideView():void {			view.hideView();		}		public function showView():void {			view.showView();		}		public function showComponents():void {			for (var i:Number = 0; i < subComponents.length; i++) {				if (getSubcomponentByIndex(i).getParameters().getVisible()) {					getSubcomponentByIndex(i).showView();				}			}		}		public function hideComponents():void {			for (var i:Number = 0; i < subComponents.length; i++) {				getSubcomponentByIndex(i).hideView();			}		}		//  DisplayObject management  =======================================================================================		public function getView():ComponentView {			return view;		}		// Used for lazy-loads on views that need the image fully loaded before rendering, such as tiled backgrounds which need the size		public function onViewImageDataReady():void {			if (view.needsImageData) {				view.redrawView();			}			for (var i:Number = 0; i < subComponents.length; i++) {				getSubcomponentByIndex(i).onViewImageDataReady();			}		}		public function display():void {			if (!displayExists) {				initPosition = new Pointdata(getParameters().getLocation().X, getParameters().getLocation().Y);				isVisible = getParameters().getVisible();				view.drawView(getParameters().getLocation(),							  getParameters().getSize(),							  getParameters().getColor(),							  getParameters().getBackgroundImage(),							  getParameters().getMaskImage(),							  getParameters().getVisible(),							  getParameters().getBackgroundScaleType());				view.drawOutline(getParameters().getOutline(), getParameters().getSize(), getParameters().getOutlineColor());				mouseEvents = new MouseEventCapture(getId());				mouseEvents.startCapture(handCursorMode);				// Top level UI does not need hand cursor				if (id == "User_Interface") {					view.useHandCursor = false;					view.buttonMode = false;				}				if (getParameters().getUseTint()) {					view.applyGlobalTint();				}				if (getParameters().getDropShadow()) {					view.drawShadow();				}				displayExists = true;				displayComponent();			}			if (subComponents) {				if (subComponents.length > 0) {					displayComponents();				}			}		}		//  displayComponent() gets called after display(), and is intended for any component-custom display		//  routines, such as loading an image or drawing graphics.  Override this method to implement.		public function displayComponent():void {		}		//  =====================================================================================================		//  Information		//		public function getType():String {			return componentType;		}		public override function getId():String {			return id;		}		public function setId(id:String):void {			this.id = id;		}		public function getComponents():Array {			return subComponents;		}		public function getParameters():InterfaceParameters {			return (InterfaceParameters(globalParameters));		}		public function containsMouse():Boolean {			var contains:Boolean = false;			var left:Number = getGlobalLocation(null).X;			var right:Number = getGlobalLocation(null).X + getParameters().getSize().X;			var top:Number = getGlobalLocation(null).Y;			var bottom:Number = getGlobalLocation(null).Y + getParameters().getSize().Y;			var x:Number = BTUI.canvas().mouseX;			var y:Number = BTUI.canvas().mouseY;			if ((x > left) && (x < right) && (y > top) && (y < bottom)) {				contains = true;					// Debug.output(this, "[Contains Mouse] "+getId());			}			return (contains);		}		//  =====================================================================================================		//  External Events		//		//  A component may have external responses to multiple components and/or itself.		//  Each component this one is listening to gets an array of UIControl items to call.		public function addResponderTo(reporter:Reporter, interfaceResponse:UIControl):void {			if (respondsTo[reporter.getId()] == null) {				respondsTo[reporter.getId()] = new Array();			}			respondsTo[reporter.getId()].push(interfaceResponse);		}		public function hasResponderTo(reporter:BTComponent):Boolean {			if (respondsTo[reporter.getId()] != null) {				return true;			} else {				return false;			}		}		//  =====================================================================================================		//  Internal Events		//		//  Creates an event based on a string ID and bubbles it up the heirarchy		public function bubbleEvent(eventType:String):void {			var uiEvent:UIEvent = UIEventManager.instance().createUIEvent(id, componentType, eventType);			sendReport(uiEvent);			uiEvent.expire();		}		//  Sends a report to the parent component and to any responders this component has to itself		public function sendReport(interfaceEvent:UIEvent):void {			if (parentComponent) {				parentComponent.registerReport(this, interfaceEvent);			}			registerExternal(this, interfaceEvent);		}		//  This is the "standard" implementation of [registerReport].		//  It handles events sent from the basic subcomponents in a traditional GUI manner.		//		//  For example, mouse events on a textfield within a button, are sent up to the button		//  to handle, as if those events occured on the button itself.		//		//  If you are using a custom component to listen to events, override this method within		//  that component to design custom behavior.		//		//  [registerInternal] is defined in extension methods which require local state variables		//  without having to override the default behavior.		//		//  [registerExternal] sends events to any Application responders to this UI component.		//		public function registerInternal(reporter:BTComponent, interfaceEvent:UIEvent):void {		}		public function registerExternal(reporter:BTComponent, interfaceEvent:UIEvent):void {			if (hasResponderTo(reporter)) {				for (var r:Number = 0; r < respondsTo[reporter.getId()].length; r++) {					respondsTo[reporter.getId()][r].interfaceCall(Reporter(reporter).makeEvent(interfaceEvent.info.eventType));					if (traceEvents) {						Debug.output(this, "[InterfaceCall] --> " + respondsTo[reporter.getId()][r] + " " + reporter.getId() + " " + interfaceEvent.info.eventType);					}				}			}		}		public function registerReport(reporter:BTComponent, interfaceEvent:UIEvent):void {			if (traceEvents) {				Debug.output(this, "[UI EVENT] Component '" + this.id + "' Registering event from " + reporter.getId());				Debug.output(this, "  --> Event from : " + interfaceEvent.info.componentType);				Debug.output(this, "  --> Event : " + interfaceEvent.info.eventType);			}			// Handle event reports based on reporter type			switch (interfaceEvent.info.componentType) {				case "Window":					if (WindowParameters(BTWindow(reporter).getParameters()).getStack()) {						switch (interfaceEvent.info.eventType) {							case UIEventType.WINDOW_PRESS:								reporter.setToTop();								break;							default:								break;						}					}					break;				case "Icon":					if (interfaceEvent.info.eventType == UIEventType.ICON_CLICK) {						reporter.setToTop();						break;					} else if (interfaceEvent.info.eventType == UIEventType.ICON_DROP) {						reporter.setToBottom();						//bubbleEvent(UIEventType.WINDOW_DROPPED_ON);						break;					} else {						break;					}					break;				default:					// Debug.output(this, "  --> No default action specified for events from this component.");					break;			}			// Handle external events by the event type			registerExternal(reporter, interfaceEvent);			// Run any component-specific additions to event reporting			registerInternal(reporter, interfaceEvent);		}	}}