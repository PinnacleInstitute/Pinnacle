<!--#include file="Include\System.asp"-->
<!--#include virtual="include\aspJSON1.17.asp" -->
<% 
On Error Resume Next
' Test=0 Production; Test=1 Test to webpage
Test = 0

If Test = 0 Then
   jsonbytes = Request.TotalBytes
   If jsonbytes > 0 Then jsonstring = BytesToStr(Request.BinaryRead(jsonbytes)) Else jsonstring = ""
'   LogFile "BitCoin", "JSON: " + jsonstring
Else
   Response.Write "<br>START TEST<br>"
   jsonstring = "{""order"":{""id"":null,""created_at"":null,""status"":""completed"",""event"":null,""total_btc"":{""cents"":100000000,""currency_iso"":""BTC""},""total_native"":{""cents"":59567,""currency_iso"":""USD""},""total_payout"":{""cents"":59567,""currency_iso"":""USD""},""custom"":""123456789"",""receive_address"":""1LiMpiDZKmhLX2c5WfHtA6KaSHmKbjS7JW"",""button"":{""type"":""buy_now"",""name"":""Test Item"",""description"":null,""id"":null},""transaction"":{""id"":""53b0477e54646c21e9000013"",""hash"":""4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"",""confirmations"":0}}}"
End If

If Len(jsonstring) > 0 And InStr(jsonstring, """order"":{" ) > 0 Then
    Set oJSON = New aspJSON
    oJSON.loadJSON(jsonstring)

    Status = oJSON.data("order")("status")
    Status2 = oJSON.data("order")("event")("type")
    Reference = oJSON.data("order")("id")
    Amount = oJSON.data("order")("total_native")("cents")
    MisPaidPrice = oJSON.data("order")("mispaid_native")("cents")
    PaymentID = oJSON.data("order")("custom")
    If Test > 0 Then Output = oJSON.JSONoutput()
    Set oJSON = Nothing

    Process = True
    tmpMsg = ""

    If Status2 = "mispayment" Then
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

'    4/4/2015 11:41:59 PM expired - mispayment - 30014 - 95DSUXHR - 29995 - 74339

'   Log Results 
    str = Status & " - " & tmpStatus2 & " - " & Reference & " - " & Amount & " - " & PaymentID & tmpMsg
    LogFile "BitCoin", str

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

                    If Status = "completed" OR Status = "mispaid" OR Status = "expired" Then
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
                            'If GCR Send Wallet Order
                            If .CompanyID = 17 And InStr( .Notes, "GCRORDER:") = 0 Then
                                Result = GCROrder( .OwnerID, .Purpose )
                                If Result <> "None" Then
    							    tmp = "GCRORDER:" + Result + " " + CStr(Now())
	    						    .Notes = Left(tmp,500)
                                    .Save 1
                                End If
                            End If 
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
        Response.Write "<br>Status: " & Status
        Response.Write "<br>Event: " & Status2
        Response.Write "<br>Reference: " & Reference
        Response.Write "<br>PaymentID: " & PaymentID
        Response.Write "<br>Amount: " & Amount
        Response.Write "<br>JSON: " & Output
        Response.Write "<br><br>END TEST"
    End If
Else
    LogFile "BitCoin", "Error: " + jsonstring
End If

'***********************************************************************
Function GCROrder(byVal bvMemberID, byVal bvPurpose)
   On Error Resume Next
    Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
    If oHTTP Is Nothing Then
	    Response.Write "Error #" & Err.number & " - " + Err.description
    Else
        tmpURL = "http://www.GCRMarketing.com/GlobalCoinOrder.asp?MemberID=" + CStr(bvMemberID) + "&Product=" + bvPurpose
	    With oHTTP
	        .open "GET", tmpURL
	        .send
	        GCROrder = .responseText
	    End With
    End If
    Set oHTTP = Nothing
End Function

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

'***********************************************************************
Function BytesToStr(bytes)
    Dim Stream
    Set Stream = Server.CreateObject("Adodb.Stream")
        Stream.Type = 1 'adTypeBinary
        Stream.Open
        Stream.Write bytes
        Stream.Position = 0
         Stream.Type = 2 'adTypeText
        Stream.Charset = "iso-8859-1"
        BytesToStr = Stream.ReadText
        Stream.Close
    Set Stream = Nothing
End Function


%>