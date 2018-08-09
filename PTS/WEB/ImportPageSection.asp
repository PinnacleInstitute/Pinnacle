<!--#include file="Include\System.asp"-->
<%
On Error Resume Next
CompanyID = Numeric(Request.Item("CompanyID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Import\PageSection\"

Dim oData, oFileSys, oHTMLFile, oFolder, cnt

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFolder = oFileSys.GetFolder(Path)
If oFolder Is Nothing Then
	Response.Write "Couldn't open folder: " + Path
	Response.End
End If
Set oPageSection = server.CreateObject("ptsPageSectionUser.CPageSection")
If oPageSection Is Nothing Then
	Response.Write "Unable to Create Object - ptsPageSectionUser.CPageSection"
	Response.End
End If
Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
If oHTMLFile Is Nothing Then
	Response.Write "Unable to Create Object - wtHTMLFile.CHTMLFile"
	Response.End
End If

cnt = 0
For Each x in oFolder.Files

	Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
	oData.load Path + x.Name
	If oData.parseError <> 0 Then
		Response.Write "Import file " + x.Name + " failed with error code " + CStr(oData.parseError)
		Response.End
	End If

	ReadPageSection oData.selectSingleNode("PAGESECTION")
	cnt = cnt + 1
	
	Set oData = Nothing
Next

Set oHTMLFile = Nothing
Set oPageSection = Nothing
Set oFolder = Nothing
Set oFileSys = Nothing

Response.Redirect "91Import.asp?Txn=1&Cnt=" & cnt

'*******************************************************************************************
Function ReadPageSection( poData )
	On Error Resume Next
	
	With oPageSection
		.CompanyID = CompanyID
		.PageSectionName = poData.getAttribute("pagesectionname")
		.FileName = poData.getAttribute("filename")
		.Path = poData.getAttribute("path")
		.Language = poData.getAttribute("language")
		.Width = poData.getAttribute("width")
		.Custom = poData.getAttribute("custom")
		PageSectionID = .Add( 1 )
	End With
	
	With oHTMLFile
		.Filename = oPageSection.Filename
		If CompanyID = 0 Then
			.Path = reqSysWebDirectory + "Sections\"
		Else	
			.Path = reqSysWebDirectory + "Sections\Company\" + CStr(CompanyID)
		End If	
		.Language = oPageSection.Language
		.Data = Trim(poData.selectSingleNode("DATA/comment()").Text)
		.Save
	End With

End Function

%>