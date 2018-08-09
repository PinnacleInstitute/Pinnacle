<!--#include file="Include\System.asp"-->
<!--#include file="Include\Blockchain.asp"-->
<% 
On Error Resume Next
Test = False
rate = GetUSDBTC( 1 )

satoshi   = Request.Item("value")
btc       = satoshi / 100000000.0
usd       = btc / rate
reference = Request.Item("transaction_hash")
address   = Request.Item("input_address")
confirms  = Request.Item("confirmations")
paymentid = Request.Item("p")
amount    = Request.Item("a")

If IsNumeric(paymentid) And CLng(paymentid) > 0 Then
    Status = ""
    tmpMsg = ""

    'Check if the paid price is > 1% of the payment price
    Diff = CCUR(amount) - CCUR(usd)
    Perc = CCUR(Diff / amount)
'    IF Perc >= .01 Then
    IF Perc >= .02 Then
        Status = "Cancel"
        tmpMsg = " - CANCELLED: " & (Perc * 100) & "%"
    End If

'   Log Results 
    str = "btc:" + CStr(btc) + " amount:" + CStr(amount) + " paymentid:" + CStr(paymentid) +  " reference:" + reference + " address:" + address  + " confirms:" + CStr(confirms) + " " + tmpMsg
    LogFile "Blockchain", str

    Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
    If oPayment Is Nothing Then
        str = "Unable to Create Object - ptsPaymentUser.CPayment"
        If Test Then Response.write "<BR>" + str
        LogFile "Blockchain", str
    Else
        With oPayment
            .Load CLng(paymentid), 1
            .PayType = 14  
            reference = Left(reference,15)

            If Status = "Cancel" Then
                .Status = 6
                .PaidDate = Date()
                .Reference = reference
                .Save 1
            Else
                If .Status <> "3" Then   
                    .Status = 3
                    .PaidDate = Date()
                    .Reference = reference
                    .Save 1
                    ProcessPayment .CompanyID, paymentid
                Else
                    .Notes = .Notes + "Duplicate Payment: " + reference
                    .Save 1
                End If
            End If
        End With
    End If
    Set oPayment = Nothing
Else
    str = "ERROR: btc:" + CStr(btc) + " amount:" + CStr(amount) + " paymentid:" + CStr(paymentid) +  " reference:" + reference + " address:" + address  + " confirms:" + CStr(confirms)
    If Test Then Response.write "<BR>" + str
    LogFile "Blockchain", str
End If

'Caller is expecting this return value
Response.write "*ok*"

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

%>