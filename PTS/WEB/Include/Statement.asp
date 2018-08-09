<!--#include virtual="include\BillingMerchant.asp" -->
<%
Function CreateACHFile( byVal bvCompanyID, byVal bvProcessor )
    On Error Resume Next
    '*****************************
    ' bvProcessor = 0 'Paper Check
    ' bvProcessor = 1 '???
    '*****************************
    
    Dim oFileSys, oACHFile, Rec

    Set oFileSys = CreateObject("Scripting.FileSystemObject")
    If oFileSys Is Nothing Then
        Response.Write "Scripting.FileSystemObject failed to load"
        Response.End
    End If

    Set oStatements = server.CreateObject("ptsStatementUser.CStatements")
    If oStatements Is Nothing Then
        Response.Write "ptsStatementUser.CStatements failed to load"
        Response.End
    End If

    tmpStatus = 1 'Submitted 
    tmpPayType = 1 'ACH 
    oStatements.ListStatement bvCompanyID, tmpStatus, tmpPayType
    If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

    Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Billing\" + CStr(bvCompanyID) + "\" 
    dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
    'Create File name
    Select Case bvProcessor
	Case 0 'Paper Check
        ACHFile = "ACH" + CSTR(bvProcessor) + "-" + dt + ".csv"
    End Select

    ACHTotal = 0
    For Each oItem in oStatements
        With oItem
            If ACHTotal = 0 Then
                Set oACHFile = oFileSys.CreateTextFile(Path + ACHFile, True)
                If oACHFile Is Nothing Then
                    Response.Write "Couldn't create ACH file: " + Path + ACHFile
                    Response.End
                End If
                'Write File Header
                Select Case bvProcessor
				Case 0 'Paper Check
           			Rec = "Reference,Amount,BankName,BankRoutingCode,BankAccountNumber,CheckNumber,PayorName,Memo"
					oACHFile.WriteLine(Rec)
                End Select
            End If

            'Write Transaction Record
            Select Case bvProcessor
            Case 0 'Paper Check
                GetMerchantACH .Notes, CheckBank, CheckName, CheckRoute, CheckAccount, CheckAcctType, CheckNumber
                If CheckBank <> "" Then
                    q = CHR(34)
                    .Amount = FormatCurrency(.Amount,2)
                    Rec = "Invoice #" + CStr(.StatementID) + "," + .Amount + "," + q + CheckBank + q + "," + q + CheckRoute + q + "," + q + CheckAccount + q + "," + q + CheckNumber + q + "," + q + CheckName + q + "," + q + "Merchant #" + CStr(.MerchantID) + q
                    oACHFile.WriteLine(Rec)
                    ACHTotal = ACHTotal + 1
                End If
            End Select
        End With
    Next

    If ACHTotal > 0 Then
        'Write File Footer
        Select Case bvProcessor
        Case 0 'Paper Check
        End Select
        oACHFile.Close
    End If	

    Set oACHFile = Nothing
    Set oStatements = Nothing
    Set oFileSys = Nothing

    CreateACHFile = CSTR(ACHTotal) + "|" + ACHFile
End Function

%>

