<%
'*****************************************************************************************************
Function BuildHeader()
	On Error Resume Next

If (reqSysGA_ACCTID = "") Then
   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
         aGA = Split(.GAAcct, ",")
         If UBOUND(aGA) = 1 Then
             tmpID = aGA(0)
             tmpDomain = aGA(1)
             If tmpID <> "" And tmpDomain <> "" Then
                 reqSysGA_ACCTID = tmpID
                 reqSysGA_DOMAIN = tmpDomain
                 SetCache "GA_ACCTID", tmpID
                 SetCache "GA_DOMAIN", tmpDomain
             End If
         End If
      End With
   End If
   Set oCoption = Nothing
End If

If (reqA <> 0) Then
    SetCache "A", reqA
    reqSysAffiliateID = reqA
    SetCache "AFFILIATEID", reqSysAffiliateID
End If
If (reqG <> 0) Then
    SetCache "GROUPID", reqG
End If
reqLgn = GetCookie("LGN")
reqPwd = GetCookie("PWD")
If (reqLgn <> "") Then
    reqRemember = 1
End If
GetCompany(reqCompanyID)
GroupID = Numeric(GetCache("GROUPID"))

If (reqSysUserGroup <> 41) And (reqMemberID <> 0) Then
    Set oMember = server.CreateObject("ptsMemberUser.CMember")
    If oMember Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
    Else
        With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqMemberID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            GroupID = .GroupID
            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        End With
    End If
    Set oMember = Nothing
End If

If (GroupID <> 0) Then reqG = GroupID

reqLogo1 = "Company\" + CStr(reqCompanyID) + "\Logo.png"
reqLogo2 = "Company\" + CStr(reqCompanyID) + "\Slogan.png"

Logo = GetCache("LOGO")
If (CLng(GroupID) <> 0) And Logo = "" Then
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\"
	FileName = "Company\" + CStr(reqCompanyID) + "\Logo" + CSTR(GroupID)
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	Exists = oFileSys.FileExists(FilePath + FileName + ".png")
	If Exists Then
        reqLogo2 =  FileName + ".png"
	Else
		Exists = oFileSys.FileExists(FilePath + FileName + ".gif")
		If Exists Then
            reqLogo2 = FileName + ".gif"
		Else
			Exists = oFileSys.FileExists(FilePath + FileName + ".jpg")
			If Exists Then
                reqLogo2 = FileName + ".jpg"
			Else
                reqLogo2 = "Company\" + CStr(reqCompanyID) + "\Slogan.png"
			End If
		End If
	End If
	Set oFileSys = Nothing
    SetCache "LOGO", reqLogo2
End If

xmlHDR = "<HDRS>"
xmlHDR = xmlHDR + "<HDR image=""Hdr1.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr2.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr3.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr4.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr5.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr6.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr7.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr8.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr9.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr10.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr11.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr12.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr13.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr14.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr15.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr16.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr17.jpg""/>"
xmlHDR = xmlHDR + "<HDR image=""Hdr18.jpg""/>"
xmlHDR = xmlHDR + "</HDRS>"

Set oNewss = server.CreateObject("ptsNewsUser.CNewss")
If oNewss Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsUser.CNewss"
Else
    With oNewss
        .SysCurrentLanguage = reqSysLanguage
        .ListNews reqCompanyID, 1, 0
        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        xmlStrategic = .XML(13, "Strategic")
        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
    End With
End If
Set oNewss = Nothing
      
reqMenuBehindColor2 = "f0f0f0"
MenuTopColor = "2b2b2b"
MenuTopBGColor = "e3e3e3"
MenuColor = "ffffff"
MenuBGColor = "1C1C1C"
MenuBGColor = "3d3c3c"
MenuShadowColor = "e3e3e3"
MenuBDColor = "e3e3e3"
MenuOverColor = "ffffff"
MenuOverBGColor = "724C4C"
MenuDividerColor = "e3e3e3"
reqMenuBehindImage2 = ""
MenuTopImage = ""
MenuImage = ""

Set oNewsTopics = server.CreateObject("ptsNewsTopicUser.CNewsTopics")
If oNewsTopics Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsTopicUser.CNewsTopics"
Else
    With oNewsTopics
        .SysCurrentLanguage = reqSysLanguage
        .ListActive reqCompanyID
        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

        '-----get the topic menu Definitions
        s = "<MENU name=""TopicMenu"" type=""bar"" menuwidth=""150"" height=""30"" top-color=""" & MenuTopColor & """ top-bgcolor=""" & MenuTopBGColor & """ color=""" & MenuColor & """ bgcolor=""" & MenuBGColor & """ shadow-color=""" & MenuShadowColor & """ bdcolor=""" & MenuBDColor & """ over-color=""" & MenuOverColor & """ over-bgcolor=""" & MenuOverBGColor & """ divider-color=""" & MenuDividerColor & """ top-bgimg=""" & MenuTopImage & """ bgimg=""" & MenuImage & """>"
        Child = -1
        MainName = ""
        MainID = 0
        For Each oItem in oNewsTopics
            With oItem
                seq = CLng(.Seq)
                name = .NewsTopicName
                id = .NewsTopicID
                width = (Len(name) * 7) + 30
                'If this is a Main News Topic
                If seq Mod 100 = 0 Then
                    'If no children for the last main topic, add a link to the last main mmenu option and close the /item
                    If Child >= 0 Then
                        If Child = 0 Then
                            s=s+ "<LINK name=""JAVA(ShowTab('TabTopic'," + CSTR(MainID) + "))""/>"
                            s=s+ "</ITEM>"
                        Else
                            s=s+ "</ITEM>"
                        End If
                    End If
                    MainName = name
                    MainID = id
                    Child = 0
                    'Add the main menu item and wait to see if there is going to be a submenu
                    s=s+ "<ITEM value=""" + MainName + """ width=""" + CStr(width) + """ align=""center"">"
                Else
                    'If this is the first submenu item, add the main menu item with a link as the first submenu option
                    If Child = 0 Then
                        s=s+ "<ITEM value=""" + MainName + """>"
                        s=s+ "<LINK name=""JAVA(ShowTab('TabTopic'," + CSTR(MainID) + "))""/>"
                        s=s+ "</ITEM>"
                    End If
                    s=s+ "<ITEM value=""" + name + """>"
                    s=s+ "<LINK name=""JAVA(ShowTab('TabTopic'," + CSTR(id) + "))""/>"
                    s=s+ "</ITEM>"
                    Child = Child + 1
                End If
                cnt = cnt + 1
            End With
        Next
        'Close last main menu option
        'If there was no submenu, add a link, otherwise just close the /item
        If Child >= 0 Then
            If Child = 0 Then
                s=s+ "<LINK name=""JAVA(ShowTab('TabTopic'," + CSTR(MainID) + "))""/>"
                s=s+ "</ITEM>"
            Else
                s=s+ "</ITEM>"
            End If
        End If
        s=s+ "</MENU>"
        xmlTopicMenu = s
    End With
End If
Set oNewsTopics = Nothing
GetMenuColors reqCompanyID, reqMemberID, reqMenuBehindColor, reqMenuTopColor, MenuTopBGColor, MenuColor, MenuBGColor, MenuShadowColor, MenuBDColor, MenuOverColor, MenuOverBGColor, MenuDividerColor, reqMenuBehindImage, MenuTopImage, MenuImage

End Function

%>

