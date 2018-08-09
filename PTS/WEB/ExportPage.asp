<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
On Error Resume Next

PageID = Numeric(Request.Item("PageID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Export\Page\"

Dim oFileSys, oFile, oHTMLFile

Set oPage = server.CreateObject("ptsPageUser.CPage")
If oPage Is Nothing Then
	Response.Write "Unable to Create Object - ptsPageUser.CPage"
	Response.End
End If
With oPage
	.Load PageID, 1
	File = CleanFileName(.PageName) + ".xml"
End With
Set oPage = Nothing

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFile = oFileSys.CreateTextFile(Path+File, True)
If oFile Is Nothing Then
	Response.Write "Couldn't create file: " + Path + File
	Response.End
End If
Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
	Response.Write "Unable to Create Object - wtHTMLFile.CHTMLFile"
	Response.End
End If

oFile.WriteLine( "<?xml version='1.0' encoding='windows-1252'?>" )

WritePage PageID

oFile.Close

Set oHTMLFile = Nothing
Set oFile = Nothing
Set oFileSys = Nothing

Response.Write "<BR><BR>     Successfully Exported - " + Path + File 
Response.End

'*******************************************************************************************
Function WritePage( pPageID )
	On Error Resume Next
	Dim oPage, oQuestions, oChoices

	Set oPage = server.CreateObject("ptsPageUser.CPage")
	If oPage Is Nothing Then
		Response.Write "Unable to Create Object - ptsPageUser.CPage"
		Response.End
	End If

	With oPage
		.Load pPageID, 1

		oFile.WriteLine( "<PAGE" & _
		" pagename=""" & CleanXML(.PageName) & """" & _
		" category=""" & CleanXML(.Category) & """" &  _
		" pagetype=""" & .PageType & """" &  _
		" status=""" & .Status & """" &  _
		" language=""" & CleanXML(.Language) & """" &  _
		">" )

		With oHTMLFile
			.Filename = pPageID & ".htm"
			.Path = reqSysWebDirectory + "Pages\"
			.Language = oPage.Language
			.Load
			oFile.WriteLine( "<DATA><!--  " + .Data + "  --></DATA>" )
		End With

		oFile.WriteLine( "</PAGE>" )

	End With

	Set oPage = Nothing

End Function

'*******************************************************************************************
Function CleanFileName( pFilename )
	On Error Resume Next
	Dim File, x, total, c

	FILENAME_CHARACTERS = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'-_/"

	total = Len( pFilename)
	File = ""
	
	For x = 1 to total
		c = Mid(pFilename, x, 1)
		If InStr( FILENAME_CHARACTERS, c ) > 0 Then 
			File = File + c
		Else
			File = File + "_"
		End If	
	Next
	
	CleanFileName = File

End Function

%>