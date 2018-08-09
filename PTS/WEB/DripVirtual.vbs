'*****************************************************************************
' Drip Email Campaigns for Virtual Folders
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 0

On Error Resume Next

Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
If  Test = 1 And oHTMLFile Is Nothing Then MsgBox("Unable to Create Object - HTMLFile")

Set oMail = CreateObject("CDO.Message")
If  Test = 1 And oMail Is Nothing Then MsgBox("Unable to Create Object - Mail")

Set oConf = CreateObject("CDO.Configuration")
If  Test = 1 And oConf Is Nothing Then MsgBox("Unable to Create Object - Configuration")

Set oFolders = CreateObject("ptsFolderUser.CFolders")
If  Test = 1 And oFolders Is Nothing Then MsgBox("Unable to Create Object - Folders")

Set oDripPages = CreateObject("ptsDripPageUser.CDripPages")
If  Test = 1 And oDripPages Is Nothing Then MsgBox("Unable to Create Object - DripPages")

Set oFolderItems = CreateObject("ptsFolderItemUser.CFolderItems")
If  Test = 1 And oFolderItems Is Nothing Then MsgBox("Unable to Create Object - FolderItems")

Set oCompany = CreateObject("ptsCompanyUser.CCompany")
If  Test = 1 And oCompany Is Nothing Then MsgBox("Unable to Create Object - Company")

FolderID = 0
DripCampaignID = 0
CompanyID = 0
Virtual = 0

If Test = 1 Then MsgBox("Start: " + Err.description)

'Get all the active drip campaigns
With oFolders
    .ListVirtualFolder 1

    For Each oFolder in oFolders
        With oFolder
            FolderID = .FolderID
            tmpCompanyID = .CompanyID
            DripCampaignID = .DripCampaignID
            Virtual = .Virtual
        End With
        
        If Test = 1 Then MsgBox("Folder: " & FolderID & " - Company: " & tmpCompanyID & " - Campaign: " & DripCampaignID & " - Virtual: " & Virtual )

'       Get company email to send message from
        If CompanyID <> tmpCompanyID Then
            CompanyID = tmpCompanyID
''           Create a new Mail Object for each company 
'            Set oMail = Nothing
'            Set oMail = CreateObject("CDO.Message")
''           If Company #7 Strong Income - Use AWS SES
'            If CompanyID = 7 Then
'                Set oConf = Nothing
'                Set oConf = CreateObject("CDO.Configuration")
'                Set Flds = oConf.Fields
'                Const cdoSendUsingPort = 2
'                With Flds
'                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort 
'                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "email-smtp.us-east-1.amazonaws.com"
'                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
'                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
'                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic 
'                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "AKIAJFR3W6DJ3FK2QO2A"
'                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "AsqU6TPci3BCiKiNbEQaJqVHiUvatPWD87jn/3iESyyH"
'                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
'                    .Update
'                End With
'                Set oMail.Configuration = 0Conf
'            End If    

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
                    .ListVirtualDrip CompanyID, Virtual, Days

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
                            If Test = 0 Then LogFile "DripFolder-" + CStr(FolderID), tmpTo + " - " + CStr(Days)
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
Set oFolders = Nothing
Set oConf = Nothing
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
