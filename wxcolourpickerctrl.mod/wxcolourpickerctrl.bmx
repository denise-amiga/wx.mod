' Copyright (c) 2007-2015 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxColourPickerCtrl
End Rem
Module wx.wxColourPickerCtrl

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2015 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This control allows the user to select a colour.
about: The generic implementation is a button which brings up a wxColourDialog when clicked.
Native implementation may differ but this is usually a (small) widget which give access to the
colour-chooser dialog.
End Rem
Type wxColourPickerCtrl Extends wxPickerBase

	Function _create:wxColourPickerCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxColourPickerCtrl = New wxColourPickerCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxColourPickerCtrl(wxObjectPtr:Byte Ptr) { nomangle }
		Return wxColourPickerCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Creates a new wxColourPickerCtrl.
	End Rem
	Function CreateColourPicker:wxColourPickerCtrl(parent:wxWindow, id:Int, colour:wxColour = Null, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxCLRP_DEFAULT_STYLE)
		Return New wxColourPickerCtrl.Create(parent, id, colour, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Creates a new wxColourPickerCtrl.
	End Rem
	Method Create:wxColourPickerCtrl(parent:wxWindow, id:Int, colour:wxColour = Null, ..
			x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxCLRP_DEFAULT_STYLE)
		If colour Then
			wxObjectPtr = bmx_wxcolourpickerctrl_create(Self, parent.wxObjectPtr, id, colour.wxObjectPtr, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxcolourpickerctrl_create(Self, parent.wxObjectPtr, id, Null, x, y, w, h, style)
		End If
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the currently selected colour.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxcolourpickerctrl_getcolour(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Sets the currently selected colour.
	End Rem
	Method SetColour(colour:wxColour)
		bmx_wxcolourpickerctrl_setcolour(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the currently selected colour.
	End Rem
	Method SetColourName(name:String)
		bmx_wxcolourpickerctrl_setcolourname(wxObjectPtr, name)
	End Method

End Type

Rem
bbdoc: This event type is used for the events generated by wxColourPickerCtrl.
End Rem
Type wxColourPickerEvent Extends wxCommandEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxColourPickerEvent = New wxColourPickerEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
	Rem
	bbdoc: Retrieve the colour the user has just selected.
	End Rem
	Method GetColour:wxColour()
		Return wxColour._create(bmx_wxcolourpickerevent_getcolour(wxEventPtr))
	End Method
	
	Rem
	bbdoc: Set the colour associated with the event.
	End Rem
	Method SetColour(colour:wxColour)
		bmx_wxcolourpickerevent_setcolour(wxEventPtr, colour.wxObjectPtr)
	End Method

End Type


Type TColourPickerEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_COMMAND_COLOURPICKER_CHANGED Then
			Return wxColourPickerEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_COMMAND_COLOURPICKER_CHANGED Then
			Return bmx_wxcolourpickerctrl_geteventtype(eventType)
		End If
	End Method
		
End Type

New TColourPickerEventFactory

Type TColourPickerCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxcolourpickerctrl_addresourcehandler()
	End Method
		
End Type

New TColourPickerCtrlResourceFactory
