'*****************************************************************************
' Drip Seminar Emails
'*****************************************************************************
PUBLIC CONST SysPath = "C:\PTS\WEB\"
PUBLIC CONST Test = 0

On Error Resume Next
Set fs = CreateObject("Scripting.FileSystemObject")
If  Test = 1 And fs Is Nothing Then MsgBox("Unable to Create Object - FileSystemObject")

Set oHTMLFile = CreateObject("wtHTMLFile.CHTMLFile")
If  Test = 1 And oHTMLFile Is Nothing Then MsgBox("Unable to Create Object - HTMLFile")

Set oMail = CreateObject("CDO.Message")
If  Test = 1 And oMail Is Nothing Then MsgBox("Unable to Create Object - Mail")

Set oConf = CreateObject("CDO.Configuration")
If  Test = 1 And oConf Is Nothing Then MsgBox("Unable to Create Object - Configuration")

Set oSeminar = CreateObject("ptsSeminarUser.CSeminar")
If  Test = 1 And oSeminar Is Nothing Then MsgBox("Unable to Create Object - Seminar")

Set oMeetings = CreateObject("ptsMeetingUser.CMeetings")
If  Test = 1 And oMeetings Is Nothing Then MsgBox("Unable to Create Object - Meetings")

Set oAttendees = CreateObject("ptsAttendeeUser.CAttendees")
If  Test = 1 And oAttendees Is Nothing Then MsgBox("Unable to Create Object - Attendees")

If Test = 1 Then MsgBox("Start: " + Err.description)

Today = Date()
oMail.Sender = "support@NexxusUniversity.com"
oMail.From = "support@NexxusUniversity.com"

'Get all the active meetings
With oMeetings
    .ListActive 1

    For Each oMeeting in oMeetings
        With oMeeting
            tmpSeminarID = .SeminarID
            tmpMeetingID = .MeetingID
            tmpVenueName = .VenueName
            tmpVenueAddress = .Description
            tmpMeetingDate = .MeetingDate
            DayStr = ""
            Select Case Weekday(.MeetingDate)
            Case 1 DayStr = "Sunday"
            Case 2 DayStr = "Monday"
            Case 3 DayStr = "Tuesday"
            Case 4 DayStr = "Wednesday"
            Case 5 DayStr = "Thursday"
            Case 6 DayStr = "Friday"
            Case 7 DayStr = "Saturday"
            End Select
            tmpMeetingDateTime = DayStr + " " + CStr(.MeetingDate) + "  " + .StartTime
            If .EndTime <> "" Then tmpMeetingDateTime = tmpMeetingDateTime + " - " + .EndTime
        End With
        
        'Get Seminar Name
        oSeminar.Load tmpSeminarID, 1
        tmpSeminarName = oSeminar.SeminarName

        If Test = 1 Then MsgBox("Seminar: " & tmpSeminarID & " - Venue: " & tmpVenueName & " - VenueAddress: " & tmpVenueAddress & " - MeetingDateTime: " & tmpMeetingDateTime )

'       Get days before meeting
        tmpDays = DateDiff( "d", Today, tmpMeetingDate )
'       Get full filename for email
        tmpFileName = SysPath + "Seminar\Seminar" + CStr(tmpSeminarID) + "-" + CStr(tmpDays) + "[en].htm"

        If Test = 1 Then MsgBox("Filename: " & tmpFileName )

        If fs.FileExists(tmpFileName)  Then

    '       Get the email message for this seminar and day
            With oHTMLFile
                .Filename = "Seminar" + CStr(tmpSeminarID) + "-" + CStr(tmpDays) + ".htm"
                .Path = SysPath + "Seminar\"
                .Language = "en"
                .Project = "PTS"
                .Load 
                Body = .Data
            End With

    '       Get all the active Attendeess for this meeting
            With oAttendees
                .ListActive tmpMeetingID

        	    For Each oAttendee in oAttendees
                    With oAttendee
                        tmpFirstName = .NameFirst
                        tmpLastName = .NameLast
                        tmpEmail = .Email
                    End With

                    If Test = 1 Then MsgBox("Attendee: " & tmpNameFirst + " " & tmpNameLast + " - " & tmpEmail)

                    If InStr( tmpEmail, "@" ) > 0 Then
                        tmpTo = ""
                        tmpCC = ""
                        tmpSubject = ""
                        tmpBody = ""
                        tmpTo = tmpEmail
                        tmpSubject = tmpSeminarName

                        tmpBody = Replace( Body, "{firstname}", tmpFirstName )
                        tmpBody = Replace( tmpBody, "{lastname}", tmpLastName )
                        tmpBody = Replace( tmpBody, "{seminarname}", tmpSeminarName )
                        tmpBody = Replace( tmpBody, "{venuename}", tmpVenueName )
                        tmpBody = Replace( tmpBody, "{venueaddress}", tmpVenueAddress )
                        tmpBody = Replace( tmpBody, "{meetingdatetime}", tmpMeetingDateTime )

                        If Test > 0 Then MsgBox("Subject: " & tmpSubject)
                        If Test > 0 Then MsgBox("Message: " & tmpBody)

                        With oMail
                            .To = tmpTo
                            .Subject = tmpSubject
                            .HTMLBody = tmpBody
                            If Test = 0 Then .Send
                        End With
                        If Test = 0 Then LogFile "Seminar", CStr(tmpSeminarID) + "-" + CStr(tmpMeetingID) + " - " + tmpTo + " - " + CStr(tmpDays)
                    End If
                Next
            End With
        End If
    Next
End With

If Test = 1 Then MsgBox("End: " + Err.description)

Set oAttendees = Nothing
Set oMeetings = Nothing
Set oSeminar = Nothing
Set oConf = Nothing
Set oMail = Nothing
Set oHTMLFile = Nothing
Set fs = nothing

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
