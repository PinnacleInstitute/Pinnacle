<% 
Function GetLabel(filename, labelname)
	On Error Resume Next
	Dim labelvalue

	Set oFile = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oFile.load server.MapPath(filename)
	If oFile.parseError <> 0 Then
		Response.Write "Load file failed with error code " + filename + " (" + labelname + ")"
		Response.End
	End If

    Set oItem = oFile.selectSingleNode("LANGUAGE/LABEL[@name='" & labelname & "']")
    If Not (oItem Is Nothing) Then
        labelvalue = oItem.Text
    End If
    Set oItem = Nothing
	Set oFile = Nothing

	If labelvalue = "" Then labelvalue = labelname
	GetLabel = labelvalue
End Function

%>