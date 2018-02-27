' Copyright (c) 2007-2018 Bruce A Henderson
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

Import wx.wx
Import wx.wxIcon


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk3-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "glue.cpp"

Extern

	Function bmx_wxaboutdialoginfo_create:Byte Ptr()
	Function bmx_wxaboutdialoginfo_delete(handle:Byte Ptr)
	Function bmx_wxaboutdialoginfo_addartist(handle:Byte Ptr, name:String)
	Function bmx_wxaboutdialoginfo_adddeveloper(handle:Byte Ptr, name:String)
	Function bmx_wxaboutdialoginfo_adddocwriter(handle:Byte Ptr, name:String)
	Function bmx_wxaboutdialoginfo_addtranslator(handle:Byte Ptr, name:String)
	Function bmx_wxaboutdialoginfo_setcopyright(handle:Byte Ptr, copyright:String)
	Function bmx_wxaboutdialoginfo_setdescription(handle:Byte Ptr, desc:String)
	Function bmx_wxaboutdialoginfo_setname(handle:Byte Ptr, name:String)
	Function bmx_wxaboutdialoginfo_setversion(handle:Byte Ptr, version:String)
	Function bmx_wxaboutdialoginfo_setwebsite(handle:Byte Ptr, url:String, desc:String)

	Function bmx_wxaboutdialoginfo_setartists(handle:Byte Ptr, names:String[])
	Function bmx_wxaboutdialoginfo_setlicence(handle:Byte Ptr, licence:String)
	Function bmx_wxaboutdialoginfo_setdevelopers(handle:Byte Ptr, names:String[])
	Function bmx_wxaboutdialoginfo_setdocwriters(handle:Byte Ptr, names:String[])
	Function bmx_wxaboutdialoginfo_seticon(handle:Byte Ptr, icon:Byte Ptr)
	Function bmx_wxaboutdialoginfo_settranslators(handle:Byte Ptr, names:String[])

	Function bmx_wxaboutbox(info:Byte Ptr)
	
End Extern
