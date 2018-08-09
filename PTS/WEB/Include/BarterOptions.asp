<%
'******************************************************
Function GetBarterAreaCategory(byVal bvOptions, byRef brBarterAreaID, byRef brBarterCategoryID )
   On Error Resume Next
    Dim version
    a = Split(bvOptions,"|")
    If UBOUND(a) >= 0 Then
        version = a(0)
        Select Case version
        Case 1:
            brBarterAreaID = a(1)
            brBarterCategoryID = a(2)
        End Select
    End If
    SetCache "BARTERCITY", brBarterAreaID
    SetCache "BARTERCATEGORY", brBarterCategoryID
End Function

'******************************************************
Function SetBarterAreaCategory(byVal bvOptions, byVal bvBarterAreaID, byVal bvBarterCategoryID )
    On Error Resume Next
    Dim version
    If bvOptions = "" Then bvOptions = "1|0|0|"
    a = Split(bvOptions,"|")
    If UBOUND(a) >= 0 Then
        version = a(0)
        Select Case version
        Case 1:
            SetBarterAreaCategory = "1|" + CSTR(bvBarterAreaID) + "|" + CSTR(bvBarterCategoryID)  + "|" + a(3) 
        End Select
    End If
    SetCache "BARTERCITY", bvBarterAreaID
    SetCache "BARTERCATEGORY", bvBarterCategoryID
End Function

'******************************************************
Function GetBarterPayments(byVal bvOptions, ByRef brPayments )
   On Error Resume Next
    Dim version
    a = Split(bvOptions,"|")
    brPayments = ""
    If UBOUND(a) >= 0 Then
        version = a(0)
        Select Case version
        Case 1:
            brPayments = a(3)
        End Select
    End If
End Function

'******************************************************
Function SetBarterPayments(byVal bvOptions, byVal bvPayments )
    On Error Resume Next
    Dim version
    If bvOptions = "" Then bvOptions = "1|0|0|"
    a = Split(bvOptions,"|")
    If UBOUND(a) >= 0 Then
        version = a(0)
        Select Case version
        Case 1:
            SetBarterPayments = "1|" + a(1) + "|" + a(2)  + "|" + bvPayments 
        End Select
    End If
End Function

'******************************************************
Function SetBarterAdOption(byVal bvOptions, byVal bvToken, byVal bvValue )
    On Error Resume Next
    bvOptions = Replace( bvOptions, bvToken, "")
    If bvValue <> 0 Then bvOptions = bvOptions + bvToken
    SetBarterAdOption = bvOptions
End Function

%>

