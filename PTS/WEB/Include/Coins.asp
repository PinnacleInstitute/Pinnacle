<!--#include virtual="include\Nexxus.asp" -->
<!--#include virtual="include\blockchain.asp" -->
<% 
' Bob Wood 9/4/16
' Cryptocurrency Coin Functionality
' *******************************************
' UPDATE COIN INFO AT:
' CoinAddress 16403 Coin Combobox
' Language Files CoinAdress, Payment2 
' Payment2.PayType
' Images Folder Coin1.gif... 32x32
' Merchant Store 15050
' Reward Order 15212

g_BC_Authenticate = 0
g_BC_TestAddress = "15BfNTpdJoc89VyE9FUojgMorLyXUNdWVL"
'g_BC_TestAddress = "1PW64nwfV1KTupjF9vj1JuBGS1FmYWY4Zi"
g_TestMode = 0

' *******************************************
Public Function CoinName(ByVal bvCoin)
' Initialize return as success
CoinName = ""
Select Case bvCoin
Case 1 CoinName = "BTC: Bitcoin"
Case 2 CoinName = "NXC: Nexxus Coin"
Case 3 CoinName = "ETH: Ether Coin"
Case 4 CoinName = "XRP: Ripple"
Case 5 CoinName = "LTC: Litecoin"
Case 6 CoinName = "STEEM: Steem"
Case 7 CoinName = "XMR: Monero"
Case 8 CoinName = "ETC: Etherium Classic"
Case 9 CoinName = "DASH: Dash"
Case 10 CoinName = "GCR: GCR Coin"
End Select
End Function

' *******************************************
Public Function CoinToken(ByVal bvCoin, ByVal bvAddress, ByVal bvKey )
Dim token, x, total, factor
CoinToken = ""
token = ""
x = 0
total = Len(bvAddress)
factor = (bvKey Mod 3) + 2
While x < total
    x = x + 1	
    If (x Mod factor) = 0 Then
        c = MID(bvAddress, x, 1)
        If Not IsNumeric(c) Then token = token + c
    End If
Wend
token = Left( token, 8 )
l = Len( token )
If l < 8 Then
    token = token + Mid(bvAddress, factor * factor, 8-l)
End If
CoinToken = token
End Function

' *******************************************
Public Function CoinTest(ByVal bvCoin)
Dim result
CoinTest = ""
Select Case bvCoin
Case 1 'BTC
    If g_BC_Authenticate = 0 Then
        tmpAcct = GetNexxusAcct( 14 ) 
	If g_TestMode > 0 Then response.write "<BR>Acct: " + tmpAcct
        BC_Authenticate tmpAcct
        g_BC_Authenticate = 1
    End If
    result = BC_TestAddress( g_BC_TestAddress )
    If result <> "" Then CoinTest = "OK" 
End Select
End Function

' *******************************************
Public Function CoinBalance(ByVal bvCoin, ByVal bvAddress )
'Dim amt
CoinBalance = 0
Select Case bvCoin
Case 1 'BTC
    sURL = "https://blockchain.info/address/" + bvAddress + "?format=json&limit=3"
    sResponse = Coins_SendURL( sURL ) 
    CoinBalance = Coins_GetResponse(sResponse, 3, "" ) 

'    If g_BC_Authenticate = 0 Then
'        tmpAcct = GetNexxusAcct( 14 ) 
'        BC_Authenticate tmpAcct
'        g_BC_Authenticate = 1
'    End If
'    amt = BC_AddressBalance( bvAddress )
'    If amt = "" Then amt = 0
'    CoinBalance = amt
End Select
End Function

' *******************************************
Public Function CoinPrice(ByVal bvCoin, ByVal bvCurrency)
    CoinPrice = 0
    If bvCurrency = "" Then bvCurrency = "USD"
    Set oCoinPrice = server.CreateObject("ptsCoinPriceUser.CCoinPrice")
    CoinPrice = oCoinPrice.GetPrice( bvCoin, bvCurrency )
    Set oCoinPrice = Nothing
End Function

' *******************************************
Public Function CoinAddress(ByVal bvCoin, ByVal bvLabel)
Dim tmpAcct
'Validate Coin
If bvCoin < 1 Or bvCoin > 1 Then bvCoin = 1
CoinAddress = ExistingCoinAddress(bvCoin)
If CoinAddress = "" Then
    Select Case bvCoin
    Case 1 'BTC
        If g_BC_Authenticate = 0 Then
            tmpAcct = GetNexxusAcct( 14 ) 
            BC_Authenticate tmpAcct
            g_BC_Authenticate = 1
        End If
        CoinAddress = BC_NewAddress( bvLabel )
    End Select
End If
End Function

' *******************************************
Public Function ExistingCoinAddress(ByVal bvCoin)
ExistingCoinAddress = ""
Set oPayment2 = server.CreateObject("ptsPayment2User.CPayment2")
If oPayment2 Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayment2User.CPayment2"
Else
    ExistingCoinAddress = oPayment2.Custom( 2, bvCoin, 0, 0, 0, "")
End If
Set oPayment2 = Nothing
End Function

' *******************************************
Public Function CoinInfo(ByVal bvCoin, ByVal bvAddress)
Dim sURL, sResponse
CoinInfo = ""
Select Case bvCoin
Case 1 'BTC
    sURL = "https://blockchain.info/address/" + bvAddress + "?format=json&limit=3"
    sResponse = Coins_SendURL( sURL ) 
    CoinInfo = Coins_GetResponse(sResponse, 2, "" ) 
End Select
End Function

' *******************************************
Public Function CoinQR(ByVal bvCoin, ByVal bvAddress, ByVal bvAmount, ByVal bvLabel, ByVal bvMsg, ByVal bvSize )
Dim msg
CoinQR = ""
If bvSize = 0 Then bvSize = 225
bvLabel = Server.URLencode(bvLabel)
bvMsg = Server.URLencode(bvMsg)
Select Case bvCoin
Case 1 'BTC
	msg = "https://chart.googleapis.com/chart?chs=" + CSTR(bvSize) + "x" + CSTR(bvSize) + "&cht=qr&chl=bitcoin:" + bvAddress + "?amount=" + CSTR(bvAmount)
	If bvLabel <> "" Then msg = msg + "%26label=" + Server.URLEncode(bvLabel)
	If bvMsg <> ""   Then msg = msg + "%26message=" + Server.URLEncode(bvMsg)
	CoinQR = msg
End Select
End Function

' *******************************************
Public Function CoinBlockchain(ByVal bvCoin, ByVal bvAddress )
Dim url
CoinBlockchain = ""
Select Case bvCoin
Case 1 'BTC
    url = "https://blockchain.info"
    If bvAddress <> "" Then url = url + "/address/" + bvAddress
     CoinBlockchain = url
End Select
End Function

' *******************************************
Public Function CoinSend(ByVal bvCoin, ByVal bvAddress, ByVal bvAmount, ByRef brMessage)
Dim tmpAcct
CoinSend = ""
Select Case bvCoin
Case 1 'BTC 
    If g_BC_Authenticate = 0 Then
        tmpAcct = GetNexxusAcct( 14 ) 
        BC_Authenticate tmpAcct
        g_BC_Authenticate = 1
    End If
    CoinSend = BC_SendBitCoin( bvAddress, bvAmount, brMessage ) 
End Select
End Function

'***********************************************************************
Function Coins_SendURL( ByVal bvURL ) 
    On Error Resume Next
    Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", bvURL
        .send 
        Coins_SendURL = .responseText
    End With
    Set oHTTP = Nothing
End Function

'***********************************************************************
Function Coins_GetResponse( ByVal bvResponse, ByVal bvType, ByVal bvData ) 
    Dim txns, balance, time1, d
    On Error Resume Next
    Set oJSON = New aspJSON
    oJSON.loadJSON( bvResponse )
    error = oJSON.data("error")
    If error = "" Then
        Select Case bvType
        Case 1 ' Coin Price
'           Coins_GetResponse = oJSON.data(bvData) 'cryptocompare
            Coins_GetResponse = oJSON.data("bpi")(bvData)("rate") 'coindesk
        Case 2 ' Coin Info
            txns = oJSON.data("n_tx")
            balance = oJSON.data("final_balance")
            time1 = ""       
            If txns > 0 Then       
                d = oJSON.data("txs")(0)("time")
                If IsNumeric(d) Then time1 = DateAdd("s", d, "01/01/1970 00:00:00") 
            End If
            Coins_GetResponse = CStr(balance) + "|" + CStr(time1) + "|" + CStr(txns)
        Case 3 ' Coin Balance
            Coins_GetResponse = oJSON.data("final_balance")
        End Select
    Else
        Coins_GetResponse = error
    End If
    Set oJSON = Nothing
End Function

%>
