<%
'****************************************************************************************
'Prepaid Services Options
'****************************************************************************************

'****************************************************************************************
Function IsTraining( byref oMember )
	On Error Resume Next
    If InStr(oMember.Referral, "T") > 0 Then
        IsTraining = true
    Else
        IsTraining = false
    End If    
End Function

'****************************************************************************************
Function SetTraining( byref oMember )
	On Error Resume Next
    If Not IsTraining(oMember) Then
        With oMember
            .Referral = .Referral + "T"
        End With    
    End If    
    SetTraining = true
End Function

'****************************************************************************************
Function IsCompliance( byref oMember )
	On Error Resume Next
    If InStr(oMember.Referral, "C") > 0 Then
        IsCompliance = true
    Else
        IsCompliance = false
    End If    
End Function

'****************************************************************************************
Function SetCompliance( byref oMember )
	On Error Resume Next
    If Not IsCompliance(oMember) Then
        With oMember
            .Referral = .Referral + "C"
        End With    
    End If    
    SetCompliance = true    
End Function

'****************************************************************************************
Function IsFounder( byref oMember )
	On Error Resume Next
    If InStr(oMember.Referral, "F") > 0 Then
        IsFounder = true
    Else
        IsFounder = false
    End If    
End Function

'****************************************************************************************
Function SetFounder( byref oMember )
	On Error Resume Next
    If Not IsFounder(oMember) Then
        With oMember
            .Referral = .Referral + "F"
        End With    
    End If
    SetFounder = true    
End Function

%>

