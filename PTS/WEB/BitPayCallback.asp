<!--#include file="Include\System.asp"-->
<% 
On Error Resume Next
' Test=0 Production; Test=1 Test to webpage
Test = 0

If Test = 0 Then
    action     = GetCache("action")
    Reference = GetCache("invoice_id")
    amount     = GetCache("amount")
    PaymentID  = GetCache("posData")
    Status     = GetCache("status")
Else
    Response.Write "<br>START TEST<br>"
    action    = "invoiceStatus"
    Reference = "12345"
    amount    = "1.00"
    PaymentID = "1"
    Status    = "paid"
End If

If action = "invoiceStatus" Then
    Process = True
    tmpMsg = ""

    If Status = "mispayment" Then
        tmpStatus2 = Status2 & " - " & MisPaidPrice
        'Check if the mispaid price is > 1%
        Diff = CCUR(Amount) - CCUR(MisPaidPrice)
        Perc = CCUR(Diff / Amount)
        IF Perc >= .01 Then
            Process = False
            tmpMsg = " - CANCELLED: " & (Perc * 100) & "%"
       End If
    Else
        tmpStatus2 = Status2
    End If   


'   Log Results 
    str = "action:" + action + " invoice_id:" + invoice_id + " amount:" + amount +  " paymentid:" + paymentid + " status:" + status + " " + tmpMsg
    LogFile "BitPay", str

    If Test = 0 Then 
        If IsNumeric( PaymentID ) And PaymentID > 0 Then
            tmpMemberID = 0
            Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
            If oPayment Is Nothing Then
                DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
            Else
                With oPayment
                    .Load PaymentID, 1
                    .PayType = 14  

                    If Status = "paid" OR Status = "mispaid" OR Status = "expired" Then
                        .PaidDate = Date()
                        If Status2 = "mispayment" AND Not Process Then
                            .Status = 6
                            .Notes = "MISPAYMENT:" + FormatCurrency(MisPaidPrice/100) + " " + CStr(Now())
                            .Reference = Reference
                            .Save 1
                        End If   
                        If Process Then     
                            tmpMemberID = .OwnerID
                            .Status = 3
                            .Reference = Reference
                            .Save 1
                            ProcessPayment .CompanyID, PaymentID
                        End If
                    End If
                    If Status = "canceled" Then
                        .Status = 6
                        .Save 1
                    End If
                End With
            End If
            Set oPayment = Nothing

        End If
    Else	
        Response.Write "<br>action: " & action
        Response.Write "<br>invoice_id: " & invoice_id
        Response.Write "<br>amount: " & amount
        Response.Write "<br>PaymentID: " & PaymentID
        Response.Write "<br>Status: " & Status
        Response.Write "<br><br>END TEST"
    End If
Else
   LogFile "BitPay", "ERROR: action:" + action + " invoice_id:" + invoice_id + " amount:" + amount +  " paymentid:" + paymentid + " status:" + status
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

%>