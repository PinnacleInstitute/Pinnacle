<%
'*****************************************************************************************************
Function GetMerchants(byVal bvTarget, byVal bvCountryID, byRef brFeatured, byRef brNew, byRef brMerchants, byRef brOrgs )
On Error Resume Next
    
Set oMerchants = server.CreateObject("ptsMerchantUser.CMerchants")
If oMerchants Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchants"
Else
    With oMerchants
        .SysCurrentLanguage = reqSysLanguage
        .ListMarket bvTarget, bvCountryID
        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

        brFeatured = ""
        brNew = ""
        brMerchants = ""
        brOrgs = ""
        For Each oItem in oMerchants
        With oItem
          'If this is a merchant and not an organization
          If .IsOrg = "0" Then
            'Build Merchant HTML
	    tmpReward = .RewardAmt + "% " + .RewardDesc
	    If .RewardCap <> "0" Then tmpReward = tmpReward + " (max $" + .RewardCap + ")"
	    tmpReward = "<font color=""blue"">" + tmpReward + "</font>"
	    tmpDescription = StripHTML( .Description )
	    tmpAddress = .Street1 + " " + .Street2 + " " + .City + " " + .State + " " + .Zip
	    tmpMap = ""
	    If InStr( .StoreOptions, "H" ) > 0 Then	
		tmpMap = "<A href=""http://maps.google.com/?q=" + tmpAddress + """ target=""_blank""><IMG src=""http://www.nexxusrewards.com/images/GoogleMaps.png"" align=""absmiddle""></A>"	
	    End If

            tmpMerchant = "<b>" + .MerchantName + "</b> - " + tmpReward + " - " + tmpDescription + " - " + tmpAddress + " " + tmpMap + " - " + .Phone + " " + .Email + "<BR>"
    
            'If this is a featured merchant
            If InStr( .Options, "F" ) > 0 Then
              brFeatured = brFeatured + "<img src=""http://www.nexxusrewards.com/images/star_full.gif"" alt=""Featured"" align=""absmiddle"">" + "&nbsp;" + tmpMerchant
            Else
              'If this is a new merchant within the last 30 days
              If DateDiff( "d", .EnrollDate, reqSysDate) <= 30 Then
                brNew = brNew + "<img src=""http://www.nexxusrewards.com/images/new2.gif"" alt=""NEW"" align=""absmiddle"">" + "&nbsp;" + tmpMerchant
              Else
                brMerchants = brMerchants + tmpMerchant
              End If
            End If
          Else
    	    tmpDescription = StripHTML( .Description )
            brOrgs = brOrgs + "<b>" + .MerchantName + "</b> - " + tmpDescription + " - " + .Phone + " " + .Email + "<BR>"
          End If
        End With
        Next
    End With
End If

End Function

Function StripHTML( ByVal bvHTML )
    bvHTML = join(filter(split(replace(bvHTML, "<", "><"),">"),"<", false))
    bvHTML = replace(bvHTML,"&nbsp;"," ")
    StripHTML = bvHTML
End Function

%>