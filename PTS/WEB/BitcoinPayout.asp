<!--#include file="Include\System.asp"-->
<!--#include virtual="include\btc.asp" -->
<!--#include virtual="include\BillingPayout.asp" -->
<%
On Error Resume Next
Test = True
Processor = 14
PayDate = Date()

CompanyID = Numeric(Request.Item("C"))
PayoutID = Numeric(Request.Item("P"))

IF Test Then Response.Write "START"

IF CompanyID = 0 Then
	Response.Write "Invalid CompanyID"
	Response.End
End If
IF PayoutID = 0 Then
	Response.Write "Invalid CompanyID"
	Response.End
End If

Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
If oCoption Is Nothing Then
	Response.Write "ptsCoptionUser.CCoption failed to load"
	Response.End
Else
    With oCoption
        .FetchCompany CompanyID
        .Load .CoptionID, 1
        WalletAcct = GetKeyToken( Processor, .WalletAcct)
        If Test Then Response.Write "<BR>Authenticate: " + WalletAcct
        AuthenticateBitCoin WalletAcct
    End With
End If
Set oCoption = Nothing

Set oPayouts = server.CreateObject("ptsPayoutUser.CPayouts")
If oPayouts Is Nothing Then
	Response.Write "ptsPayoutUser.CPayouts failed to load"
	Response.End
End If

Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
If oBilling Is Nothing Then
	Response.Write "ptsBillingUser.CBilling failed to load"
	Response.End
End If

oPayouts.WalletExport CompanyID, PayoutID, PayDate, Processor

'Process the one Payout in the collection
For Each oItem in oPayouts
	With oItem
        If .PayType <> CSTR(Processor) Then
    	    Response.Write "Not Bitcoin Payout"
	        Response.End
        End If
        Amount = .Amount
        a = Split(.Notes, "|")
        PayDesc = a(0)
        MemberID = a(1)
        MemberName = a(2)
        CountryName = a(3)
        PayoutBilling  PayDesc, oBilling
        WalletID =  TRIM(oBilling.CardName)
        Note = "PAYOUT: " + MemberID + " - " + Replace(MemberName + " - " + CountryName, ",", "")
        Msg = CSTR(CompanyID) + " - " + WalletID + " - " + Amount + " - " + Note

        If Test Then
	        Response.Write "<BR>" + Msg
	        Response.End
        End If
                
        Result = BitCoinPayout( CompanyID, WalletID, Amount, Note )

        .Load PayoutID, 1

        If Result = "OK" Then
            .Status = 1
            .PaidDate = Date()
            Response.Write Result
        Else
            .Notes = .Notes + " " + Result + ": " + Err.Description
            Msg = "ERROR: " + Result + ": " + Msg + " " + Err.Description
            Response.Write Msg
        End If

        .Save 1
        LogFile "BitCoinPayout", Msg
    End With        
Next

Set oBilling = Nothing
Set oPayouts = Nothing

%>