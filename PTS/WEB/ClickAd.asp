<%
'**************************************************************************
'Use this page to record an Ad Clcik and redirect to the AD URL
' A = AdTrackID
' U = URL to redirect to (& replaced with %26)
' Ex: clickad.asp?a=123&u=http://www.test.asp?z=1%26y=2
'**************************************************************************
On Error Resume Next

A = Request.Item("A")
URL = Request.Item("U")
URL = Replace( URL, "%26", "&")

Set oAdTrack = server.CreateObject("ptsAdTrackUser.CAdTrack")
If oAdTrack Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsAdTrackUser.CAdTrack"
Else
    oAdTrack.Click A
End If
Set oAdTrack = Nothing

Response.Redirect URL

%>