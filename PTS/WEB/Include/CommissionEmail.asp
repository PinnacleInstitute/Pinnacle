<%
' Requires Comm.asp
'*****************************************************************************************************
Function CommissionEmail( byVal bvCompanyID, byVal bvPaymentID, byVal bvFromDate, byVal bvToDate, byRef brTotal )
	On Error Resume Next
Test = -1
    Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
    If oCompany Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
    Else
        With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load bvCompanyID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .Email
            tmpFrom = .Email
        End With
    End If
    Set oCompany = Nothing

	Set oCommissions = server.CreateObject("ptsCommissionUser.CCommissions")
	If oCommissions Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsCommissionUser.CCommissions"
	Else
		oCommissions.Email bvCompanyID, bvPaymentID, bvFromDate, bvToDate
        brTotal = 0
        For Each oItem in oCommissions
		    With oItem
		        tmpTo = .Notes
		        If bvPaymentID = 0 Then
                    tmpSubject = "Congratulations! You've earned " + FormatCurrency(.Total,2) + " in commissions"
                    If bvFromDate = bvToDate Then
                        tmpSubject = tmpSubject + " on " + CStr(bvFromDate)
                    Else
                        tmpSubject = tmpSubject + " from " + CStr(bvFromDate) + " to " + CStr(bvToDate)
                    End If
		        Else
                    tmpSubject = "Congratulations! You've earned " + FormatCurrency(.Total,2) + " in commissions from " + .Description
		        End If
                If bvCompanyID = 9 Then tmpSubject = Replace(tmpSubject, "commissions", "ZaZZed commissions" )

                tmpBody = tmpSubject
                If Test <= 0 Then SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                If Test <> 0 Then LogFile "CommissionEmail", tmpTo + " - " + tmpSubject + " " + Err.description
                brTotal = brTotal + 1
		    End With
        Next 
	End If
	Set oCommissions = Nothing
End Function
%>

