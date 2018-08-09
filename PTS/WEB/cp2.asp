<!--#include file="Include\System.asp"-->
<!--#include file="Include\Coins.asp"-->
<% Response.Buffer=true
On Error Resume Next

Payment2ID = Numeric( Request.Item( "p" ) )
Token = Request.Item( "t" )

Result = 0    
'******************************
' -1  ptsPayment2User error
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
' -14 error sending coins 
' -15 missing parameter Payment2ID
' -16 missing parameter Token 
' -17 system error - Crypto Processing Unavailable 
' -20 no payment found
'******************************

TestMode = False
LogMode = True
CompanyID = 21

'check if we got a payment2ID parameter
IF Result = 0 AND Payment2ID = 0 Then
    Result = -15
End If

' check if we got a token parameter
IF Result = 0 AND Token = "" Then
    Result = -16
End If

Set oPayment2 = server.CreateObject("ptsPayment2User.CPayment2")
If  Result = 0 And oPayment2 Is Nothing Then
    Result = -1
End If

Set oReward = server.CreateObject("ptsRewardUser.CReward")
If Result = 0 And oReward Is Nothing Then
    Result = -2
End If

Set oCoinAddress = server.CreateObject("ptsCoinAddressUser.CCoinAddress")
If Result = 0 And oCoinAddress Is Nothing Then
    Result = -3
End If
    
If Result = 0 Then

    With oPayment2
        .Load Payment2ID, 1
        Coin_Type = .PayType - 2
        Coin_Address = .Reference

        ' check if the crypto processing services are available
        IF Result = 0 And CoinTest( Coin_Type ) <> "OK" Then
            Result = -17
            .Status = 3 'Pending - System Error
            If Not TestMode Then .Save 1
        End If
        
        ' Did we get a valid Payment 
        If Result = 0 And CLng(.MerchantID) = 0 Then
            Result = -4 
        Else
            ' Payment Status should be none(0), pending(2) or partial(4)
            s = CLng(.Status)
            If Result = 0 And s <> 0 And s <> 2 And s <> 4 Then Result = -5 

            ' Payment Type should be > 2 (cryptocurrency)
            If Result = 0 And CLng(.PayType) <= 2 Then Result = -6

            ' PayCoins should be > 0
            If Result = 0 And CCUR(.PayCoins) <= 0 Then Result = -7

            ' PayRate should be > 0
            If Result = 0 And CCUR(.PayRate) <= 0 Then Result = -8

            ' Reference should contain Coin address
            If Result = 0 And .Reference = "" Then Result = -9

            If Result = 0 Then
                ' check for valid key passed in for processing
                key = Payment2ID + CLng(.MerchantID) + CLng(.ConsumerID)
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
            PayCoins = .PayCoins

            ' Check if no payment was found
            If PaidCoins = 0 Then Result = -20

            If LogMode Then LogFile "CP2", CSTR(Payment2ID) + " Pay: " & CSTR(PayCoins) & " Paid: " & CSTR(PaidCoins) 

            If Result = 0 Then
               ' Check for a partial payment
                If CDBL(PaidCoins) < CDBL(PayCoins) Then
                    .Status = 4 ' partial payment
                    If TestMode Then Response.write "Pay: " + CSTR(PayCoins) & "<BR>" + "Paid: " + CSTR(PaidCoins) & "<BR>"  
                    Result = PayCoins - PaidCoins
                Else
                    If .Status = 4 Then
                        .Status = 3 ' approved
                        If TestMode Then Response.write "Partial Payment Pay: " + CSTR(PayCoins) & "<BR>" + "Paid: " + CSTR(PaidCoins) & "<BR>"  
                    End If
                End If
                .PaidCoins = PaidCoins
                If Not TestMode Then .Save 1
            End If

            If Result = 0 Then

                '***** SEND COINS TO MERCHANT *****
                ' Check if the coins have already been sent
                If .CoinStatus <> 1 Then 
                    Result = -12
                Else
                    ' Calculate coins to send to merchant
                    MerchantAmount = CCUR(.Merchant)
                    PayRate = CCUR(.PayRate)
                    MerchantCoins = Round( MerchantAmount / PayRate, 8 )

                    ' Get Merchant Coin Address
                    MerchantID = .MerchantID
                    With oCoinAddress
                        .FetchMerchantCoin MerchantID, Coin_Type
                        MerchantCoinAddress = .Address
                    End With

                    ' Check if we got a coin address
                    If MerchantCoinAddress = "" Then
                        Result = -13
                    Else
                        If Not TestMode Then
                            MerchantCoins = toSatoshi(MerchantCoins)
'Changed to bulk transfer to merchants because of transaction fees
'                            SendResult = CoinSend( Coin_Type, MerchantCoinAddress, MerchantCoins, tmpMsg)
'                            If LogMode Then LogFile "CP2", CSTR(Payment2ID) + " Send: " & CSTR(MerchantCoins) & " To: " & CSTR(MerchantCoinAddress) & " Result: " & 'SendResult & " " & tmpMsg
'                            If SendResult = "OK" Then
'                                .CoinStatus = 2
'                            Else
'                                Result = -14
'                            End If
                            tmpMsg = CSTR(MerchantCoins) + " " + CSTR(Now()) + " " + tmpMsg
                            .Notes = Left( MerchantCoinAddress + " " + tmpMsg, 500 )
                            .Save 1
                        End If
                    End If

                End If

                '***** LAST: CREATE REWARDS AND BONUSES *****
                If Not TestMode Then
                    ' Create rewards and approve the payment
                    Rewards = oReward.PaymentRewards( Payment2ID )
                End If

            End If

        End If

    End With

End If

Set oCoinAddress = Nothing
Set oReward = Nothing
Set oPayment2 = Nothing

response.write Result

%>