<!--#include file="Include\System.asp"-->
<!--#include virtual="include\btc.asp" -->
<%
On Error Resume Next
Test = False

CompanyID = Request.Item("CompanyID")
File = Request.Item("File")
Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Payout/" + CSTR(CompanyID) + "/"

Dim oFileSys, oFile, Total

'Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
'If oCoption Is Nothing Then
'	Response.Write "ptsCoptionUser.CCoption failed to load"
'	Response.End
'Else
'    With oCoption
'        .FetchCompany CompanyID
'        .Load .CoptionID, 1
'        WalletAcct = GetKeyToken( Processor, .WalletAcct)
'       AuthenticateBitCoin WalletAcct
'    End With
'End If
'Set oCoption = Nothing

Set oFileSys = CreateObject("Scripting.FileSystemObject")
If oFileSys Is Nothing Then
	Response.Write "Scripting.FileSystemObject failed to load"
	Response.End
End If
Set oFile = oFileSys.OpenTextFile(Path + File)
If oFile Is Nothing Then
	Response.Write "Couldn't open file: " + Path + File
	Response.End
End If

Total = 0
Do While oFile.AtEndOfStream <> True
    rec = oFile.ReadLine
    a=Split(rec, "," )  'subscript zero based
    If Ubound(a) = 2 Then 
        WalletID = a(0)
        Amount = a(1)
        Note = "GCR Payout: " + a(2)
        msg = CSTR(CompanyID) + " - " + WalletID + " - " + Amount + " - " + Note
        If Test Then
            response.write "<BR>" + msg
            Total = Total + 1
        Else
            result = BitCoinPayout( CompanyID, WalletID, Amount, Note )
            If result = "OK" Then
                Total = Total + 1
            Else
                msg = "ERROR: " + result + ": " + msg + " " + Err.Description
                Response.Write "<BR>" + msg
            End If
            LogFile "BitCoinPayout", msg
        End If
    End If
Loop

oFile.Close
Set oFile = Nothing
Set oFileSys = Nothing

If Test Then
    Response.Write "<BR><BR>" + CSTR(Total) + " TEST PAYOUTS"
Else
    Response.Write "<BR><BR>" + CSTR(Total) + " PAYOUTS UPLOADED TO COINBASE"
End If

%>