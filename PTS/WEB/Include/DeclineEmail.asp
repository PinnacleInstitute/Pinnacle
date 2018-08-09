<%
' Requires Comm.asp
'*****************************************************************************************************
Function DeclineEmail( byVal bvCompanyID, byVal bvPaymentID, byVal bvSalesOrder, byVal bvFromDate, byVal bvToDate, byRef brTotal )
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
        End With
    End If
    Set oCompany = Nothing

    Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
    If oMembers Is Nothing Then
       DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
    Else
        If bvSalesOrder = 0 Then
            If bvPaymentID = 0 Then        
                oMembers.CustomList reqCompanyID, 100, 4
            Else           
                oMembers.CustomList reqCompanyID, 101, bvPaymentID
            End If   
        Else
            If bvPaymentID = 0 Then        
                oMembers.CustomList reqCompanyID, 102, 4
            Else           
                oMembers.CustomList reqCompanyID, 103, bvPaymentID
            End If   
        End If 
        brTotal = 0
        For Each oItem in oMembers
		    With oItem
		        MemberID = .Level
		        aData = Split( .Signature, "-" )
		        If UBOUND(aData) >= 4 Then
		            tmpName = TRIM(aData(0))
		            tmpTo = TRIM(aData(2))
		            tmpProcess = 1
		            If ISDate(bvFromDate) Then
    		            txtDate = TRIM(aData(4))
    		            If IsDate(txtDate) Then
    		                tmpDate = CDate(txtDate)
    		                tmpFromDate = CDate(bvFromDate)
    		                tmpToDate = DateAdd("d",1,bvToDate)
    		                If tmpDate < tmpFromDate OR tmpDate > tmpToDate Then tmpProcess = 0
    		            End If
		            End If
                    If tmpProcess = 1 Then
    					tmpURL = "http://" + reqSysServerName + reqSysServerPath + "0436d.asp?memberid=" + CStr(MemberID)
                        If bvCompanyID = 21 Then
                            tmpSubject = "Oops! Your Nexxus payment was declined."
                            tmpBody = tmpName + "<p><a href=""" + tmpURL + """>Click Here to resolve your declined payment.</a> Your payment will be cancelled if your declined payment is not resolved within 7 days. Your bonus qualification may be affected. If you have 3 recent cancelled payments your order option will be turned off.</p>"
                        Else
                            tmpSubject = "Oops! Your payment was declined."
                            tmpBody = tmpName + "<p><a href=""" + tmpURL + """>Click Here to resolve your declined payment.</a> Your membership may be effected until your declined payment is resolved.</p>"
                        End If
                        If Test <= 0 Then SendEmail bvCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
                        If Test > 0 Then response.write "<BR>" + CStr(MemberID) + " " + tmpFrom + " " + tmpTo + " " + tmpBody
                        brTotal = brTotal + 1
                    End If
                End If
		    End With
        Next 
    End If
    Set oMembers = Nothing
    
End Function

%>

