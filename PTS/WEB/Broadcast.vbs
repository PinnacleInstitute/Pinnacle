'*****************************************************************************
' Member Broadcast Emails to Friends
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 1
' EmailBroadcastID = 0 ... Get All
' EmailBroadcastID = 1 ... Only Get Broadcast #1 
PUBLIC CONST EmailBroadcastID = 1

On Error Resume Next

Set oMail = CreateObject("CDO.Message")
If  Test = 1 And oMail Is Nothing Then MsgBox("Unable to Create Object - Mail")

'With oMail.Configuration.Fields
'    .Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 '1 'Send the message using the network (SMTP over the network).
'    .Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "10.10.10.10" ' this is your smtp server usually something like smtp.somedomain.com
'    .Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 '25 is the standard smtp port but check with your host to be sure
'    .Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
'    .Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
'    .Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'Can be 0 for No Authentication, 1 for basic authentication or 2 for NTLM (check with your host)
'    .Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "info" 'The username log in credentials for the email account sending this email, not needed if authentication is set to 0
'    .Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "web123dev" 'The password log in credentials for the email account sending this email, not needed if authentication is set to 0
'    .Update
'End With

Set oBroadcasts = CreateObject("ptsBroadcastUser.CBroadcasts")
If  Test = 1 And oBroadcasts Is Nothing Then MsgBox("Unable to Create Object - Broadcasts")

Set oMember = CreateObject("ptsMemberUser.CMember")
If  Test = 1 And oMember Is Nothing Then MsgBox("Unable to Create Object - Member")

Set oNewss = CreateObject("ptsBroadcastUser.CBroadcasts")
If  Test = 1 And oNewss Is Nothing Then MsgBox("Unable to Create Object - Broadcast Newss")

Set oFriends = CreateObject("ptsBroadcastUser.CBroadcasts")
If  Test = 1 And oFriends Is Nothing Then MsgBox("Unable to Create Object - Broadcast Friends")

Set oAds = CreateObject("ptsAdUser.CAds")
If  Test = 1 And oAds Is Nothing Then MsgBox("Unable to Create Object - Ads")

Set oStyle = CreateObject("MSXML2.FreeThreadedDOMDocument")
Set oData = CreateObject("MSXML2.FreeThreadedDOMDocument")

CompanyID = 12

If Test = 1 Then MsgBox("Start: " + Err.description)

Broadcasts = 1
While Broadcasts > 0 
    'Get Broadcasts to process
    oBroadcasts.ListEmail EmailBroadcastID

    'Process each Broadcast
    Broadcasts = 0
    Friends = 0
    Stories = 0
    For Each oBroadcast in oBroadcasts
        If Test = 0 Then Broadcasts = Broadcasts + 1
        With oBroadcast
            BroadcastID = .BroadcastID
            MemberID = .MemberID
            FriendGroupID = .FriendGroupID
            Stories = .Stories
        End With
        
        If Test = 1 Then MsgBox("Broadcast: " & BroadcastID & " - Member: " & MemberID & " - FriendGroup: " & FriendGroupID )

        'Get Member name and email address  
        Member = ""
        MemberEmail = ""      
        With oMember
            .Load MemberID, 1
            MemberEmail = .Email
            If (.IsCompany = 0) Then
                Member = .NameFirst + " " + .NameLast
            Else
                Member = .CompanyName
            End If
            If InStr(MemberEmail, CHR(34)) = 0 Then MemberEmail = CHR(34) + Member + CHR(34) + " <" + MemberEmail + ">"
        End With
        
        If Test = 1 Then MsgBox("Member: " & Member & " - MemberEmail: " & MemberEmail )

        'Get the news stories for this broadcast
        Headline = ""
        With oNewss
            .ListNews BroadcastID
            'Get the first headline for the Email Subject
            For Each oNews in oNewss
                Headline = oNews.Title
                Exit For
            Next
        End With

        'Get the friends for this broadcast
        oFriends.ListFriends MemberID, FriendGroupID

        'Email each Friend
        Friends = 0
        For Each oFriend in oFriends
            Friends = Friends + 1
            With oFriend
                FriendID = .BroadcastID
                NameFirst = .NameFirst
                NameLast = .NameLast
                FriendEmail = .Email
            End With
    
            If Test = 1 Then MsgBox("Friend: " & NameFirst + " " + NameLast & " - FriendEmail: " & FriendEmail )

            'Get the Ads for this Friend
            tmpAds = 0
            With oAds
                .ListAds CompanyID, 4, Stories, 141, FriendID
                tmpAds = .Count(1)
            End With

            'Build News Stories and Ads together
            '**************************************************************************
			xmlBroadcasts = "<PTSBROADCASTS>"
			x = 1
			For Each oItem in oNewss
				With oItem
					xmlBroadcasts = xmlBroadcasts + "<PTSBROADCAST broadcastid=""" + .BroadcastID + """ title=""" + CleanXML(.Title) + """ image=""" + .Image + """><SUMMARY><!-- " + Replace(.Summary, "--", "- ") + " --></SUMMARY></PTSBROADCAST>"
				End With
				If x <= tmpAds Then
					With oAds.Item(x,"",1)
						xmlBroadcasts = xmlBroadcasts + "<PTSBROADCAST title=""" + "" + """><SUMMARY><!-- " + Replace(.Msg, "--", "- ") + " --></SUMMARY></PTSBROADCAST>"
					End With
					x = x + 1
				End If
			Next
			xmlBroadcasts = xmlBroadcasts + "</PTSBROADCASTS>"

            'Build the Page
            '**************************************************************************
            tmpBody = ""
            xmlParam = "<PARAM"
            xmlParam = xmlParam + " member=" + Chr(34) + CleanXML(Member) + Chr(34)
            xmlParam = xmlParam + " friend=" + Chr(34) + CStr(FriendID) + Chr(34)
            xmlParam = xmlParam + " />"

            '-----get the transaction XML
            xmlTransaction = "<TXN>"
            xmlTransaction = xmlTransaction + xmlBroadcasts
            xmlTransaction = xmlTransaction + "</TXN>"

            '-----get the data XML
            xmlData = "<DATA>"
            xmlData = xmlData +  xmlTransaction
            xmlData = xmlData +  xmlParam
            xmlData = xmlData + "</DATA>"

            '-----create a DOM object for the XSL
            oStyle.load "C:\PTS\WEB\14400.xsl"
            If Test > 0 And oStyle.parseError <> 0 Then MsgBox("14400 Load file (oStyle) failed with error code " + CStr(oStyle.parseError) )
            
            '-----create a DOM object for the XML
            oData.loadXML xmlData
            If Test > 0 And oStyle.parseError <> 0 Then MsgBox("14400 Load file (oData) failed with error code " + CStr(oData.parseError) )

            '-----transform the XML with the XSL
            tmpBody = oData.transformNode(oStyle)
            '**************************************************************************

            'Send the Email
            tmpSubject = Headline

            If Test > 0 Then MsgBox("Subject: " & tmpSubject)
            'If Test > 0 Then MsgBox("Message: " & tmpBody)

            With oMail
                .Sender = MemberEmail
                .From = MemberEmail
                .To = FriendEmail
                .Subject = tmpSubject
                .HTMLBody = tmpBody
                If Test = 0 Then .Send
            End With
        Next
        oBroadcast.SetFriends BroadcastID, Friends
    Next
Wend 

If Test = 1 Then MsgBox("End: " + Err.description)

Set oData = Nothing
Set oStyle = Nothing
Set oAds = Nothing
Set oFriends = Nothing
Set oNewss = Nothing
Set oMember = Nothing
Set oBroadcasts = Nothing
Set oMail = Nothing

Function CleanXML(ByVal bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanXML = Replace(bvValue, Chr(62), "&gt;")
End Function
