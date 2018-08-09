<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
On Error Resume Next

GoalID = Numeric(Request.Item("GoalID"))
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
Path = reqSysWebDirectory + "Export\Goal\"

Dim oFileSys, oFile

Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
If oGoal Is Nothing Then
	Response.Write "Unable to Create Object - ptsGoalUser.CGoal"
	Response.End
End If
With oGoal
	.Load GoalID, 1
	File = CleanFileName(.GoalName) + ".xml"
End With
Set oGoal = Nothing

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

oFile.WriteLine( "<?xml version='1.0' encoding='windows-1252'?>" )

WriteGoal GoalID

oFile.Close

Set oFile = Nothing
Set oFileSys = Nothing

Response.Write "<BR><BR>     Successfully Exported - " + Path + File 
Response.End

'*******************************************************************************************
Function WriteGoal( pGoalID )
	On Error Resume Next
	Dim oGoal, oGoals

	Set oGoal = server.CreateObject("ptsGoalUser.CGoal")
	If oGoal Is Nothing Then
		Response.Write "Unable to Create Object - ptsGoalUser.CGoal"
		Response.End
	End If
	Set oGoals = server.CreateObject("ptsGoalUser.CGoals")
	If oGoals Is Nothing Then
		Response.Write "Unable to Create Object - ptsGoalUser.CGoals"
		Response.End
	End If

	With oGoal
		.Load pGoalID, 1

		oFile.WriteLine( "<GOAL " & _
		" goalname=""" & CleanXML(.GoalName) & """" & _
		" goaltype=""" & .GoalType & """" & _
		" priority=""" & .Priority & """" & _
		" status=""" & .Status & """" & _
		" createdate=""" & .CreateDate & """" & _
		" commitdate=""" & .CommitDate & """" & _
		" reminddate=""" & .RemindDate & """" & _
		" template=""" & .Template & """" & _
		" children=""" & .Children & """" & _
		" qty=""" & .Qty & """" & _
		">" )

		If .Description <> "" Then
			oFile.WriteLine( "<DESCRIPTION><!--  " + .Description + "  --></DESCRIPTION>" )
		End If
		
		With oGoals
			.ListParent pGoalID
			For Each oItem in oGoals
				WriteGoal oItem.GoalID 
			Next
		End With
       		
		oFile.WriteLine( "</GOAL>" )

	End With

	Set oGoal = Nothing
	Set oGoals = Nothing

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