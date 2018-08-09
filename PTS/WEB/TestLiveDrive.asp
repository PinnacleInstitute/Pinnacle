<!--#include file="Include\LiveDrive.asp"-->
<% Response.Buffer=true
	On Error Resume Next

Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
If oMachine Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - mtsMachineUser.CMachine"
Else
	With oMachine
		.NameFirst = "Bob"
		.NameLast = "Wood"
		.Email = "bob@pinnaclep.com"
		.WebName = "BobWood"
		.Password = "shabang"
		.Service = 1
		
		Result = AddUser( oMachine )

'		.LiveDriveID = 309390
'		Result = GetUser( oMachine )

'Result = AddUser( oMachine)
'Result = UpgradeUser( oMachine)
'Result = UpdateUser( oMachine)
'Result = CloseUser( oMachine)
'Result = SuspendUser( oMachine)
		
response.Write "<BR><BR>Result: " & Result

'		.Email = "1" + .Email
'		Result = UpdateUser( oMachine )
		
'response.Write "<BR><BR>UpdateUser Result: " + Result

		response.Write "<BR>" + .NameFirst + " " + .NameLast
		response.Write "<BR>" + .Email
		response.Write "<BR>" + .WebName
		response.Write "<BR>" + .BackupUsed
		response.Write "<BR>" + .BackupCapacity
	End With
End If

Set oMachine = Nothing


%>