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
bbdoc: wxToolbook
End Rem
Module wx.wxToolbook

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
bbdoc: Similar to wxNotebook but which uses a wxToolBar to show the labels instead of the tabs.
End Rem
Type wxToolbook Extends wxBookCtrlBase

	Function _create:wxToolbook(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxToolbook = New wxToolbook
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _xrcNew:wxToolbook(wxObjectPtr:Byte Ptr) { nomangle }
		Return wxToolbook._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateToolbook:wxToolbook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Return New wxToolbook.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxToolbook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		wxObjectPtr = bmx_wxtoolbook_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: Returns the underlying toolbar
	End Rem
	Method GetToolBar:wxToolBar()
		Return wxToolBar._create(bmx_wxtoolbook_gettoolbar(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Must be called in OnIdle or by application to realize the toolbar and select the initial page.
	End Rem
	Method Realize()
	End Method

End Type

Rem
bbdoc: This type represents the events generated by a toolbook control: currently, there are two of them.
about: The PAGE_CHANGING event is sent before the current page is changed. It allows the program to
examine the current page (which can be retrieved with GetOldSelection()) and to veto the page change
by calling Veto() if, for example, the current values in the controls of the old page are invalid.
<p>
The second event - PAGE_CHANGED - is sent after the page has been changed and the program cannot veto it
any more, it just informs it about the page change.
</p>
<p>
To summarize, if the program is interested in validating the page values before allowing the user to
change it, it should process the PAGE_CHANGING event, otherwise PAGE_CHANGED is probably enough.
In any case, it is probably unnecessary to process both events at once.
</p>
End Rem
Type wxToolbookEvent Extends wxBookCtrlEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxToolbookEvent = New wxToolbookEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
End Type

Type TToolBookEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING
				Return wxToolbookEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING
				Return bmx_wxbookctrlbase_geteventtype(eventType)
		End Select
	End Method

End Type

New TToolBookEventFactory

Type TToolbookResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxtoolbook_addresourcehandler()
	End Method
		
End Type

New TToolbookResourceFactory
