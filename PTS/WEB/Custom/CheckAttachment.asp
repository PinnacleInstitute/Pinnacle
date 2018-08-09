<% Response.Buffer=true

ParentType = Request.Item("type")
ParentID = Request.Item("id")
FileName = Request.Item("file")

On Error Resume Next

FileName = Replace(FileName, "%26", "&")

Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
If oAttachment Is Nothing Then
	Response.Write "Error #" & Err.number & " - " + Err.description
Else
	Result = oAttachment.CheckFile( ParentType, ParentID, FileName)
	If Err.number = 0 Then
		Response.Write Result
	Else	
		Response.Write "Error #" & Err.number & " - " + Err.description
	End If
	Set oAttachment = Nothing
End if	

%>