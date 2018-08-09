'*****************************************************************************
' Drip Email Campaigns
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 0

On Error Resume Next

Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
If  Test = 1 And oHTMLFile Is Nothing Then MsgBox("Unable to Create Object - HTMLFile")

'Set oEmailees = CreateObject("ptsEmaileeUser.CEmailees")
'If  Test = 1 And oEmailees Is Nothing Then MsgBox("Unable to Create Object - Emailees")

Set oMail = CreateObject("CDO.Message")
If  Test = 1 And oMail Is Nothing Then MsgBox("Unable to Create Object - Mail")

Set oConf = CreateObject("CDO.Configuration")
If  Test = 1 And oConf Is Nothing Then MsgBox("Unable to Create Object - Configuration")

Set oDripCampaigns = CreateObject("ptsDripCampaignUser.CDripCampaigns")
If  Test = 1 And oDripCampaigns Is Nothing Then MsgBox("Unable to Create Object - DripCampaigns")

Set oDripPages = CreateObject("ptsDripPageUser.CDripPages")
If  Test = 1 And oDripPages Is Nothing Then MsgBox("Unable to Create Object - DripPages")

Set oFolderItems = CreateObject("ptsFolderItemUser.CFolderItems")
If  Test = 1 And oFolderItems Is Nothing Then MsgBox("Unable to Create Object - FolderItems")

Set oCompany = CreateObject("ptsCompanyUser.CCompany")
If  Test = 1 And oCompany Is Nothing Then MsgBox("Unable to Create Object - Company")

DripCampaignID = 0
CompanyID = 0

If Test = 1 Then MsgBox("Start: " + Err.description)

'Get all the active drip campaigns
With oDripCampaigns
    .ListActive 1

    For Each oDripCampaign in oDripCampaigns
        With oDripCampaign
            DripCampaignID = .DripCampaignID
            tmpCompanyID = .CompanyID
            Target = .Target
        End With
        
        If Test = 1 Then MsgBox("Company: " & tmpCompanyID & " - Campaign: " & DripCampaignID & " - Target: " & Target )

'       Get company email to send message from
        If CompanyID <> tmpCompanyID Then
            CompanyID = tmpCompanyID
'           Create a new Mail Object for each company 
            Set oMail = Nothing
            Set oMail = CreateObject("CDO.Message")
            UserName = ""
            Password = ""
            If bvCompanyID = 7 Or bvCompanyID = 17 Then
                UserName = "AKIAIDJQZSMHCB33I5ZA"
                Password = "AnFRonILBv2qpAiaSbPYaai3fE3WLH+pqAjxr3hWrQl+"
            End If
            If UserName <> "" Then
                With oMail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'cdoSendUsingPort
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "email-smtp.us-east-1.amazonaws.com"
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic 
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = UserName
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = Password
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Update
                End With
            End If
            With oCompany
                .Load CLng(CompanyID), 1
                oMail.Sender = .Email
                oMail.From = .Email
                If Test = 1 Then MsgBox("New Company Email: " + .Email)
            End With
        End If

'       Get all the pages for each active drip campaign
        With oDripPages
            .ListActive DripCampaignID

        	For Each oDripPage in oDripPages
                With oDripPage
                    DripPageID = .DripPageID
                    Subject = .Subject
                    Days = .Days
'                    CC = .IsCC
                End With

                If Test = 1 Then MsgBox("Page: " & Subject + " - Days: " & Days)

'               Get the email message for this page
                With oHTMLFile
                    .Filename = "Drip" + CSTR(DripPageID) + ".htm"
                    .Path = SysPath + "Drip\"
                    .Language = "en"
                    .Project = "Pinnacle"
                    .Load 
                    Body = .Data
                End With

'               Get all the folder items for this page on this day
                With oFolderItems
                    .ListDrip DripCampaignID, Target, Days

                    For Each oFolderItem in oFolderItems
                        With oFolderItem
                            FolderItemID = .FolderItemID
                            ItemID = .ItemID
                            Data = Split(.Data, "|")
                            FirstName = Data(0)
                            LastName = Data(1)
                            Email = Data(2)
                            rID = Data(3)
                            rFirstName = Data(4)
                            rLastName = Data(5)
                            rEmail = Data(6)
                            rPhone = Data(7)
                            rSignature = Data(8)
                            rUsername = Data(9)

                            If Test = 1 Then MsgBox("Target: " & FirstName + " " + LastName)

                            tmpTo = ""
                            tmpCC = ""
                            tmpSubject = ""
                            tmpBody = ""
                            tmpTo = Email
                            'If Len(CC) > 0 Then tmpCC = CC

                            tmpSubject = Replace( Subject, "{firstname}", FirstName )
                            tmpSubject = Replace( tmpSubject, "{lastname}", LastName )

                            tmpBody = Replace( Body, "{id}", ItemID )
                            tmpBody = Replace( tmpBody, "{item}", FolderItemID )
                            tmpBody = Replace( tmpBody, "{firstname}", FirstName )
                            tmpBody = Replace( tmpBody, "{lastname}", LastName )
                            tmpBody = Replace( tmpBody, "{email}", Email )
                            tmpBody = Replace( tmpBody, "{m-id}", rID )
                            tmpBody = Replace( tmpBody, "{m-firstname}", rFirstName )
                            tmpBody = Replace( tmpBody, "{m-lastname}", rLastName )
                            tmpBody = Replace( tmpBody, "{m-email}", rEmail )
                            tmpBody = Replace( tmpBody, "{m-phone}", rPhone )
                            tmpBody = Replace( tmpBody, "{signature}", rSignature )
                            tmpBody = Replace( tmpBody, "{username}", rUsername )

                            If Test > 0 Then MsgBox("Subject: " & tmpSubject)
                            If Test > 0 Then MsgBox("Message: " & tmpBody)

                            With oMail
                                .To = tmpTo
'                                .CC = tmpCC
                                .Subject = tmpSubject
                                .HTMLBody = tmpBody
                                If Test = 0 Then .Send
                            End With
                            If Test = 0 Then LogFile "DripCampaign-" + CStr(DripCampaignID), tmpTo + " - " + CStr(Days)
                        End With
                    Next
                End With
            Next
        End With
    Next
End With

If Test = 1 Then MsgBox("End" + Err.description)

Set oCompany = Nothing
Set oFolderItems = Nothing
Set oDripPages = Nothing
Set oDripCampaigns = Nothing
Set oConf = Nothing
Set oMail = Nothing
'Set oEmailees = Nothing
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
