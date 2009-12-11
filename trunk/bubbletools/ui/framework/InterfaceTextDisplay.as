// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.framework {

	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.StyleSheet;
	import flash.text.TextFieldType;
	import flash.events.TextEvent;
	import flash.events.Event;

	import bubbletools.util.Pointdata;
	import bubbletools.util.MouseEventCapture;
	import bubbletools.ui.interfaces.IParameters;
	import bubbletools.ui.eventing.*
	import bubbletools.ui.framework.*;
	import bubbletools.ui.parameters.*
	import bubbletools.ui.framework.ComponentView;
	
	import bubbletools.util.javascript.Javascript;

	public class InterfaceTextDisplay extends InterfaceComponent {
	
		private var parameters:TextDisplayParameters;
	
		private var TEXT_HEIGHT_OFFSET:Number = 12;
		private var TEXT_GUTTER:Number = 2;
		
		private var textDisplayFormat:TextFormat;
		private var textDisplayField:TextField;
	
		public function InterfaceTextDisplay(parentComponent:InterfaceComponent){
			super(parentComponent);
			componentType = "TextDisplay";
			allowSubcomponents = false;
		}
	
		//  =====================================================================================================
		//  Required Override Methods
		//
	
		public override function setParameters(newParameters:IParameters):void {
			globalParameters = newParameters;
			parameters = TextDisplayParameters(newParameters)
		}
		public override function displayComponent():void {
		
			textDisplayFormat = new TextFormat();
			textDisplayFormat.align = parameters.getTextDisplayAlign();
			textDisplayFormat.font = getParameters().getFont();
			textDisplayFormat.color = getParameters().getTextColor();
			textDisplayFormat.size = getParameters().getFontSize();
			textDisplayFormat.bold = parameters.getTextDisplayBold();
		
			textDisplayField = new TextField();
			
			textDisplayField.addEventListener(Event.CHANGE, textChanged);
	        
			// Sizing
			
			textDisplayField.width = getParameters().getSize().X;
			textDisplayField.antiAliasType = "advanced";
			
			if(!parameters.getDefaultSize()) {
	        	textDisplayField.height = getParameters().getSize().Y;
			}

			// Editable
			
			if(parameters.getTextEditable()) {
				textDisplayField.type = TextFieldType.INPUT;
				textDisplayField.addEventListener(TextEvent.TEXT_INPUT, textEdited);
			}

			// Insert into view
			
			view.setContents(textDisplayField);
			
			// Formatting
		
			if(parameters.getStyleSheet()) {
				textDisplayField.styleSheet = parameters.getStyleSheet();
				textDisplayField.htmlText = getParameters().getText();
			} else {
				textDisplayField.text = getParameters().getText();
				textDisplayField.setTextFormat(textDisplayFormat);
			}
			
			// Selectable
					
			textDisplayField.selectable = parameters.getTextSelectable();
			textDisplayField.wordWrap = true;
			
			// Positioning
			
			textDisplayField.x = 0;
						
			if(parameters.getTextDisplayVerticalAlign() == "top") {		
				textDisplayField.y = 0;
			} else if (parameters.getTextDisplayVerticalAlign() == "center") {
				textDisplayField.y = ((getParameters().getSize().Y-textDisplayField.textHeight)/2)-TEXT_GUTTER;
			} else if (parameters.getTextDisplayVerticalAlign() == "bottom") {
				textDisplayField.y = ((getParameters().getSize().Y-textDisplayField.textHeight))-TEXT_GUTTER;
			}

		
		}

		public override function handleMouseEvent(clickType:String):void {

			switch(clickType) {
				case "press" :
					bubbleEvent(UIEventType.TEXT_PRESS);
					break;
				case "release" :
					bubbleEvent(UIEventType.TEXT_RELEASE);
					break;
				case "over" :
					bubbleEvent(UIEventType.TEXT_OVER);
					break;
				case "release_outside" :
					bubbleEvent(UIEventType.TEXT_RELEASE_OUTSIDE);
					break;	
				case "out" :
					bubbleEvent(UIEventType.TEXT_OUT);
					break;
				}
			
		}
	
		//  =====================================================================================================
		//  Custom Methods
		//
		
		public override function resize(W:Number,H:Number):void {
			currentSize = new Pointdata(W,H);
			getParameters().setScaledSize(new Pointdata(W,H));
			//view.scale(new Pointdata(W,H));
			view.updateContainerSize(new Pointdata(W,H));
			textDisplayField.width = W;
			if(!parameters.getDefaultSize()) {
				textDisplayField.height = H;
			}

		}
		
		public function useFlashFormatting():void {
			textDisplayField.styleSheet = null;
			parameters.setStyleSheet(null);
			parameters.setHTML(false);
		}
		
		public function scaleType(scale:Number):void {
			textDisplayFormat.size = scale*getParameters().getFontSize();
			if(parameters.getStyleSheet() == null) {
				textDisplayField.setTextFormat(textDisplayFormat);
			}
		}
		
		public function text():String {
			return(getParameters().getText());
		}
	
		private function textEdited(edit:TextEvent):void {
			//Debug.output(this, "flash bug : TextEvent.TEXT_INPUT --> "+textDisplayField.text);
			//parameters.setText(textDisplayField.text);
		}
	
		private function textChanged(evt:Event):void {
			Debug.output(this, "actual text :       Event.CHANGE --> "+textDisplayField.text);
			parameters.setText(evt.target.text);
		}
		
		public function updateText(replaceContents:String):void {
			
			parameters.setText(replaceContents);
			
			if(parameters.getHTML()) {
				
				textDisplayField.htmlText = getParameters().getText();
			
			} else {
									
				textDisplayField.text = getParameters().getText();
				textDisplayField.setTextFormat(textDisplayFormat);
			}
			
			if(parameters.getTextFieldScale()) {
				
				getParameters().setSize(new Pointdata(textDisplayField.width, textDisplayField.textHeight+TEXT_HEIGHT_OFFSET));
				
				textDisplayField.height = textDisplayField.textHeight+TEXT_HEIGHT_OFFSET;
				
				parentComponent.calculateContentSize();
				
				view.updateContainerSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));	
			}
			
			bubbleEvent(UIEventType.TEXT_CHANGED);
		}
		
		public function appendText(addContents:String):void {
			parameters.appendText("\n"+addContents);
			if(parameters.getHTML()) {
				textDisplayField.htmlText = getParameters().getText();
			} else {
				textDisplayField.text = getParameters().getText();
				textDisplayField.setTextFormat(textDisplayFormat);
			}
			if(parameters.getTextFieldScale()) {
				getParameters().setSize(new Pointdata(textDisplayField.width, textDisplayField.textHeight+TEXT_HEIGHT_OFFSET));
				textDisplayField.height = textDisplayField.textHeight+TEXT_HEIGHT_OFFSET;
				parentComponent.calculateContentSize();
				view.updateContainerSize(new Pointdata(getParameters().getSize().X, getParameters().getSize().Y));
			}
			bubbleEvent(UIEventType.TEXT_CHANGED);
		}
		public function updateFormat():void {
			
			textDisplayFormat = new TextFormat();
			textDisplayFormat.align = parameters.getTextDisplayAlign();
			textDisplayFormat.font = getParameters().getFont();
			textDisplayFormat.color = getParameters().getTextColor();
			textDisplayFormat.size = getParameters().getFontSize();
			textDisplayFormat.bold = parameters.getTextDisplayBold();
			
			textDisplayField.setTextFormat(textDisplayFormat);

		}

	}

}

