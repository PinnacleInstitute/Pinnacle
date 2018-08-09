<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
On Error Resume Next

PageSectionID = Numeric(Request.Item("PageSectionID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Export\PageSection\"

Dim oFileSys, oFile, oHTMLFile

Set oPageSection = server.CreateObject("ptsPageSectionUser.CPageSection")
If oPageSection Is Nothing Then
	Response.Write "Unable to Create Object - ptsPageSectionUser.CPageSection"
	Response.End
End If
With oPageSection
	.Load PageSectionID, 1
	File = CleanFileName(.PageSectionName) + ".xml"
End With
Set oPageSection = Nothing

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

WritePageSection PageSectionID

oFile.Close

Set oHTMLFile = Nothing
Set oFile = Nothing
Set oFileSys = Nothing

Response.Write "<BR><BR>     Successfully Exported - " + Path + File 
Response.End

'*******************************************************************************************
Function WritePageSection( pPageSectionID )
	On Error Resume Next
	Dim oPageSection, oQuestions, oChoices

	Set oPageSection = server.CreateObject("ptsPageSectionUser.CPageSection")
	If oPageSection Is Nothing Then
		Response.Write "Unable to Create Object - ptsPageSectionUser.CPageSection"
		Response.End
	End If

	With oPageSection
		.Load pPageSectionID, 1

		oFile.WriteLine( "<PAGESECTION" & _
		" pagesectionname=""" & CleanXML(.PageSectionName) & """" & _
		" filename=""" & CleanXML(.FileName) & """" &  _
		" path=""" & CleanXML(.Path) & """" &  _
		" language=""" & CleanXML(.Language) & """" &  _
		" width=""" & .Width & """" &  _
		" custom=""" & .Custom & """" &  _
		">" )

		With oHTMLFile
			.Filename = oPageSection.Filename
			If oPageSection.CompanyID = "0" Then
				.Path = reqSysWebDirectory + "Sections\"
			Else	
				.Path = reqSysWebDirectory + "Sections\Company\" + CStr(oPageSection.CompanyID)
			End If	
			.Language = oPageSection.Language
			.Load
			oFile.WriteLine( "<DATA><!--  " + .Data + "  --></DATA>" )
		End With

		oFile.WriteLine( "</PAGESECTION>" )

	End With

	Set oPageSection = Nothing

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