<%
' Requires Coins.asp
' Requires Comm.asp
' Requires IP.asp
'*****************************************************************************************************
FUNCTION GetCryptoStatus( ByRef brCryptoStatus )
   On Error Resume Next
   test = CoinTest(1)
   If (test = "OK") Then
      brCryptoStatus = "OK"
   End If
   If (test <> "OK") Then
      brCryptoStatus = "Bitcoin processing is currently unavailable!"
   End If
End Function

'*****************************************************************************************************
Function ParseRewardResult(byVal bvResult, byRef brReward, byRef brAward, byRef brRedeem, byRef brTotalReward, byRef brTotalAward, byRef brEmail, byRef brName, byRef brMsg  )
    On Error Resume Next
    brReward = 0
    brAward = 0
    brRedeem = 0
    brTotalReward = 0
    brTotalAward = 0
    brName = ""
    brEmail = ""
    tmpMerchantName = ""
    a = Split( bvResult, "|")
    If UBOUND(a) = 7 Then
        brReward = a(0)
        brAward = a(1)
        brRedeem = a(2)
        brTotalReward = a(3)
        brTotalAward = a(4)
        brName = a(5)
        brEmail = a(6)
        tmpMerchantName = a(7)
        brMsg = CStr(reqReward) + " Cashback Reward Points (" + CStr(reqTotalReward) + " total) "
        If reqAward > 0 Then brMsg = brMsg + CStr(reqAward) + " Special Award Points (" + CStr(reqTotalAward) + " total) "
        If reqRedeem > 0 Then brMsg = brMsg + CStr(reqRedeem) + " Redeemed Reward Points "
        If tmpMerchantName <> "" Then brMsg = brMsg + "from " + tmpMerchantName
    End If
End Function

'*****************************************************************************************************
Function SendRewardEmail(byVal bvCompanyID, byVal bvEmail, byVal bvSubject, byVal bvBody)
    On Error Resume Next
    If (bvEmail <> "") Then
        Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
        If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
        Else
            With oCompany
                .Load bvCompanyID, 1
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                tmpSender = .Email3
                tmpFrom = .Email3
            End With
        End If
        Set oCompany = Nothing
        tmpTo = bvEmail
      
        If InStr(tmpTo, "@") > 0 Then
            If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
            tmpSubject = bvSubject
            tmpBody = bvBody
            SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
        End If
    End If
End Function

'*****************************************************************************************************
Function GetMerchant(byVal bvMerchantID, byVal bvOrderType, byRef brMerchantName, byRef brTerms, byRef brCurrencyCode, byRef brIsAwards, byRef brIsPin, byRef brIsTicket, byRef brIsApprove, byRef brIsShopperOrder, byRef brAcceptedCoins, byRef brPendingOrders, byRef brIsDemo)
    On Error Resume Next

    Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
    If oMerchant Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
    Else
        With oMerchant
            .Load CLng(bvMerchantID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If .Status = 6 Then brIsDemo = 1
            brMerchantName = .MerchantName
            brTerms = .Terms
            brCurrencyCode = .CurrencyCode
            brIsAwards = .IsAwards
            If (InStr(.Options, "A") <> 0) Then brIsPin = 1
            If (InStr(.Options, "B") <> 0) Then brIsTicket = 1
            If (InStr(.Options, "D") <> 0) Then brIsApprove = 1
            If (InStr(.Options, "E") <> 0) Then brIsShopperOrder = 1
            If (bvOrderType = 0) Then 
                brAcceptedCoins = .Custom(CLng(bvMerchantID), 1, 0, 0, 0, "")
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If brPendingOrders = 0 Then        
                brPendingOrders = CLng(.Custom(CLng(bvMerchantID), 2, 0, 0, 0, ""))
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
        End With
    End If
    Set oMerchant = Nothing
End Function

'*****************************************************************************************************
Function GetShopper( byVal bvMerchantID, byVal bvLogonConsumer, byVal bvOrderType, byVal bvCurrencyCode, byRef brConsumerID, byRef brConsumerName, byRef brBTC, byRef brCoinPrice, byRef brRewardPoints, byRef brNXC, byRef brRewardValueRaw, byRef brRewardValue, byRef brPayType, byVal bvIsDemo )
    On Error Resume Next
    brConsumerName = ""
    If (bvLogonConsumer = "") Then DoError 10134, "", "Oops, The Phone Number could not be found."

    If (bvLogonConsumer <> "") Then
        Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
        If oConsumer Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
        Else
            With oConsumer
                Result = CLng(.Logon2(bvLogonConsumer))
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                If (Result > 0) Then
                    If bvIsDemo = 0 Then
                        brConsumerID = Result
                    Else
                        brConsumerID = 1 'DEMO: Jill Jones
                    End If
                    .Load CLng(brConsumerID), 1
                    If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                    brConsumerName = .NameFirst + " " + .NameLast
                End If
                If (Result = -1000002) Then DoError 10129, "", "Oops, The Email could not be found."
                If (Result = -1000003) Then DoError 10134, "", "Oops, The Phone Number could not be found."
                If (Result = -1000005) Then DoError 10156, "", "Oops, The Shopper Account is Inactive."
            End With
        End If
        Set oConsumer = Nothing
    End If

    If (xmlError = "") Then
        If (bvOrderType = 0) Then
            brBTC = FormatCurrency(CoinPrice(1,bvCurrencyCode))
            brCoinPrice = brBTC
        End If
        If (bvOrderType = 2) Then
            Set oReward = server.CreateObject("ptsRewardUser.CReward")
            If oReward Is Nothing Then
                DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CReward"
            Else
                With oReward
                    brRewardPoints = CCur(.TotalReward(CLng(brConsumerID), 0))
                    If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                End With
            End If
            Set oReward = Nothing
            price = CoinPrice(2,"USD")
            brNXC = FormatCurrency(price)
            brRewardValueRaw = brRewardPoints * price
            brRewardValue = FormatCurrency(brRewardValueRaw)
            brPayType = 1
        End If

        If (bvOrderType = 3) Then
            Set oReward = server.CreateObject("ptsRewardUser.CReward")
            If oReward Is Nothing Then
                DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CReward"
            Else
                With oReward
                    brRewardPoints = CCur(.TotalReward(CLng(brConsumerID), CLng(bvMerchantID)))
                    If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                End With
            End If
            Set oReward = Nothing
        End If
    End If
End Function

'*****************************************************************************************************
Function ValidOrder( byVal bvOrderType, byVal bvIsTicket, byVal bvTicketNumber, byRef brTotalAmount, byRef brNetAmount )
    On Error Resume Next
    If (bvOrderType = 1) Then
        If (bvIsTicket <> 0) And (bvTicketNumber = "") Then DoError 10147, "", "Oops, Please enter a sales Ticket Number."
    End If
    If (xmlError = "") And (bvOrderType <> 3) Then
        If (brTotalAmount = "") Then brTotalAmount = 0
        If (brNetAmount = "") Then brNetAmount = 0
        If (CCUR(brTotalAmount) <= 0) Or (CCUR(brNetAmount) <= 0) Then
            DoError 10148, "", "Oops, Please enter a positive value for the total and net amounts."
        End If
    End If
End Function

'*****************************************************************************************************
Function ValidRedeem( byVal bvConsumerID, byVal bvRedeemPswd, byVal bvRewardValueRaw, byRef brTotalAmount, byRef brNetAmount )
    On Error Resume Next
    If (xmlError = "") Then
        If (brTotalAmount = "") Then brTotalAmount = 0
        If (brNetAmount = "") Then brNetAmount = 0
        If (CCUR(brTotalAmount) <= 0) Or (CCUR(bvRewardValueRaw) < CCUR(brTotalAmount)) Then
            DoError 10145, "", "Oops, The reward points value is less than the total amount."
        End If
    End If
    If (xmlError = "") And (bvRedeemPswd = "") Then DoError 10143, "", "Oops, Please enter the Shopper Password to redeem points."

    If (xmlError = "") Then
        Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
        If oConsumer Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
        Else
            With oConsumer
                .Load CLng(bvConsumerID), 1
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                If (reqRedeemPswd <> .Password) Then DoError 10144, "", "Oops, The Shopper Password is Invalid."
            End With
        End If
        Set oConsumer = Nothing
    End If
End Function

'*****************************************************************************************************
Function ValidAward( byVal bvConsumerID, byVal bvRedeemPswd)
    On Error Resume Next
    If (xmlError = "") And (bvRedeemPswd = "") Then DoError 10143, "", "Oops, Please enter the Shopper Password to redeem points."

    If (xmlError = "") Then
        Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
        If oConsumer Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
        Else
            With oConsumer
                .Load CLng(bvConsumerID), 1
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                If (bvRedeemPswd <> .Password) Then DoError 10144, "", "Oops, The Shopper Password is Invalid."
            End With
        End If
        Set oConsumer = Nothing
    End If
End Function

'*****************************************************************************************************
Function ValidPin( byVal bvMerchantID, byVal bvPinNumber, byRef brStaffID, byRef brStaffName )
    On Error Resume Next
    Set oStaff = server.CreateObject("ptsStaffUser.CStaff")
    If oStaff Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsStaffUser.CStaff"
    Else
        With oStaff
            Result = .ValidStaff(CLng(bvMerchantID), bvPinNumber, 0)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            a = Split( Result, "|")
            brStaffID = CLng( a(0) )
            tmpAccess = a(1)
          
            If (brStaffID = 0) Then DoError 10142, "", "Oops, Invalid PIN Code."
            If (tmpAccess <> "") Then
                tmpAccess = LimitedAccess( tmpAccess )
                If (tmpAccess <> 1) Then DoError -2147220514, "", "Oops, Your access to the system has been limited - Access Denied."
            End If
        End With
    End If
    Set oStaff = Nothing

    If (xmlError = "") And (brStaffID <> 0) Then
        Set oStaff = server.CreateObject("ptsStaffUser.CStaff")
        If oStaff Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsStaffUser.CStaff"
        Else
            With oStaff
                .Load brStaffID, 1
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                brStaffName = .StaffName
            End With
        End If
        Set oStaff = Nothing
    End If
End Function

'*****************************************************************************************************
Function NewOrder( byVal bvMerchantID, byVal bvOrderType, byRef brPayDate, byRef brPayType, byRef brxmlAwards)
    On Error Resume Next
    If (brPayDate = "") Then brPayDate = Now
    If (brPayType = 0) Then brPayType = 1

    If (bvOrderType <> 3) Then
        Set oAwards = server.CreateObject("ptsAwardUser.CAwards")
        If oAwards Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAwardUser.CAwards"
        Else
            With oAwards
                brxmlAwards = .EnumMerchant(CLng(bvMerchantID), 1, , , 1)
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
        End If
        Set oAwards = Nothing
    End If

    If (bvOrderType = 3) Then
        Set oAwards = server.CreateObject("ptsAwardUser.CAwards")
        If oAwards Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAwardUser.CAwards"
        Else
            With oAwards
                brxmlAwards = .EnumMerchant(CLng(bvMerchantID), 2, , , 1)
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
        End If
        Set oAwards = Nothing
    End If
End Function

'*****************************************************************************************************
Function AddOrder( byVal bvOrderType, byVal bvMerchantID, byVal bvConsumerID, byVal bvAwardID, byVal bvPayDate, byVal bvStaffID, byVal bvDescription, byVal bvTotalAmount, byVal bvNetAmount, byVal bvTicketNumber, byVal bvPayType, byVal bvCurrencyCode, byRef brCoinType, byRef brQR_Address, byRef brPayment2ID, byRef brCoinToken, byVal bvIsDemo )
    On Error Resume Next

    Set oAward = server.CreateObject("ptsAwardUser.CAward")
    If oAward Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsAwardUser.CAward"
    Else
        With oAward
            .Load CLng(bvAwardID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            AwardAmount = .Amount
            tmpCap = CCUR(.Cap)
            CashbackRate = CCUR(AwardAmount) / 100
            FeeRate = CCUR(AwardAmount) / 100
            If (FeeRate > .05) Then FeeRate = .05
        End With
    End If
    Set oAward = Nothing

    ' get the price of the Nexxus Coin
    NXCprice = CoinPrice( 2, "USD" )

    Set oPayment2 = server.CreateObject("ptsPayment2User.CPayment2")
    If oPayment2 Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayment2User.CPayment2"
    Else
        With oPayment2
            .Load 0, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .PayCoins = 0
            .PaidCoins = 0
            .PayDate = bvPayDate
            .CommStatus = 1
            .MerchantID = bvMerchantID
            .ConsumerID = bvConsumerID
            .StaffID = bvStaffID
            .AwardID = bvAwardID
            .Description = bvDescription
            .Ticket = bvTicketNumber
            ' Calculate Cashback reward 
            Cashback = reqNetAmount * CashbackRate
            ' Calculate marketing fee
            Fee = bvNetAmount * FeeRate

            ' Check if there is a cap on the cashback reward
            If (tmpCap > 0) Then
                ' If the Cashback reward is greater than the cap, Set the Cashback reward to the cap
                If (Cashback > tmpCap) Then Cashback = tmpCap
                ' calculate the fee cap based on the FeeRate to CashbackRate ratio 
                tmpFeeCap = Round(tmpCap * ( FeeRate / CashBackRate ),2)
                ' If the Fee is greater than the Fee cap, Set the Fee to the Fee cap
                If (Fee > tmpFeeCap) Then Fee = tmpFeeCap
            End If

            .Total = bvTotalAmount
            .Amount = bvNetAmount
            .Merchant = bvTotalAmount - (Cashback + Fee)
            .Cashback = Cashback
            .Fee = Fee
            
            ' Cash Order
            If (bvOrderType = 1) Then
                ' This cash payment is submitted to be invoiced to merchant
                .Status = 1
                .PayType = 1
            End If

            ' Crypto Order
            If (bvOrderType = 0) Then
                ' This crypto payment is submitted waiting for receipt of coins 
                .Status = 0
                .PayType = bvPayType
                brCoinType = bvPayType - 2
                Price = CoinPrice( brCoinType, bvCurrencyCode )
                .PayCoins =  Round( bvTotalAmount / Price, 8)
                .PayRate = Price
                If bvIsDemo = 0 Then
                    NewAddress =  CoinAddress(brCoinType, CSTR(bvConsumerID) )
                Else
                    NewAddress =  "1-DEMO-ONLY-COIN-ADDRESS"
                End If
                .Reference = NewAddress
                brQR_Address = NewAddress
                .CoinStatus = 1
            End If

            ' Redeem Order
            If (bvOrderType = 2) Then
                ' Automatically approve this payment
                .Status = 3
                .PayType = 2
                .PayCoins = Round(bvTotalAmount / NXCprice, 8)
                .PayRate = NXCprice
            End If

            .PayCoins = toSatoshi(.PayCoins)

            'Log IP Info if PaymentID = -1  
            If brPayment2ID = -1 Then
                IP = Request.ServerVariables("REMOTE_ADDR")
                tmpLocation = GetIPCity( IP )
                .Notes = Left( IP + " " + tmpLocation, 500)
            End If

            brPayment2ID = CLng(.Add(1))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (bvOrderType = 0) Then
                ' Create a Coin Token for the crypto payment processing
                key = brPayment2ID + CLng(.MerchantID) + CLng(.ConsumerID)
                brCoinToken = CoinToken( brCoinType, NewAddress, key)
            End If
        End With
    End If
    Set oPayment2 = Nothing
End Function

'*****************************************************************************************************
Function ProcessOrder(byVal bvCompanyID, byVal bvPayment2ID, byRef brReward, byRef brAward, byRef brRedeem, byRef brTotalReward, byRef brTotalAward )
    On Error Resume Next
    Set oReward = server.CreateObject("ptsRewardUser.CReward")
    If oReward Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CReward"
    Else
        With oReward
            Result = .PaymentRewards(CLng(bvPayment2ID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        End With
    End If
    Set oReward = Nothing

    ParseRewardResult Result, brReward, brAward, brRedeem, brTotalReward, brTotalAward, email, name, msg
    If (email <> "") Then SendRewardEmail bvCompanyID, email, "New Reward Points for " + name, msg
End Function

'*****************************************************************************************************
Function AddAward( byVal bvMerchantID, byVal bvConsumerID, byVal bvPayDate, byVal bvAwardID, byVal bvRewardPoints, byRef brAward )
    On Error Resume Next
    Set oAward = server.CreateObject("ptsAwardUser.CAward")
    If oAward Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsAwardUser.CAward"
    Else
        With oAward
            .Load CLng(bvAwardID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            brAward = .Amount
        End With
    End If
    Set oAward = Nothing
    If (brAward > bvRewardPoints) Then DoError 10146, "", "Oops, Not enough special award points for the selected award."

    If (xmlError = "") Then
        Set oReward = server.CreateObject("ptsRewardUser.CReward")
        If oReward Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CReward"
        Else
            With oReward
                .Load 0, 1
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                .RewardDate = bvPayDate
                .MerchantID = bvMerchantID
                .ConsumerID = bvConsumerID
                .AwardID = bvAwardID
                .Status = 3
                .RewardType = 2
                .Amount = toSatoshi(brAward * -1)
                RewardID = CLng(.Add(1))
                If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
        End If
        Set oReward = Nothing
    End If
End Function

'*****************************************************************************************************
Function ApproveOrder(byVal bvPayment2ID)
    On Error Resume Next
    Set oPayment2 = server.CreateObject("ptsPayment2User.CPayment2")
    If oPayment2 Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayment2User.CPayment2"
    Else
        With oPayment2
            .Custom 1, bvPayment2ID, 0, 0, 0, ""
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        End With
    End If
    Set oPayment2 = Nothing
End Function

%>