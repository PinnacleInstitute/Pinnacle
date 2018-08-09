<!--#include file="Include\System.asp"-->
<!--#include file="Include\Blockchain.asp"-->

<% Response.Buffer=true
On Error Resume Next

response.end

Test = True
Processor = 14
CompanyID = 17

Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
    With oCoption
        .FetchCompany CompanyID
        .Load .CoptionID, 1
        If Test Then Response.Write "<BR>Wallet: " + .WalletAcct
        WalletAcct = GetKeyToken( Processor, .WalletAcct)
        If Test Then Response.Write "<BR>Authenticate: " + WalletAcct
        AuthenticateBC WalletAcct
    End With
Set oCoption = Nothing


WalletID = "1Movj6xRgu2SpzHXHKyfFyrzFsmy2ocpT5"
Amount = 10
Note = "bob's test note"
Message = ""

        rate = GetUSDBTC( 1 )
        btc = Amount * rate
        satoshi = btc * 100000000

Result = SendBitCoin( WalletID, satoshi, Note, Message )

response.write "<BR>Satoshi: " + CStr(satoshi) 
response.write "<BR>Result: " + Result
response.write "<BR>Message: " + Message
response.write "<BR>Error: " + err.description

%>