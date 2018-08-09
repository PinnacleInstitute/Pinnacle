<!--#include file="MobileBrowser.asp"-->
<%
Function Redirect()
	On Error Resume Next

'LogFile "TEST", CStr(reqSysCompanyID) + " - " + reqSysServerName

	If InStr(lcase(reqSysServerName), "gcrcoin") > 0 Then
		Response.Redirect "http://gcrcoin.com/sections/company/17/home/gcr-maintenance.html"
	End If

	If InStr(lcase(reqSysServerName), "bitcoinlunchnlearn") > 0 Then
		tmpSeminarID = GetSeminarID( reqSysServerName, tmpRefer )
		tmpURL = "http://www.nexxusuniversity.com/sp.asp?s=" + CStr(tmpSeminarID)
		If tmpRefer <> "" Then tmpURL = tmpURL + "&r=" + tmpRefer
		Response.Redirect tmpURL
	End If

	If reqSysCompanyID = 17 OR InStr(lcase(reqSysServerName), "gcrmarketing") > 0 Then
		Response.Redirect "http://www.gcrmarketing.com/sections/company/17/home/outofbusiness.htm"
	End If

	If reqSysCompanyID = 21 OR InStr(lcase(reqSysServerName), "nexxus") > 0 Then
               SetCache "COMPANYID", "21"
		tmpMobile = IsMobileBrowser()
		tmpGroupID = 0
		tmpMember = ""
		tmpMemberID = GetMemberID( reqSysServerName, tmpGroupID, tmpMember )
		If Len(tmpMemberID) > 0 Then SetCache "A", CStr(tmpMemberID)
		If InStr(lcase(reqSysServerName), "nexxuspartners.com") > 0 OR InStr(lcase(reqSysServerName), "nexxuspeople.com") > 0 Then

			If Len(tmpMemberID) > 0 Then 
				If InStr(lcase(reqSysServerName), "nexxuspartners.com") > 0 Then
					Response.Redirect "http://www.nexxusuniversity.com/direct.asp?a=" + CStr(tmpMemberID) + "&u=pp.asp?p=87%26m=" + CStr(tmpMemberID)
				Else
					Response.Redirect "http://www.nexxusuniversity.com/direct.asp?a=" + CStr(tmpMemberID) + "&u=pp.asp?p=123%26m=" + CStr(tmpMemberID)
				End If
			Else
				Response.Redirect "http://www.nexxuspartners.com/sections/company/21/partners/index.html"
			End If

		Else 
			If InStr(lcase(reqSysServerName), "nexxustoken.com") > 0 Then
				Response.Redirect "http://www.nexxustoken.com/sections/company/21/nexxuscoin/index.html"
			End If
			If InStr(lcase(reqSysServerName), "nexxuscoin.com") > 0 Then
				Response.Redirect "http://www.nexxuscoin.com/sections/company/21/nexxuscoin/index.html"
			End If

			If InStr(lcase(reqSysServerName), "nexxusrewards.com") > 0 Then
				Response.Redirect "http://www.nexxusrewards.com/direct.asp?a=" + CStr(tmpMemberID) + "&u=sections/company/21/rewards/index.html"
			End If

			If InStr(lcase(reqSysServerName), "nexxusbarter.com") > 0 Then
				If Len(tmpMemberID) > 0 Then 
					Response.Redirect "http://www.nexxuspartners.com/sections/company/21/partners/index.html"
				Else
					Response.Redirect "http://www.nexxuspartners.com/sections/company/21/partners/index.html"
				End If
			End If

			If InStr(lcase(reqSysServerName), "nexxusuniversity.com") > 0 Then
				If Len(tmpMemberID) > 0 Then 
					Response.Redirect "http://www.nexxusuniversity.com/direct.asp?a=" + CStr(tmpMemberID) + "&u=pp.asp?p=110%26m=" + CStr(tmpMemberID)
				Else
					Response.Redirect "http://www.nexxusuniversity.com/direct.asp?a=" + CStr(tmpMemberID) + "&u=sections/company/21/home/index.html"
				End If
			End If
		End If
	End If

End Function

Function GetMemberID(ByVal ServerName, ByRef tmpGroupID, ByRef tmpMember)
	On Error Resume Next
		'Check for member logon as subnet
		tmpMemberID = ""
		tmpMember = ""
		tmpURL = Replace(lcase(ServerName), "www.","") 		
		tmpURL = Replace(tmpURL, ".com","") 		
		pos = InStr(tmpURL, "." )
		If pos > 0 Then
			tmpMember = left(tmpURL, pos-1)
			Set oMember = server.CreateObject("ptsMemberUser.CMember")
			If oMember Is Nothing Then
				DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
			Else
				With oMember
					.FetchLogon tmpMember
					If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
					If (.MemberID <> 0) Then
						tmpMemberID = .MemberID
						tmpGroupID = .GroupID
					End If
				End With
			End If
			Set oMember = Nothing
		End If
		GetMemberID = tmpMemberID
End Function

Function GetWebsite(ByVal bvServerName, ByVaL bvMemberID, ByRef brPageType, ByRef brLeadCampaignID )
	On Error Resume Next
	'Check for MemberDomain logon as subnet
	brPageType = 0
	brLeadCampaignID = 0
	tmpURL = Replace(lcase(bvServerName), "www.","") 		
	pos = InStr(tmpURL, "." )
	If pos > 0 Then
		tmpDomain = Mid(tmpURL, pos+1 )
		Set oMemberDomain = server.CreateObject("ptsMemberDomainUser.CMemberDomain")
		If oMemberDomain Is Nothing Then
			DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberDomainUser.CMemberDomain"
		Else
			With oMemberDomain
				.Website bvMemberID, tmpDomain, 1
				If .PageType > 0 Then
					brPageType = .PageType
					brLeadCampaignID = .LeadCampaignID 
				End If
			End With
		End If
		Set oMemberDomain = Nothing
	End If
	GetWebsite = brLeadCampaignID 
End Function

Function GetSeminarID(ByVal ServerName, ByRef tmpRefer)
	On Error Resume Next
	'Check for seminar ID as subnet
	tmpSeminarID = "0"
	tmpRefer = ""
	tmpURL = Replace(lcase(ServerName), "www.","") 		
	tmpURL = Replace(tmpURL, ".com","") 		
	pos = InStr(tmpURL, "." )
	If pos > 0 Then
		tmpSeminarID = left(tmpURL, pos-1)
		tmpURL = Replace(tmpURL, CStr(tmpSeminarID) + ".", "")
		pos = InStr(tmpURL, "." )
		If pos > 0 Then tmpRefer = left(tmpURL, pos-1)
	End If
	GetSeminarID = tmpSeminarID
End Function

%>

