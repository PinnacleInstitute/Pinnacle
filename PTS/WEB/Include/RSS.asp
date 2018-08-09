<%
'***********************************************************************
Function PublishRSS( ByVal bvCompanyID, ByVal bvChannelID )
On Error Resume Next

Path = reqSysWebDirectory + "LiveDesktop/Company/" + CStr(reqCompanyID) + "/"

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If

Set oChannel = server.CreateObject("ptsChannelUser.CChannel")
If oChannel Is Nothing Then
	Response.Write "Unable to Create Object - ptsChannelUser.CChannel"
	Response.End
End If
Set oNews = server.CreateObject("ptsNewsUser.CNewss")
If oNews Is Nothing Then
	Response.Write "Unable to Create Object - ptsNewsUser.CNewss"
	Response.End
End If

With oChannel
    .SysCurrentLanguage = reqSysLanguage
    .Load bvChannelID, 1
	tmpFile = .Filename
	If tmpFile = "" Then tmpFile = "RSS" & bvChannelID & ".xml"
	If InStr(tmpFile, ".") = 0 Then tmpFile = tmpFile + ".xml"

	Set oFile = oFileSys.CreateTextFile(Path + tmpFile, True)
	If oFile Is Nothing Then
		Response.Write "Couldn't open file: " + Path + tmpFile
		Response.End
	End If

	oFile.WriteLine "<?xml version=""1.0""?>"
	oFile.WriteLine "<rss version=""2.0"">"
	oFile.WriteLine "<channel>"
	
	oFile.WriteLine "<title>" + CleanXML(.Title) + "</title>"
	If .Link <> "" Then oFile.WriteLine "<link>" + CleanXML(.Link) + "</link>"
	If .Description <> "" Then oFile.WriteLine "<description>" + CleanXML(.Description) + "</description>"
	If .Language <> "" Then oFile.WriteLine "<language>" + CleanXML(.Language) + "</language>"
	If .PubDate <> "" Then oFile.WriteLine "<pubdate>" + CleanXML(.PubDate) + "</pubdate>"

	With oNews
		.SysCurrentLanguage = reqSysLanguage
		.ListNews bvChannelID
		tmpCount = .Count(1)
		
		For Each oItem In oNews
			With oItem
				oFile.WriteLine "<item>"
				oFile.WriteLine "<title>" + CleanXML(.Title) + "</title>"
				oFile.WriteLine "<link>" + CleanXML(.Link) + "</link>"
				If .Description <> "" Then oFile.WriteLine "<description>" + CleanXML(.Description) + "</description>"
				If .PubDate <> "" Then oFile.WriteLine "<pubdate>" + CleanXML(.PubDate) + "</pubdate>"
				oFile.WriteLine "</item>"
			End With
		Next
	End With

	oFile.WriteLine "</channel>"
	oFile.WriteLine "</rss>"

End With

If Err.number = 0 Then
	PublishRSS = tmpCount & " Items Successfuly Published to " + tmpfile
Else
	PublishRSS = err.description
End If	

Set oNews = Nothing
Set oChannel = Nothing
Set oFile = Nothing
Set oFileSys = Nothing

End Function



%>

