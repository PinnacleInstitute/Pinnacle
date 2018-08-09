<!--#include file="LiveDrive.asp"-->
<% Response.Buffer=true

'****************************************************************************************
Function UpdateComputer( ByRef oMachine )
	On Error Resume Next
	UpdateComputer = UpdateUser( oMachine )
End Function

'****************************************************************************************
Function UpdateComputerStatus( ByRef oMachine, ByVal bvOldStatus )
	On Error Resume Next
	Result = "OK"
	With oMachine
		Select Case bvOldStatus
		Case 1: 'Setup->
			If .Status = 2 Then '->Active
				Result = AddUser( oMachine )
				If Result = "OK" Then
					.ActiveDate = reqSysDate 
					.Save 1
				End If	
			End If
		Case 2: 'Active->
			If .Status = 3 Then '->Cancel
				Result = SuspendUser( oMachine, 1 )
				If Result = "OK" Then
					.CancelDate = reqSysDate 
					.Save 1
				End If	
			End If
			If .Status = 4 Then '->Remove
				Result = CloseUser( oMachine )
				If Result = "OK" Then
					.LiveDriveID = 0
					.CancelDate = reqSysDate
					.RemoveDate = reqSysDate
					.Save 1
				End If	
			End If			
		Case 3: 'Cancel->
			If .Status = 2 Then '->Active
				Result = SuspendUser( oMachine, 0 )
				If Result = "OK" Then
					.ActiveDate = reqSysDate
					.CancelDate = ""
					.Save 1
				End If	
			End If			
			If .Status = 4 Then '->Remove
				Result = CloseUser( oMachine )
				If Result = "OK" Then
					.LiveDriveID = 0
					.RemoveDate = reqSysDate
					.Save 1
				End If	
			End If
		Case 4: 'Remove->
			If .Status = 2 Then '->Active
				Result = AddUser( oMachine )
				If Result = "OK" Then
					.ActiveDate = reqSysDate
					.CancelDate = ""
					.RemoveDate = ""
					.Save 1
				End If	
			End If
		End Select
	End With
	UpdateComputerStatus = Result
End Function

'****************************************************************************************
Function SetComputerWebName( ByRef oMachine )
	On Error Resume Next
	With oMachine
'		tmp = .Email
'		tmp = Replace( tmp, ".", "" )
'		tmp = Replace( tmp, "@", "" )
'		tmp = Replace( tmp, "_", "" )
		tmp = .MachineID
		If Len(tmp) < 4 Then 
			tmp = String(4 - Len(.MachineID), "0") + tmp
		End If
		.WebName = tmp
	End With
End Function

%>