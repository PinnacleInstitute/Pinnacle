<!--#include file="Include\System.asp"-->
<!--#include virtual="include\STP.asp" -->
<!--#include virtual="include\BillingPayout.asp" -->
<%
On Error Resume Next
Test = False
Processor = 13
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
       STPAuthenticate WalletAcct
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
    	    Response.Write "<BR>Not STP Payout"
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
        Msg = CSTR(CompanyID) + " - " + WalletID + " - " + Amount + " - " + Note + " - " + CSTR(PayoutID)

        If Test Then
	        Response.Write "<BR>" + Msg
	        Response.End
        End If
                
        Result = STPPayout( CompanyID, WalletID, Amount, Note, PayoutID )

        If Result = "OK" Then
            Response.Write Result
        Else
            .Load PayoutID, 1
            .Notes = .Notes + " " + Result
            .Save 1
            Msg = "ERROR: " + Result + ": " + Msg + " " + Err.Description
            Response.Write Msg
        End If
        LogFile "STPPayout", Msg
    End With        
Next

Set oBilling = Nothing
Set oPayouts = Nothing

%>