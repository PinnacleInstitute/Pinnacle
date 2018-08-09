<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true

On Error Resume Next

reqAID = Numeric(Request.Item("AID"))
reqMID = Numeric(Request.Item("MID"))
reqSub = Request.Item("Sub")
reqMsg = Request.Item("Msg")

tmpIsMsg = 0

Set oMember = server.CreateObject("ptsMemberUser.CMember")
If oMember Is Nothing Then
    Response.write Err.Number
	Response.End
Else
    With oMember
	    tmpIsMsg = .GetIsMsg(reqMID)
		Response.write Err.Number
    End With
	If tmpIsMsg = 1 Then
		SendMsg reqAID, reqMID, reqSub, reqMsg 
		Response.write Err.Number
	Else
		Response.write 1
	End If
End If
Set oMember = Nothing

Response.End

%>
