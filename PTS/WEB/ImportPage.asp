<!--#include file="Include\System.asp"-->
<%
On Error Resume Next
CompanyID = Numeric(Request.Item("CompanyID"))
MemberID = Numeric(Request.Item("MemberID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Import\Page\"

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
Set oPage = server.CreateObject("ptsPageUser.CPage")
If oPage Is Nothing Then
	Response.Write "Unable to Create Object - ptsPageUser.CPage"
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

	ReadPage oData.selectSingleNode("PAGE")
	cnt = cnt + 1
	
	Set oData = Nothing
Next

Set oHTMLFile = Nothing
Set oPage = Nothing
Set oFolder = Nothing
Set oFileSys = Nothing

Response.Redirect "93Import.asp?Txn=1&Cnt=" & cnt

'*******************************************************************************************
Function ReadPage( poData )
	On Error Resume Next
	
	With oPage
		.CompanyID = CompanyID
		.MemberID = MemberID
		.PageName = poData.getAttribute("pagename")
		.Category = poData.getAttribute("category")
		.PageType = poData.getAttribute("pagetype")
		.Status = poData.getAttribute("status")
		.Language = poData.getAttribute("language")
		.IsPrivate = poData.getAttribute("isprivate")
		.Form = poData.getAttribute("form")
		.Filename = poData.getAttribute("filename")
		.Fields = poData.getAttribute("fields")
		PageID = .Add( 1 )
	End With
	
	With oHTMLFile
		.Filename = PageID & ".htm"
		.Path = reqSysWebDirectory + "Pages\"
		.Language = oPage.Language
		.Data = Trim(poData.selectSingleNode("DATA/comment()").Text)
		.Save
	End With

End Function

%>