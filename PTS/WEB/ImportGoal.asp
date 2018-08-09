<!--#include file="Include\System.asp"-->
<%
On Error Resume Next
CompanyID = Numeric(Request.Item("CompanyID"))
MemberID = Numeric(Request.Item("MemberID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Import\Goal\"

Dim oData, oFileSys, oFolder, cnt

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
Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
If oGoal Is Nothing Then
	Response.Write "Unable to Create Object - ptsGoalUser.CGoal"
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

	ReadGoal oData.selectSingleNode("GOAL"), 0
	cnt = cnt + 1
	
	Set oData = Nothing
Next

Set oGoal = Nothing
Set oFolder = Nothing
Set oFileSys = Nothing

Response.Redirect "70Import.asp?Txn=1&Cnt=" & cnt

'*******************************************************************************************
Function ReadGoal( poData, pParent )
	On Error Resume Next
	
	With oGoal
		.CompanyID = CompanyID
		.MemberID = MemberID
		.ParentID = pParent
		.GoalName = poData.getAttribute("goalname")
		.GoalType = poData.getAttribute("goaltype")
		.Priority = poData.getAttribute("priority")
		.Status = poData.getAttribute("status")
		.CreateDate = poData.getAttribute("createdate")
		.CommitDate = poData.getAttribute("commitdate")
		.RemindDate = poData.getAttribute("reminddate")
		.Template = poData.getAttribute("template")
		.Children = poData.getAttribute("children")
		.Qty = poData.getAttribute("qty")
		.Description = ""
		.Description = Trim(poData.selectSingleNode("DESCRIPTION/comment()").Text)
		GoalID = .Add( 1 )
'		GoalID = pParent + 1
'response.Write "<BR><BR>Goal Name: " & GoalID & " - " & .GoalName & " - Parent: " & pParent & " - Children: " & .Children
	End With
	
	For Each oItem In poData.selectNodes("GOAL")
		GoalName = oItem.getAttribute("goalname")
		If GoalName <> "" Then
			ReadGoal oItem, GoalID         
		End If
	Next 

End Function

%>