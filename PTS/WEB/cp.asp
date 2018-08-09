<!--#include file="Include\System.asp"-->
<!--#include file="Include\Coins.asp"-->
<% Response.Buffer=true
On Error Resume Next

PaymentID = Numeric( Request.Item( "p" ) )
Token = Request.Item( "t" )

Result = 0    
'******************************
' -1  ptsPaymentUser error
' -2  ptsRewardUser error
' -3  ptsCoinAddressUser error
' -4  bad payment #
' -5  bad status
' -6  bad paytype
' -7  bad paycoins
' -8  bad payrate
' -9  bad coin address
' -10 bad security token 
' >0  partial payment amont still owed
' -12 coins already sent
' -13 bad merchant coin address 
' -14 error sending coins to merchant
' -15 missing parameter PaymentID
' -16 missing parameter Token 
' -17 system error - Crypto Processing Unavailable 
' -20 no payment found
'******************************

TestMode = False
LogMode = True

'check if we got a paymentID parameter
IF Result = 0 AND PaymentID = 0 Then
    Result = -15
End If

' check if we got a token parameter
IF Result = 0 AND Token = "" Then
    Result = -16
End If

Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
If  Result = 0 And oPayment Is Nothing Then
    Result = -1
End If

Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
If  Result = 0 And oCompany Is Nothing Then
    Result = -2
End If

If Result = 0 Then

    With oPayment
        .Load PaymentID, 1

        CompanyID = .CompanyID
        Coin_Type = .PayType - 21
        Coin_Address = .Reference
        PayCoins = 0
        aCoins = Split(.Notes, "|")
        If UBOUND(aCoins) >= 0 Then
            If IsNumeric(aCoins(0)) Then PayCoins = CDBL(aCoins(0))
        End If

        ' Coin Type should be from 1 to 10 (cryptocurrency)
        If Result = 0 And ( CLng(Coin_Type) < 1 Or CLng(Coin_Type) > 10 ) Then Result = -6 

        ' check if the crypto processing services are available
        IF Result = 0 And CoinTest( Coin_Type ) <> "OK" Then
            Result = -17
            .Status = 2 'Pending - System Error
            If Not TestMode Then .Save 1
        End If
        
        ' Did we get a valid Payment 
        If Result = 0 And CLng(.OwnerID) = 0 Then
            Result = -4 
        Else
            ' Payment Status should be submitted(1), pending(2) or partial(7)
            s = CLng(.Status)
            If Result = 0 And s <> 1 And s <> 2 And s <> 7 Then Result = -5 

            ' PayCoins should be > 0
            If Result = 0 And PayCoins <= 0 Then Result = -7

            ' Reference should contain Coin address
            If Result = 0 And .Reference = "" Then Result = -9

            If Result = 0 Then
                ' check for valid key passed in for processing
                key = PaymentID + CLng(.OwnerID)
                Token2 = CoinToken( Coin_Type, Coin_Address, key)
                If Token <> Token2 Then
                    Result = -10
                    If TestMode Then Response.write Token2
                End If
            End If
        End If

        If Result = 0 Then
            ' Get coin amount paid on blockchain in Satoshis
            PaidCoins = CoinBalance( Coin_Type, Coin_Address )

            ' Check if no payment was found
            If PaidCoins = 0 Then Result = -20

            If LogMode Then LogFile "CP", CSTR(PaymentID) + " Pay: " & CSTR(PayCoins) & " Paid: " & CSTR(PaidCoins) 

            If Result = 0 Then
               ' Check for a partial payment
                If CDBL(PaidCoins) < CDBL(PayCoins) Then
                    .Status = 7 ' partial payment
                    If TestMode Then Response.write "Pay: " + CSTR(PayCoins) & "<BR>" + "Paid: " + CSTR(PaidCoins) & "<BR>"  
                    Result = PayCoins - PaidCoins
                Else
                    .Status = 3 ' approved
                    If TestMode Then Response.write "Approved Pay: " + CSTR(PayCoins) & "<BR>" + "Paid: " + CSTR(PaidCoins) & "<BR>"  
                End If
                .Notes = CSTR(PayCoins) + "|" + CSTR(PaidCoins) 
                .PaidDate = Date()
                If Not TestMode Then .Save 1
            End If

            If Result = 0 Then
                '***** LAST: CREATE BONUSES *****
                If Not TestMode Then
                    Count = CLng(oCompany.Custom(CLng(CompanyID), 99, 0, CLng(PaymentID), 0))
                End If
            End If

        End If

    End With

End If

Set oCompany = Nothing
Set oPayment = Nothing

response.write Result

%>