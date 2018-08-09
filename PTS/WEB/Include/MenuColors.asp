<%
'*****************************************************************************************************
Function GetMenuColors( byVal bvCompanyID, byVal bvGroupID, byRef brMenuBehindColor, byRef brMenuTopColor, byRef brMenuTopBGColor, _
byRef brMenuColor, byRef brMenuBGColor, byRef brMenuShadowColor, byRef brMenuBDColor, byRef brMenuOverColor, byRef brMenuOverBGColor, _
byRef brMenuDividerColor, byRef brMenuBehindImage, byRef brMenuTopImage, byRef brMenuImage )
	On Error Resume Next

    MenuColors = ""
    
    If bvGroupID > 0 Then
        Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
        If oMoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
        Else
          With oMoption
             .FetchMember CLng(bvGroupID)
             MenuColors = .MenuColors
          End With
        End If
        Set oMoption = Nothing
    End If
    If bvCompanyID > 0 And MenuColors = "" Then
        Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
        If oCoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
        Else
          With oCoption
             .FetchCompany CLng(bvCompanyID)
             .Load CLng(.CoptionID), 1
             MenuColors = .MenuColors
          End With
        End If
        Set oCoption = Nothing
    End If 

    DefaultMenuColors bvCompanyID, bvGroupID, brMenuBehindColor, brMenuTopColor, brMenuTopBGColor, brMenuColor, brMenuBGColor, _
                      brMenuShadowColor, brMenuBDColor, brMenuOverColor, brMenuOverBGColor, brMenuDividerColor, brMenuBehindImage, brMenuTopImage, brMenuImage

	aColors = Split(MenuColors, ",")
	Total = UBOUND(aColors)
	If Total >= 0 And aColors(0) <> "" Then brMenuBehindColor = aColors(0)
	If Total >= 1 And aColors(1) <> "" Then brMenuTopColor = aColors(1)
	If Total >= 2 And aColors(2) <> "" Then brMenuTopBGColor = aColors(2)
	If Total >= 3 And aColors(3) <> "" Then brMenuColor = aColors(3)
	If Total >= 4 And aColors(4) <> "" Then brMenuBGColor = aColors(4)
	If Total >= 5 And aColors(5) <> "" Then brMenuShadowColor = aColors(5)
	If Total >= 6 And aColors(6) <> "" Then brMenuBDColor = aColors(6)
	If Total >= 7 And aColors(7) <> "" Then brMenuOverColor = aColors(7)
	If Total >= 8 And aColors(8) <> "" Then brMenuOverBGColor = aColors(8)
	If Total >= 9 And aColors(9) <> "" Then brMenuDividerColor = aColors(9)
	If Total >= 10 And aColors(10) <> "" Then brMenuBehindImage = aColors(10)
	If Total >= 11 And aColors(11) <> "" Then brMenuTopImage = aColors(11)
	If Total >= 12 And aColors(12) <> "" Then brMenuImage = aColors(12)
End Function

'*****************************************************************************************************
Function DefaultMenuColors( byVal bvCompanyID, byVal bvGroupID, byRef brMenuBehindColor, byRef brMenuTopColor, byRef brMenuTopBGColor, _
byRef brMenuColor, byRef brMenuBGColor, byRef brMenuShadowColor, byRef brMenuBDColor, byRef brMenuOverColor, byRef brMenuOverBGColor, _
byRef brMenuDividerColor, byRef brMenuBehindImage, byRef brMenuTopImage, byRef brMenuImage)
	On Error Resume Next

'   Member Menu Colors
    brMenuBehindColor = "#474747"
    brMenuTopColor = "#FFFFFF"
    brMenuTopBGColor = "#474747"
    brMenuColor = "#FFFFFF"
    brMenuBGColor = "#474747"
    brMenuShadowColor = "#474747"
    brMenuBDColor = "#474747"
    brMenuOverColor = "#FFFFFF"
    brMenuOverBGColor = "#1c7dd2"
    brMenuDividerColor = "#C0C0C0"
    brMenuBehindImage = ""
    brMenuTopImage = ""
    brMenuImage = ""

'   Employee Menu Colors
    If bvCompanyID = 0 And bvGroupID = 0 Then
        brMenuTopBGColor = "#474747"
        brMenuBGColor = "#474747"
        brMenuOverBGColor = "#1c7dd2"
    End If
    
'   Company Menu Colors
    If bvCompanyID > 0 And bvGroupID = 0 Then
        brMenuBehindColor = "#474747"
        brMenuTopBGColor = "#474747"
        brMenuBGColor = "#474747"
        brMenuOverBGColor = "#1c7dd2"
    End If 

End Function

'*****************************************************************************************************
Function SaveMenuColors( byVal bvCompanyID, byVal bvGroupID, byRef brMenuBehindColor, byRef brMenuTopColor, byRef brMenuTopBGColor, _
byRef brMenuColor, byRef brMenuBGColor, byRef brMenuShadowColor, byRef brMenuBDColor, byRef brMenuOverColor, byRef brMenuOverBGColor, _
byRef brMenuDividerColor, byRef brMenuBehindImage, byRef brMenuTopImage, byRef brMenuImage)
	On Error Resume Next

    MenuColors = brMenuBehindColor + "," + brMenuTopColor + "," + brMenuTopBGColor + "," + brMenuColor + "," + brMenuBGColor + "," + _
                 brMenuShadowColor + "," + brMenuBDColor + "," + brMenuOverColor + "," + brMenuOverBGColor + "," + brMenuDividerColor + "," + _
                 brMenuBehindImage + "," + brMenuTopImage + "," + brMenuImage
    If bvGroupID > 0 Then
        Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
        If oMoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
        Else
          With oMoption
             .FetchMember CLng(bvGroupID)
             .MenuColors = MenuColors
             .Save 1
          End With
        End If
        Set oMoption = Nothing
    Else
        Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
        If oCoption Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
        Else
          With oCoption
             .FetchCompany CLng(bvCompanyID)
             .Load CLng(.CoptionID), 1
             .MenuColors = MenuColors
             .Save 1
          End With
        End If
        Set oCoption = Nothing
    End If 
End Function

%>

