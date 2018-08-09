<%
On Error Resume Next

PayoutID = Request.Item("udf1")
Status = Request.Item("status")
Amount = Request.Item("amount")
Member = Request.Item("member")
TxnID  = Request.Item("tr_id")

Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
If oPayout Is Nothing Then
	Response.Write "ptsPayoutUser.CPayout failed to load"
	Response.End
Else
    With oPayout
        .Load PayoutID, 1
        If Status = "ACCEPTED" Then
            .Status = 1
            .Reference = TxnID
            .PaidDate = Date()
        Else
            Result = Member + " - " + Amount + " - " + Status + " - " + PayoutID  
            .Notes = .Notes + " " + Result
            LogFile "STPPayout", "ERROR: " + Result
        End If
        .Save 1
    End With
End If
Set oPayout = Nothing

%>