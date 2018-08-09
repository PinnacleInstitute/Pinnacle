'*****************************************************************************
' Market Shopper Emails
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 1

On Error Resume Next
Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
If  Test = 1 And oHTMLFile Is Nothing Then MsgBox("Unable to Create Object - HTMLFile")

Set oMail = CreateObject("CDO.Message")
If  Test = 1 And oMail Is Nothing Then MsgBox("Unable to Create Object - Mail")

Set oMarkets = CreateObject("ptsMarketUser.CMarkets")
If  Test = 1 And oMarkets Is Nothing Then MsgBox("Unable to Create Object - Markets")

Set oMerchants = CreateObject("ptsMerchantUser.CMerchants")
If  Test = 1 And oMerchants Is Nothing Then MsgBox("Unable to Create Object - Merchants")

Set oConsumers = CreateObject("ptsConsumerUser.CConsumers")
If  Test = 1 And oConsumers Is Nothing Then MsgBox("Unable to Create Object - Consumers")

If Test = 1 Then MsgBox("Start: " + Err.description)

CompanyID = 21
Today = Date()
oMail.Sender = "support@NexxusRewards.com"
oMail.From = "support@NexxusRewards.com"

'Get all the active markets ready to send
oMarkets.ListMarket CompanyID, Today

For Each oMarket in oMarkets
    With oMarket
        tmpMarketID = .MarketID
        tmpCountryID = .CountryID
        tmpMarketName = .MarketName
        tmpFromEmail = .FromEmail
        tmpSubject = .Subject
        tmpTarget = .Target
    End With
        
    If Test = 1 Then MsgBox("Market: " & tmpMarketName )

'   Get the email message for this Market
    With oHTMLFile
        .Filename = tmpMarketID & ".htm"
        .Path = SysPath + "Sections/Company/21/Market/"
        .Language = "en"
        .Project = "PTS"
        .Load 
        tmpBody = .Data
    End With

    GetMerchants tmpTarget, tmpCountryID, tmpFeatured, tmpNew, tmpMerchants, tmpOrgs, tmpMerchantCnt, tmpOrgCnt
    tmpBody = Replace( tmpBody, "{featured-merchants}", tmpFeatured )
    tmpBody = Replace( tmpBody, "{new-merchants}", tmpNew )
    tmpBody = Replace( tmpBody, "{orgs}", tmpOrgs )
    tmpBody = Replace( tmpBody, "{merchants}", tmpMerchants )
    tmpMasterSubject = tmpSubject
    tmpMasterBody = tmpBody

    oConsumers.ListMarketEmail CompanyID, tmpTarget, tmpCountryID
    tmpConsumerCnt = 0
    For Each oConsumer in oConsumers
        With oConsumer
            tmpConsumerCnt = tmpConsumerCnt + 1
            tmpTo = .Email
            If InStr( tmpTo, "@" ) > 0 Then
                tmpSubject = Replace( tmpMasterSubject, "{firstname}", .NameFirst )
                tmpSubject = Replace( tmpSubject, "{lastname}", .NameLast )
                tmpBody = Replace( tmpMasterBody, "{firstname}", .NameFirst )
                tmpBody = Replace( tmpBody, "{lastname}", .NameLast )
                tmpBody = Replace( tmpBody, "{id}", .ConsumerID )
                tmpBody = Replace( tmpBody, "{email}", tmpTo )
                tmpBody = Replace( tmpBody, "{memberid}", .MemberID )

                If Test > 0 Then MsgBox("Subject: " & tmpSubject)
                If Test > 0 Then MsgBox("Message: " & tmpBody)

                With oMail
                    .To = tmpTo
                    .Subject = tmpSubject
                    .HTMLBody = tmpBody
                    If Test = 0 Then .Send
                End With
                If Test = 0 Then LogFile "Market", CStr(tmpMarketID) + "-" + tmpTo
            End If
        End With
    Next
    If Test = 0 Then
        With oMarket
            .Load tmpMarketID, 1
            .Consumers = tmpConsumerCnt
            .Merchants = tmpMerchantCnt
            .Orgs = tmpOrgCnt
			.SendDate = DateAdd("d", .SendDays, .SendDate)
            .Save 1
        End With
    End If
Next

If Test = 1 Then MsgBox("End: " + Err.description)

Set oConsumers = Nothing
Set oMerchants = Nothing
Set oMarkets = Nothing
Set oMail = Nothing
Set oHTMLFile = Nothing

'*****************************************************************************
Function LogFile(ByVal bvFilename, ByVal bvLine)
    On Error Resume Next
    Set oFSO = CreateObject("Scripting.FileSystemObject")
    'Open the text file for appending
    FilePath = SysPath + "Log\"
    Set oTextStream = oFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
    'write the line to the file 
    oTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + bvLine
    'Close the file and clean up
    oTextStream.Close
    Set oTextStream = Nothing
    Set oFSO = Nothing
End Function

'*****************************************************************************************************
Function GetMerchants(byVal bvTarget, byVal bvCountryID, byRef brFeatured, byRef brNew, byRef brMerchants, byRef brOrgs , byRef brMerchantCnt, byRef brOrgCnt )
On Error Resume Next
    
Set oMerchants = CreateObject("ptsMerchantUser.CMerchants")
With oMerchants
    .ListMarket bvTarget, bvCountryID
    brFeatured = ""
    brNew = ""
    brMerchants = ""
    brOrgs = ""
    brMerchantCnt = 0
    brOrgCnt = 0
    For Each oItem in oMerchants
    With oItem
        'If this is a merchant and not an organization
        If .IsOrg = "0" Then
            brMerchantCnt = brMerchantCnt + 1
            'Build Merchant HTML
            tmpReward = .RewardAmt + "% " + .RewardDesc
            If .RewardCap <> "0" Then tmpReward = tmpReward + " (max " + .RewardCap + ")"
            tmpReward = "<font color=""blue"">" + tmpReward + "</font>"
            tmpDescription = StripHTML( .Description )
            tmpAddress = .Street1 + " " + .Street2 + " " + .City + " " + .State + " " + .Zip
            tmpMap = ""
            If InStr( .StoreOptions, "H" ) > 0 Then	
            tmpMap = "<A href=""http://maps.google.com/?q=" + tmpAddress + """ target=""_blank""><IMG src=""http://www.nexxusrewards.com/images/GoogleMaps.png"" align=""absmiddle""></A>"	
            End If

            tmpMerchant = "<b>" + .MerchantName + "</b> - " + tmpReward + " - " + tmpDescription + " - " + tmpAddress + " " + tmpMap + " - " + .Phone + " " + .Email + "<BR>"
    
            'If this is a featured merchant
            If InStr( .Options, "F" ) > 0 Then
                brFeatured = brFeatured + "<img src=""http://www.nexxusrewards.com/images/star_full.gif"" alt=""Featured"" align=""absmiddle"">" + "&nbsp;" + tmpMerchant
            Else
                'If this is a new merchant within the last 30 days
                If DateDiff( "d", .EnrollDate, reqSysDate) <= 30 Then
                    brNew = brNew + "<img src=""http://www.nexxusrewards.com/images/new2.gif"" alt=""NEW"" align=""absmiddle"">" + "&nbsp;" + tmpMerchant
                Else
                    brMerchants = brMerchants + tmpMerchant
                End If
            End If
        Else
            brOrgCnt = brOrgCnt + 1
            brOrgs = brOrgs + "<b>" + .MerchantName + "</b>"
        End If
    End With
    Next
End With
End Function

'*****************************************************************************************************
Function StripHTML( ByVal bvHTML )
    bvHTML = join(filter(split(replace(bvHTML, "<", "><"),">"),"<", false))
    bvHTML = replace(bvHTML,"&nbsp;"," ")
    StripHTML = bvHTML
End Function
