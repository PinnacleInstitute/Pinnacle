<!--#include file="Include\System.asp"-->
<% Response.Buffer=true

reqMID = Request.Item("MID")
reqDate = Numeric(Request.Item("Date"))
reqNew = Numeric(Request.Item("New"))

Set oMsgs = server.CreateObject("ptsMsgUser.CMsgs")
If oMsgs Is Nothing Then
    Response.Write "<ERROR>Unable to Create Object - ptsMsgUser.CMsgs</ERROR>"
	Response.End
Else
    With oMsgs
		.MemberMsgs reqMID, reqDate, reqNew
		xmlMsgs = .XMLMsgs()
    End With
End If
Set oMsgs = Nothing

If err.Number = 0 Then
    Response.Write xmlMsgs
Else
    Response.Write "<ERROR number=""" + CStr(Err.number) + """>" + CleanXML(Err.Description) + "</ERROR>"
End If

Response.End

%>