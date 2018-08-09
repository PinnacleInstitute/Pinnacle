'*****************************************************************************
' Get Coin Prices from the public markets
'*****************************************************************************
'Option Explicit

PUBLIC CONST SysPath = "C:\PTS\WEB\"

PUBLIC CONST coin_BTC = 1
PUBLIC CONST coin_NXX = 2
PUBLIC CONST coin_ETH = 3
PUBLIC CONST src_CoinDesk = 2
PUBLIC CONST src_CryptoCompare = 3
PUBLIC CONST src_Blockchain = 4
PUBLIC CONST src_WinkDex = 5

PUBLIC CONST Test = 0

On Error Resume Next

Dim oCoinPrice, CurrencyCode, sURL, sResponse, CoinPrice  

Set oCoinPrice = CreateObject("ptsCoinPriceUser.CCoinPrice")
If  Test = 1 And oCoinPrice Is Nothing Then MsgBox("Unable to Create Object - ptsCoinPriceUser.CCoinPrice: " + err.description)

With oCoinPrice

    CurrencyCode = "USD"

    'Get BTC / USD Price From CoinDesk
    sURL = "https://api.coindesk.com/v1/bpi/currentprice/" +  CurrencyCode + ".json"
    sResponse = SendURL( sURL ) 
    If sResponse <> "" Then
        CoinPrice = GetResponse(sResponse, src_CoinDesk, CurrencyCode ) 
        If Test = 1 Then MsgBox("CoinDesk BTC USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_CoinDesk, coin_BTC, CurrencyCode, CoinPrice ) End If
    End If

    'Get BTC / USD Price From CryptoCompare
    sURL = "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=" + CurrencyCode
    sResponse = SendURL( sURL ) 
    If sResponse <> "" Then
        CoinPrice = GetResponse(sResponse, src_CryptoCompare, CurrencyCode ) 
        If Test = 1 Then MsgBox("CryptoCompare BTC USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_CryptoCompare, coin_BTC, CurrencyCode, CoinPrice ) End If
    End If

    'Get BTC / USD Price From Blockchain
    sURL = "https://blockchain.info/tobtc?value=100&currency=" + CurrencyCode
    sResponse = SendURL( sURL ) 
    If sResponse <> "" And IsNumeric(sResponse) Then
        CoinPrice = 100 / sResponse
        If Test = 1 Then MsgBox("Blockchain BTC USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_Blockchain, coin_BTC, CurrencyCode, CoinPrice ) End If
    End If

    'Get BTC / USD Price From WinkDex
    sURL = "https://winkdex.com/api/v0/price"
    sResponse = SendURL( sURL ) 
    If sResponse <> "" Then
        CoinPrice = GetResponse(sResponse, src_WinkDex, CurrencyCode ) 
        If IsNumeric(CoinPrice) Then CoinPrice = CoinPrice / 100
        If Test = 1 Then MsgBox("WinkDex BTC USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_WinkDex, coin_BTC, CurrencyCode, CoinPrice ) End If
    End If

    'Get NXX / USD Price From CryptoCompare
    sURL = "https://min-api.cryptocompare.com/data/price?fsym=NXX&tsyms=" + CurrencyCode
    sResponse = SendURL( sURL ) 
    If sResponse <> "" Then
        CoinPrice = GetResponse(sResponse, src_CryptoCompare, CurrencyCode ) 
        If Test = 1 Then MsgBox("CryptoCompare ETH USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_CryptoCompare, coin_NXX, CurrencyCode, CoinPrice ) End If
    End If

    'Get ETH / USD Price From CryptoCompare
    sURL = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=" + CurrencyCode
    sResponse = SendURL( sURL ) 
    If sResponse <> "" Then
        CoinPrice = GetResponse(sResponse, src_CryptoCompare, CurrencyCode ) 
        If Test = 1 Then MsgBox("CryptoCompare ETH USD: " + CStr(CoinPrice) ) End If
        If Test = 0 Then Result = .SetPrice( src_CryptoCompare, coin_ETH, CurrencyCode, CoinPrice ) End If
    End If


    'Recalculate the Nexxus Default Coin Prices
    If Test = 0 Then Result = .CalcPrice( 0 )
End With

If Test = 1 Then MsgBox("End" + Err.description)

Set oCoinPrice = Nothing

'***********************************************************************
Function SendURL( ByVal bvURL ) 
    On Error Resume Next
    Set oHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    With oHTTP
        .open "GET", bvURL
        .send 
        SendURL = .responseText
    End With
    Set oHTTP = Nothing
End Function

'***********************************************************************
Function GetResponse( ByVal bvResponse, ByVal bvSource, ByVal bvCurrency ) 
    On Error Resume Next
    GetResponse = 0
    Dim key, key2, pos, pos2 
    key = ""

    Select Case bvSource
    Case src_CoinDesk
        key = """" + bvCurrency + """,""rate"":"""
        key2 = """"
    Case src_CryptoCompare
        key = "{""" + bvCurrency + """:"
        key2 = "}"
    Case src_WinkDex
        key = "price"":"
        key2 = ","
    End Select

    If key <> "" Then
        pos = InStr( 1, bvResponse, key )
        If pos > 0 Then
            pos = pos + Len(key)
            pos2 = InStr( pos, bvResponse, key2 )
            If pos2 > 0 Then GetResponse = Mid( bvResponse, pos, pos2 - pos)
        End If
    End If
End Function

