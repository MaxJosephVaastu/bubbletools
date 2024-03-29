// bubbletools.* ===============================================================================
// BubbleTools™ Web Application and User Interface Component Architecture for Actionscript 3
// ©2007 Michael Szypula.  Any modifications to this file must keep this license block intact.
// Developer : Michael Szypula
// Contact : michael.szypula@gmail.com
// License Information : Contact Developer to obtain license agreement.
// =================================================================================================

package bubbletools.ui.eventing {

	import bubbletools.core.eventing.EventType;

	public class UIEventType extends EventType {

		// UI Events

		public static var UI_RESIZE:String = "ui_resize";

		// Button Events

		public static var BUTTON_PRESS:String = "button_press";
		public static var BUTTON_RELEASE:String = "button_release";
		public static var BUTTON_OVER:String = "button_over";
		public static var BUTTON_OUT:String = "button_out";
		public static var BUTTON_RELEASE_OUTSIDE:String = "button_release_outside";
		public static var BUTTON_DRAG_OVER:String = "button_drag_over";
		public static var BUTTON_DRAG_OUT:String = "button_drag_out";
		public static var BUTTON_MOVE:String = "button_move";
		public static var BUTTON_SELECTED:String = "button_selected";
		public static var BUTTON_DESELECTED:String = "button_deselected";

		// Panel Item Events

		public static var PANEL_ITEM_RELEASE:String = "panel_item_release";
		public static var PANEL_ITEM_OVER:String = "panel_item_over";
		public static var PANEL_ITEM_OUT:String = "panel_item_out";
		public static var PANEL_ITEM_PRESS:String = "panel_item_press";
		public static var PANEL_ITEM_SELECTED:String = "panel_item_selected";
		public static var PANEL_ITEM_DESELECTED:String = "panel_item_deselected";
		public static var PANEL_ITEM_SELECTION_BLOCKED:String = "panel_item_selection_blocked";

		// Tab Bar Events   

		public static var TAB_BAR_OVER:String = "tab_bar_over";
		public static var TAB_BAR_OUT:String = "tab_bar_out";
		public static var TAB_BAR_PRESS:String = "tab_bar_press";
		public static var TAB_BAR_RELEASE:String = "tab_bar_release";
		public static var TAB_BAR_RELEASE_OUTSIDE:String = "tab_bar_release_outside";
		public static var TAB_BAR_ITEM_SELECTED:String = "tab_bar_item_selected";

		// Window Events

		public static var WINDOW_PRESS:String = "window_press";
		public static var WINDOW_CLICK:String = "window_click";
		public static var WINDOW_RELEASE:String = "window_release";
		public static var WINDOW_DROPPED_ON:String = "window_dropped_on";
		public static var WINDOW_OUT:String = "window_out";
		public static var WINDOW_OVER:String = "window_over";
		public static var WINDOW_MOVE:String = "window_move";
		public static var WINDOW_ANIMATION_COMPLETE:String = "window_animation_complete";
		public static var WINDOW_FADEIN_COMPLETE:String = "window_fadein_complete";
		public static var WINDOW_FADEOUT_COMPLETE:String = "window_fadeout_complete";

		// TitleBar Events

		public static var TITLE_BAR_PRESS:String = "title_bar_press";
		public static var TITLE_BAR_RELEASE:String = "title_bar_release";
		public static var CLOSE_BUTTON_RELEASE:String = "close_button_release";

		// Menu Events

		public static var MENU_PRESS:String = "menu_press";
		public static var MENU_RELEASE:String = "menu_release";
		public static var MENU_OVER:String = "menu_over";
		public static var MENU_OUT:String = "menu_out";
		public static var MENU_RELEASE_OUTSIDE:String = "menu_release_outside";
		public static var MENU_ITEM_SELECTED:String = "menu_item_selected";
		public static var MENU_SHOW:String = "menu_show";
		public static var MENU_HIDE:String = "menu_hide";

		// MenuItem Events

		public static var MENU_ITEM_RELEASE:String = "menu_item_release";

		// ListBox Events

		public static var LISTBOX_PRESS:String = "listbox_press";
		public static var LIST_ITEM_SELECTED:String = "list_item_selected";
		public static var LISTED_ITEM_SELECTED:String = "listed_item_selected";

		// ListItem Events

		public static var LIST_ITEM_PRESS:String = "list_item_press";
		public static var LIST_ITEM_RELEASE:String = "list_item_release";
		public static var LIST_ITEM_RELEASE_OUTSIDE:String = "list_item_release_outside";

		// SlideControl Events

		public static var SLIDE_CONTROL_PRESS:String = "slide_control_press";
		public static var SLIDE_CONTROL_RELEASE:String = "slide_control_release";
		public static var SLIDE_CONTROL_MOVE:String = "slide_control_move";
		public static var SLIDE_CONTROL_SLIDER_RELEASE:String = "slide_control_slider_release";

		// TextDisplay Events

		public static var TEXT_PRESS:String = "text_press";
		public static var TEXT_RELEASE:String = "text_release";
		public static var TEXT_OVER:String = "text_over";
		public static var TEXT_OUT:String = "text_out";
		public static var TEXT_RELEASE_OUTSIDE:String = "text_release_outside";
		public static var TEXT_CHANGED:String = "text_changed";

		// ImageDisplay Events

		public static var IMAGE_PRESS:String = "image_press";
		public static var IMAGE_RELEASE:String = "image_release";
		public static var IMAGE_OVER:String = "image_over";
		public static var IMAGE_OUT:String = "image_out";
		public static var IMAGE_RELEASE_OUTSIDE:String = "image_release_outside";
		public static var IMAGE_MOVE:String = "image_move";

		// VideoDisplay Events

		public static var VIDEO_PRESS:String = "video_press";
		public static var VIDEO_COMPLETE:String = "video_complete";
		public static var STREAM_ERROR:String = "stream_error";
		public static var BUFFER_FULL:String = "buffer_full";
		public static var BUFFER_EMPTY:String = "buffer_empty";
		public static var METADATA_LOADED:String = "metadata_loaded";
		public static var NETSTREAM_PLAY_START:String = "netstream_play_start";
		public static var NETSTREAM_PLAY_STOP:String = "netstream_play_stop";
		public static var NETSTREAM_EVENT_DUMP:String = "netstream_event_dump";
		public static var NETSTREAM_CUE_POINT:String = "netstream_cue_point";

		// VideoSeek Events

		public static var VIDEO_SEEK_START:String = "video_seek_start";
		public static var VIDEO_SEEK_COMPLETE:String = "video_seek_complete";
		public static var VIDEO_PRE_SEEK:String = "video_pre_seek";

		// HTML Display Events

		public static var HTML_SIZE_CHANGED:String = "html_size_changed";
		public static var HTML_COMPLETE:String = "html_complete";

		// SWF Display Events

		public static var SWF_PRESS:String = "swf_press";
		public static var SWF_LOADED:String = "swf_loaded";

		// Icon Events

		public static var ICON_OVER:String = "icon_over";
		public static var ICON_OUT:String = "icon_out";
		public static var ICON_CLICK:String = "icon_click";
		public static var ICON_DROP:String = "icon_drop";

		// 3D Events

		public static var READY_3D:String = "ready_3D";

		public function UIEventType() {
		}

	}

}

