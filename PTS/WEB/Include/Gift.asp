<%
'****************************************************************************************
'Gift Certificate Options
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
Function GetAutoPurchase( byref oMember )
	On Error Resume Next
    opt = oMember.Referral
    pos = InStr(opt, "P")
    If pos > 0 Then
        amt = Mid(opt,pos+1, 3)
        If IsNumeric(amt) Then 
            GetAutoPurchase = CInt(amt)
        Else    
            GetAutoPurchase = 0
        End If    
    Else
        GetAutoPurchase = 0
    End If    
End Function

'****************************************************************************************
Function SetAutoPurchase( byref oMember, byVal amt )
	On Error Resume Next
    'format amount as 3 digits
    camt = ZeroPad(amt, 3)
    'get old auto purchase amount
    old_amt = GetAutoPurchase( oMember )
    old_camt = ZeroPad(old_amt, 3)
    'replace auto purchase amount if different
    If camt	<> old_camt Then
    	'get gift certificate option    
        opt = oMember.Referral
    	'get auto purchase doesn't exists, add it    
        If InStr(opt, "P") = 0 Then
            opt = opt + "P" + camt
        Else
            opt = Replace(opt, "P"+old_camt, "P"+camt )
        End If     
        oMember.Referral = opt
    End If
    SetAutoPurchase = camt
End Function

'****************************************************************************************
Function GetCashHold( byref oMember )
	On Error Resume Next
    opt = oMember.Referral
    pos = InStr(opt, "H")
    If pos > 0 Then
        amt = Mid(opt,pos+1, 4)
        If IsNumeric(amt) Then 
            GetCashHold = CInt(amt)
        Else    
            GetCashHold = 0
        End If    
    Else
        GetCashHold = 0
    End If    
End Function

'****************************************************************************************
Function SetCashHold( byref oMember, byVal amt )
	On Error Resume Next
    'format amount as 4 digits
    camt = ZeroPad(amt, 4)
    'get old hold amount
    old_amt = GetCashHold( oMember )
    old_camt = ZeroPad(old_amt, 4)
    'replace auto purchase amount if different
    If camt	<> old_camt Then
    	'get gift certificate option    
        opt = oMember.Referral
    	'get auto purchase doesn't exists, add it    
        If InStr(opt, "H") = 0 Then
            opt = opt + "H" + camt
        Else
            opt = Replace(opt, "H"+old_camt, "H"+camt )
        End If     
        oMember.Referral = opt
    End If
    SetCashHold = camt
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

'****************************************************************************************
Function ZeroPad( byVal amt, pad )
	On Error Resume Next
	camt = CStr(amt)
	length = Len(camt)
	If length > pad Then camt = Right(camt,pad)
	If length < pad Then
	    camt = Space(pad-length) + camt
        camt = Replace(camt, " ", "0" )
	End If
    ZeroPad = camt
End Function

%>

