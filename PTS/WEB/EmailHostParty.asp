<% Response.Buffer=true
	tmpReturn = request.form("Return")
	tmpTo = request.form("MemberEmail")
	tmpSender = tmpTo
	tmpFrom = tmpTo
	tmpSubject = "To the Nines - Host a Party"

	tmpName=request.form("Name")
	tmpEmail=request.form("Email")
	tmpPhone=request.form("Phone")
	tmpAddress=request.form("Address")
	tmpCity=request.form("City")
	tmpState=request.form("State")
	tmpZip=request.form("Zip")
	tmpMsg=request.form("Message")

	tmpBody = tmpName + "<BR>" + tmpEmail + "<BR>" + tmpPhone + "<BR>" + tmpAddress + "<BR>" + tmpCity + ", " + tmpState + " " + tmpZip + "<P>" + tmpMsg
	
    If InStr(tmpTo, "@") > 0 Then
        Set oMail = server.CreateObject("CDO.Message")
        If oMail Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
        Else
        With oMail
            .Sender = tmpSender
            .From = tmpFrom
            .To = tmpTo
            .Subject = tmpSubject
            .HTMLBody = tmpBody
            .Send
        End With
        End If
        Set oMail = Nothing
    End If   
    Response.Redirect tmpReturn
%>