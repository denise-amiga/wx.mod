/////////////////////////////////////////////////////////////////////////////
// Name:        wx/gtk/dcscreen.h
// Purpose:
// Author:      Robert Roebling
// Id:          $Id: dcscreen.h 72604 2012-10-02 15:57:03Z PC $
// Copyright:   (c) 1998 Robert Roebling
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

#ifndef _WX_GTKDCSCREEN_H_
#define _WX_GTKDCSCREEN_H_

#include "wx/dcscreen.h"
#include "wx/gtk/dcclient.h"

//-----------------------------------------------------------------------------
// wxScreenDCImpl
//-----------------------------------------------------------------------------

class WXDLLIMPEXP_CORE wxScreenDCImpl : public wxWindowDCImpl
{
public:
    wxScreenDCImpl( wxScreenDC *owner );
    ~wxScreenDCImpl();

    virtual void DoGetSize(int *width, int *height) const;

private:
    void Init();

    DECLARE_ABSTRACT_CLASS(wxScreenDCImpl)
};

#endif // _WX_GTKDCSCREEN_H_
