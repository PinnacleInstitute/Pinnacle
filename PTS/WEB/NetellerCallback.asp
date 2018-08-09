<!--#include file="Include\System.asp"-->
<!--#include virtual="include\aspJSON1.17.asp" -->
<% 
On Error Resume Next
' Test=0 Production; Test=1 Test to webpage
Test = 1

If Test = 0 Then
   jsonbytes = Request.TotalBytes
   If jsonbytes > 0 Then jsonstring = BytesToStr(Request.BinaryRead(jsonbytes)) Else jsonstring = ""
'   LogFile "Neteller", "JSON: " + jsonstring
   g_KEY = "???" 
Else
   Response.Write "<br>START TEST<br>"
   jsonstring = "{""mode"": ""live"",""id"": ""ebecd052-757f-4991-9f19-469d21e6c065"",""eventDate"": ""2014-01-01T00:00:00Z"",""eventType"": "payment_succeeded"",""attemptNumber"": 1,""key"": ""23haJ20opHJ2ks38aGEnw"",""links"": [{""url"":""https://api.neteller.com/v1/subscriptions/234234224/invoices/99102"",""rel"": ""invoice"",""method"": ""GET""}]}"
   g_KEY = "23haJ20opHJ2ks38aGEnw" 
End If

If Len(jsonstring) > 0 And InStr(jsonstring, """eventType"":" ) > 0 Then
    Set oJSON = New aspJSON
    oJSON.loadJSON(jsonstring)

    EventType = oJSON.data("eventType")
    Key = oJSON.data("key")
    Reference = oJSON.data("id")
    PaymentID = oJSON.data("id")

    If Test <> 0 Then Output = oJSON.JSONoutput()
    Set oJSON = Nothing

    Process = True
    If Key <> g_KEY Then Process = False   'Check for valid security key
    If Left(EventType,7) <> "payment" Then Process = False  'Only Process Payment Events

'   Log Results 
    tmpMsg = ""
    If Process = False Then tmpMsg = " - ABORTED"
    str = EventType & " - " & ID & tmpMsg
    LogFile "Neteller", str

'    If Not Process Then
'        Response.write 200
'        Response.End
'    End If

    If Test = 0 Then 
        If IsNumeric( PaymentID ) And PaymentID > 0 Then
            tmpMemberID = 0
            Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
            If oPayment Is Nothing Then
                DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
            Else
                With oPayment
                    .Load PaymentID, 1
                    .PayType = 15  
                    .Reference = Reference

                    If EventType = "payment_succeeded" Then
                        IF .Status <> 3 Then
                            .Status = 3
                            .PaidDate = Date() 
                            .Save 1
                            ProcessPayment .CompanyID, PaymentID
                        End If
                    End If
                    If EventType = "payment_pending" Then
                        .Status = 2
                        .Notes = str
                        .PaidDate = Date() 
                        tmpMemberID = .OwnerID
                        .Save 1
                        ActivateTrial .CompanyID, PaymentID, tmpMemberID
                    End If
                    If EventType = "payment_declined" Then
                        IF .Status <> 3 Then
                            .Status = 4
                            .Save 1
                        End If
                    End If
                    If EventType = "payment_cancelled" Then
                        IF .Status <> 3 Then
                            .Status = 6
                            .Save 1
                        End If
                    End If
                End With
            End If
            Set oPayment = Nothing

        End If
    Else	
        Response.Write "<br>EventType: " & EventType
        Response.Write "<br>ID: " & ID
        Response.Write "<br>Key: " & Key
        Response.Write "<br>PaymentID: " & PaymentID
        Response.Write "<br>JSON: " & Output
        Response.Write "<br><br>END TEST"
    End If
Else
    LogFile "Neteller", "Error: " + jsonstring
End If

'Must return 200 to caller
Response.write 200


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
Sub ActivateTrial(byVal bvCompanyID, byVal bvPaymentID, byVal bvMemberID)
   On Error Resume Next
   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
	    Response.Write "Error #" & Err.number & " - " + Err.description
   Else
      With oCompany
         Count = CLng(.Custom(CLng(bvCompanyID), 305, 0, CLng(bvPaymentID), CLng(bvMemberID) ))
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