<%
' Requires Comm.asp
'*****************************************************************************************************
Function LostBonusEmail( byVal bvCompanyID, byVal bvMinAmount, byRef brTotal )
	On Error Resume Next
Test = 0
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
            LostBonusDate = FormatDateTime(.LostBonusDate,2) 
        End With
    End If
    Set oCompany = Nothing

    Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
    If oHTMLFile Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
    Else
        With oHTMLFile
        .Filename = "LostBonusEmail.htm"
        .Path = reqSysWebDirectory + "Sections\Company\" + CStr(bvCompanyID)
        .Language = reqSysLanguage
        .Project = SysProject
        .Load 
        tmpData = .Data
        If Len(tmpData) < 10 Then
            response.write "<BR>Missing " + .Filename + "<BR><BR>"
        End If
        tmpData = Replace( tmpData, "{date}", CStr(LostBonusDate) )
        End With
    End If
    Set oHTMLFile = Nothing
      
    If Len(tmpData) > 10 Then
        Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
        If oMembers Is Nothing Then
           DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
        Else
            oMembers.CustomList reqCompanyID, 80, bvMinAmount

            brTotal = 0
            For Each oItem in oMembers
		        With oItem
		            MemberID = .MemberID
		            aData = Split( .Signature, "-" )
		            If UBOUND(aData) >= 3 Then
                        Amount = FormatCurrency( aData(0), 2)
		                tmpName = TRIM(aData(1))
		                tmpTo = TRIM(aData(3))
    		            aName = Split( tmpName, " " )
		                tmpFirst = TRIM(aName(0))
                        If InStr(tmpTo, "@") > 0 Then
                            tmpSubject = "Oops! You Have Lost Bonuses"
                            tmpBody = Replace( tmpData, "{amount}", CStr(Amount) )
                            tmpBody = Replace( tmpBody, "{firstname}", tmpFirst )
                            If Test <= 0 Then SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                            If Test > 0 Then response.write "<BR>" + CStr(MemberID) + " " + tmpFrom + " " + tmpTo + " " + tmpBody
                            brTotal = brTotal + 1
                        End If
                    End If
		        End With
            Next 
        End If
        Set oMembers = Nothing
    End If
    
End Function

%>

