<!--#include file="Include\System.asp"-->
<% 
On Error Resume Next
' Test=0 Production; Test=1 Test to webpage
Test = 0

If Test = 0 Then
'   LogFile "BitCoin", "JSON: " + jsonstring
Else
   Response.Write "<br>START TEST<br>"
End If
gateway_result
Status = Request.Item("card_transact_status")
GatewayStatus = Request.Item("gateway_result")
Reference = Request.Item("tr_id")
Amount = Request.Item("amount")
PaymentID = Request.Item("user1")
Memo = Request.Item("memo")
PayerAccount = Request.Item("payerAccount")
Hash = Request.Item("hash")

Pswd  = "lycJ}Dy6~LL0Z51"
Salt  = "s+E_a*"
MerchantAccount = "GCR LLC."

HashPswd = MD5( MD5( Pswd + Salt ) )
HashReceived = MD5( Reference + ":" + HashPswd + ":" + Amount + ":" + MerchantAccount + ":" + PayerAccount )

If HashReceived <> Hash Then
    Memo = Memo + " INVALID TRANSACTION" 
    Status = "CANCELED" 
End If

'Log Results 
str = "CONFIRM: " & Status & " - " & Reference & " - " & Amount & " - " & PaymentID & " - " & Memo & " - " & GatewayStatus 
LogFile "STP", str

If Test = 0 Then 
    If IsNumeric( PaymentID ) And PaymentID > 0 Then
        tmpMemberID = 0
        Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
        If oPayment Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
        Else
            With oPayment
                .Load PaymentID, 1
                .PayType = 13
                .Reference = Reference
                If Status = "ACCEPTED" Then
                    If CCUR(.Amount) >= CCUR(Amount) Then
                        .Status = 2
                        .Notes = .Notes + " WRONG AMOUNT PAID: " + Amount
                        .Save 1
                    Else
                        IF .Status <> 3 Then
                            .PaidDate = Date() 
                            tmpMemberID = .OwnerID
                            .Status = 3
                            .Reference = Reference
                            .Save 1
                            ProcessPayment .CompanyID, PaymentID
                        End If
                    End If
                End If
                If Status = "CANCELED" Then
                    IF .Status <> 3 Then
                        .Status = 6
                        .Notes = .Notes + Memo
                        .Save 1
                    End If
                End If
                If Status = "DECLINED" Then
                    .Status = 4
                    .Notes = .Notes + " " + GatewayStatus
                    .Save 1
                End If
            End With
        End If
        Set oPayment = Nothing

    End If
Else	
    Response.Write "<br>Status: " & Status
    Response.Write "<br>Reference: " & Reference
    Response.Write "<br>Amount: " & Amount
    Response.Write "<br>PaymentID: " & PaymentID
    Response.Write "<br>Memo: " & Memo
    Response.Write "<br><br>END TEST"
End If

'***********************************************************************
Sub ProcessPayment(byVal bvCompanyID, byVal bvPaymentID)
   On Error Resume Next
   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
	    Response.Write "Error #" & Err.number & " - " + Err.description
   Else
      With oCompany
         Count = CLng(.Custom(CLng(bvCompanyID), 99, 0, CLng(bvPaymentID), 0))
      End With
   End If
   Set oCompany = Nothing
End Sub

'****************************************************************************************
Function MD5(byVal bvString)
    On Error Resume Next
    Dim oSHA256
    Set oSHA256 = GetObject( "script:" & Server.MapPath("include/sha256md5.wsc") )
    With oSHA256
        .hexcase = 0
        MD5 = .hex_md5( bvString )
    End With
    Set oSHA256 = Nothing
End Function

%>