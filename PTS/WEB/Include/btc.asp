<!--#include file="Coinbase.asp"-->
<!--#include file="Comm.asp"-->
<%
g_GC_API_KEY_17  = ""
g_GC_API_SECRET_17  = ""
g_BITCOIN_KEY  = ""
g_BITCOIN_SECRET  = ""

'***********************************************************************
Function AuthenticateBitCoin(ByVal bvStr)
    On Error Resume Next
    a = Split(bvStr, "|")
    g_BITCOIN_KEY = a(0)
    g_BITCOIN_SECRET = a(1)
End Function

'***********************************************************************
Function SendBitCoinRequest( ByVal bvCompanyID, ByVal bvToEmail, ByVal bvPurpose, ByVal bvAmount, ByVal bvPaymentID )
    On Error Resume Next
    result = 0
    
    If bvCompanyID = 17 And g_BITCOIN_KEY = "" Then
        g_BITCOIN_KEY = g_GC_API_KEY_17
        g_BITCOIN_SECRET = g_GC_API_SECRET_17
    End If 
    If bvCompanyID = 17 Then
        bvFromEmail = "support@GCRMarketing.com"
        tmpSubject = "Global Coin Reserve Payment Request"
    End If 

    If g_BITCOIN_KEY <> "" Then
        SetCBKey g_BITCOIN_KEY, g_BITCOIN_SECRET
        ButtonCode = BitCoinButton( bvPurpose, bvAmount, bvPaymentID )

        If ButtonCode <> "" Then
            tmpSender = bvFromEmail
            tmpFrom = tmpSender
            tmpTo = bvToEmail
            tmpBody = "<a class=""coinbase-button"" data-code=""{code}"" href=""https://coinbase.com/checkouts/{code}"">Pay With Bitcoin</a><script src=""https://coinbase.com/assets/button.js"" type=""text/javascript""></script>"

            tmpBody = Replace( tmpBody, "{code}", ButtonCode )

            SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody    
            result = 1
        End If
    End If

    SendBitCoinRequest = result

End Function

'***********************************************************************
Function PayBitCoin( ByVal bvCompanyID, ByVal bvPurpose, ByVal bvAmount, ByVal bvPaymentID )
    On Error Resume Next
    result = ""
    
    If bvCompanyID = 17 And g_BITCOIN_KEY = "" Then
        g_BITCOIN_KEY = g_GC_API_KEY_17
        g_BITCOIN_SECRET = g_GC_API_SECRET_17
    End If 

    If g_BITCOIN_KEY <> "" Then
        SetCBKey g_BITCOIN_KEY, g_BITCOIN_SECRET
        result = BitCoinButton( bvPurpose, bvAmount, bvPaymentID )
    End If

    PayBitCoin = result

End Function

'***********************************************************************
Function BitCoinPayout( ByVal bvCompanyID, ByVal bvTo, ByVal bvAmount, ByVal bvNote )
    On Error Resume Next
    result = ""
    tmpKey = ""
    tmpSecret = ""
    
    If bvCompanyID = 17 And g_BITCOIN_KEY = "" Then
        g_BITCOIN_KEY = g_GC_API_KEY_17
        g_BITCOIN_SECRET = g_GC_API_SECRET_17
    End If 

    If g_BITCOIN_KEY <> "" Then
        SetCBKey g_BITCOIN_KEY, g_BITCOIN_SECRET
        result = SendBitCoin( bvTo, bvAmount, bvNote )
    Else
        result = "ERROR: Missing Authentication"
    End If

    BitCoinPayout = result

End Function


%>
