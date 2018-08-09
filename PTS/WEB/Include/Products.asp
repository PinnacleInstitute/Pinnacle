<%
cZowBackups = 1
cZowMoney = 2
cZowUniversity = 3

'****************************************************************************************
Function ClearProducts( byref oMember )
	On Error Resume Next
	With oMember
		.IsMaster = 0
		.Process = 0
		.Options2 = ""
		.Price = 0	
	End With
End Function

'****************************************************************************************
Function SetFastTrack( byref oMember )
	On Error Resume Next
	oMember.IsMaster = 1
End Function

'****************************************************************************************
Function GetFastTrack( byref oMember )
	On Error Resume Next
	GetFastTrack = oMember.IsMaster
End Function

'****************************************************************************************
Function GetProduct( byref oMember, byval bvProduct )
	On Error Resume Next
	GetProduct = -1

	With oMember
		Select Case bvProduct
			Case cZowBackups
				GetProduct = .Process

			Case cZowMoney
				If InStr( .Options2, "M" ) = 0 Then GetProduct = 0 Else	GetProduct = 1

			Case cZowUniversity
				If InStr( .Options2, "U" ) = 0 Then GetProduct = 0 Else	GetProduct = 1

		End Select
	End With

End Function

'****************************************************************************************
Function SetProduct( byref oMember, byval bvProduct, byval bvOption )
	On Error Resume Next
	SetProduct = -1

	With oMember
		Select Case bvProduct
			Case cZowBackups
				.Process = bvOption
				SetProduct = bvOption
				
			Case cZowMoney
				tmp = Replace( .Options2, "M", "" )
				If bvOption > 0 Then tmp = tmp + "M"
				.Options2 = tmp	
				SetProduct = bvOption

			Case cZowUniversity
				tmp = Replace( .Options2, "U", "" )
				If bvOption > 0 Then tmp = tmp + "U"
				.Options2 = tmp	
				SetProduct = bvOption
				
		End Select
	End With

End Function

'****************************************************************************************
Function GetPrice( byref oMember )
	On Error Resume Next
	tmpPrice = 0
	tmpComputers = 0
	tmpZowMoney = 0
	tmpZowUniversity = 0

	With oMember
		tmpComputers = CLng(.Process)
		If InStr( .Options2, "M" ) > 0 Then tmpZowMoney = 1
		If InStr( .Options2, "U" ) > 0 Then tmpZowUniversity = 1

		If tmpComputers > 0 Then tmpPrice = tmpComputers * 5
		If tmpZowMoney > 0 Then tmpPrice = tmpPrice + 15
		If tmpZowUniversity > 0 Then tmpPrice = tmpPrice + 15
					
		' Check for Fast Track
		If .IsMaster > 0 Then 
			tmpPrice = tmpPrice - 30
			If tmpPrice < 0 Then tmpPrice = 0		
		End If

		.Price = tmpPrice
	End With

	GetPrice = tmpPrice
		
End Function

%>

