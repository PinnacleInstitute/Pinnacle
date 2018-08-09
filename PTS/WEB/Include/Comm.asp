<%
'***********************************************************************
Function SendEmail( ByVal bvCompanyID, ByVal bvSender, ByVal bvFrom, ByVal bvTo, ByVal bvCC, ByVal bvBCC, ByVal bvSubject, ByVal bvBody )
    On Error Resume Next
    Set oMail = server.CreateObject("CDO.Message")
    If oMail Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
    Else
        UserName = ""
        Password = ""
        If bvCompanyID = 7 Then
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
        With oMail
            .Sender = bvSender
            .From = bvFrom
            .To = bvTo
            .Cc = bvCC
            .Bcc = bvBCC
            .Subject = bvSubject 
            .HTMLBody = bvBody
            .Send
        End With
    End If
    Set oMail = Nothing
End Function

'***********************************************************************
Function SendEmailMTA( ByVal bvCompanyID, ByVal bvSender, ByVal bvFrom, ByVal bvTo, ByVal bvCC, ByVal bvBCC, ByVal bvSubject, ByVal bvBody )
    On Error Resume Next
    Set oMail = server.CreateObject("CDO.Message")
    If oMail Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
    Else

        With oMail.Configuration.Fields
            .Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 '1 'Send the message using the network (SMTP over the network).
            .Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "10.10.10.10" ' this is your smtp server usually something like smtp.somedomain.com
            .Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 '25 is the standard smtp port but check with your host to be sure
            .Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
            .Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
            .Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'Can be 0 for No Authentication, 1 for basic authentication or 2 for NTLM (check with your host)
            .Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "info" 'The username log in credentials for the email account sending this email, not needed if authentication is set to 0
            .Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "web123dev" 'The password log in credentials for the email account sending this email, not needed if authentication is set to 0
            .Update
        End With

        With oMail
            .Sender = bvSender
            .From = bvFrom
            .To = bvTo
            .Cc = bvCC
            .Bcc = bvBCC
            .Subject = bvSubject 
            .HTMLBody = bvBody
            .Send
        End With
    End If
    Set oMail = Nothing
End Function

'***********************************************************************
Function SendMsg( ByVal bvFrom, ByVal bvTo, ByVal bvSubject, ByVal bvMessage )
	On Error Resume Next
	Set oMsg = server.CreateObject("ptsMsgUser.CMsg")
	If oMsg Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsMsgUser.CMsg"
	Else
		With oMsg
			.MsgDate = Now()
			.AuthUserID = bvFrom
			.OwnerType = 4
			.OwnerID = bvTo
			.Subject = bvSubject
			.Message = bvMessage
			.Add(1)
		End With
	End If
	Set oMsg = Nothing
End Function

%>

