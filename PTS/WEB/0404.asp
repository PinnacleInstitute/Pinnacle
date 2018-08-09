<!--#include file="Include\System.asp"-->
<!--#include file="Include\LimitedAccess.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<!--#include file="Include\Encript.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----page variables
Dim oData
Dim oStyle
'-----system variables
Dim reqActionCode
Dim reqSysTestFile, reqSysLanguage
Dim reqSysHeaderImage, reqSysFooterImage, reqSysReturnImage, reqSysNavBarImage, reqSysHeaderURL, reqSysReturnURL
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGA_ACCTID, reqSysGA_DOMAIN
Dim reqLangDialect, reqLangCountry, reqLangDefault
Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm
Dim xmlTransaction, xmlData
'-----language variables
Dim oLanguage, xmlLanguage
Dim xslPage
Dim fileLanguage
'-----object variables
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oShortcuts, xmlShortcuts
Dim oAppts, xmlAppts
Dim oGoals, xmlGoals
'-----other transaction data variables
Dim xmlHTMLMember
Dim xmlHTMLWarn
Dim xmlDB
Dim xmlIcons
'-----declare page parameters
Dim reqMemberID
Dim reqEmployeeID
Dim reqCompanyID
Dim reqUpgrade
Dim reqTBImage
Dim reqIdentify
Dim reqNewMember
Dim reqVisitDate
Dim reqGroupID
Dim reqLevel
Dim reqTest
Dim reqWarn
Dim reqOptions2
On Error Resume Next

'-----Call Common System Function
CommonSystem()

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   bvErrorMsg = Replace(bvErrorMsg, Chr(39), Chr(34))
   Set oUtil = server.CreateObject("wtSystem.CUtility")
   With oUtil
      tmpMsgFld = .ErrMsgFld( bvErrorMsg )
      tmpMsgVal = .ErrMsgVal( bvErrorMsg )
   End With
   Set oUtil = Nothing
   xmlError = "<ERROR number=" + Chr(34) & bvNumber & Chr(34) + " src=" + Chr(34) + bvSource + Chr(34) + " msgfld=" + Chr(34) + tmpMsgFld + Chr(34) + " msgval=" + Chr(34) + tmpMsgVal + Chr(34) + ">" + CleanXML(bvErrorMsg) + "</ERROR>"
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "0404URL", reqReturnURL
   SetCache "0404DATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysHeaderImage = GetCache("HEADERIMAGE")
reqSysFooterImage = GetCache("FOOTERIMAGE")
reqSysReturnImage = GetCache("RETURNIMAGE")
reqSysNavBarImage = GetCache("NAVBARIMAGE")
reqSysHeaderURL = GetCache("HEADERURL")
reqSysReturnURL = GetCache("RETURNURL")
reqConfirm = GetCache("CONFIRM")
SetCache "CONFIRM", ""
reqSysEmployeeID = Numeric(GetCache("EMPLOYEEID"))
reqSysCustomerID = Numeric(GetCache("CUSTOMERID"))
reqSysAffiliateID = Numeric(GetCache("AFFILIATEID"))
reqSysAffiliateType = Numeric(GetCache("AFFILIATETYPE"))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "0404")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGA_ACCTID = GetCache("GA_ACCTID")
reqSysGA_DOMAIN = GetCache("GA_DOMAIN")

'-----fetch page parameters
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqEmployeeID =  Numeric(GetInput("EmployeeID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqUpgrade =  Numeric(GetInput("Upgrade", reqPageData))
reqTBImage =  GetInput("TBImage", reqPageData)
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqNewMember =  Numeric(GetInput("NewMember", reqPageData))
reqVisitDate =  GetInput("VisitDate", reqPageData)
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqTest =  Numeric(GetInput("Test", reqPageData))
reqWarn =  Numeric(GetInput("Warn", reqPageData))
reqOptions2 =  GetInput("Options2", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 52
reqSysUserStatus = GetCache("USERSTATUS")
reqSysUserName = GetCache("USERNAME")

'-----get language settings
reqLangDefault = "en"
reqSysLanguage = GetInput("SysLanguage", reqPageData)
If Len(reqSysLanguage) = 0 Then
   reqSysLanguage = GetCache("LANGUAGE")
   If Len(reqSysLanguage) = 0 Then
      GetLanguage reqLangDialect, reqLangCountry, reqLangDefault
      If len(reqLangDialect) > 0 Then
         reqSysLanguage = reqLangDialect
      ElseIf len(reqLangCountry) > 0 Then
         reqSysLanguage = reqLangCountry
      Else
         reqSysLanguage = reqLangDefault
      End If
      SetCache "LANGUAGE", reqSysLanguage
   End If
Else
   SetCache "LANGUAGE", reqSysLanguage
End If


tmpUserAgent = Request.ServerVariables("HTTP_USER_AGENT")
If InStr(tmpUserAgent, "MSIE 8.0" ) > 0 OR InStr(tmpUserAgent, "MSIE 9.0" ) > 0 Then reqWarn = 1


If (reqWarn <> 0) Then
   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "BrowserWarning.htm"
         .Path = reqSysWebDirectory + "Sections\"
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLWarn = .XML("HTMLWarn")
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
End If
If (reqTest <> 0) Then
   Response.write Request.Cookies("temppts")
End If
If (reqSysUserGroup = 41) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqIdentify = GetCache("IDENTIFY")
      If (reqMemberID <> reqSysMemberID) Then
         reqSysMemberID = reqMemberID
         SetCache "MEMBERID", reqSysMemberID
         reqNewMember = 1
      End If
      If (reqEmployeeID > 0) Then
         reqNewMember = 1

         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (xmlError = "") Then
                  reqSysUserGroup = 41
                  SetCache "USERGROUP", reqSysUserGroup
                  reqSysUserID = .AuthUserID
                  SetCache "USERID", reqSysUserID
                  reqSysMemberID = reqMemberID
                  SetCache "MEMBERID", reqSysMemberID
                  reqSysCompanyID = .CompanyID
                  SetCache "COMPANYID", reqSysCompanyID
                  reqSysNavBarImage = "Images/Company/" + CSTR(reqSysCompanyID) + "/navbarimage.gif"
                  SetCache "NAVBARIMAGE", reqSysNavBarImage
                  SetCache "SECURITYLEVEL", .Secure
                  SetCache "USERMODE", reqSysUserMode
                  tmpAccess = LimitedAccess( .AccessLimit )
                  If (tmpAccess = 0) Then
                     DoError -2147220514, "", "Oops, Your access to the system has been limited - Access Denied."
                  End If
               End If
            End With
         End If
         Set oMember = Nothing
      End If
      If (reqNewMember = 1) Then

         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               SetCache "VISITDATE", .VisitDate
               tmpCompanyID = .CompanyID
               tmpStatus = .Status
               tmpLevel = .Level
               tmpMemberOptions = .Options
            End With
         End If
         Set oMember = Nothing

         If (xmlError = "") Then
            Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
            If oCoption Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
            Else
               With oCoption
                  .SysCurrentLanguage = reqSysLanguage
                  .FetchCompany tmpCompanyID
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .Load .CoptionID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (tmpLevel = 0) Then
                     CompanyOptions = .FreeOptions
                  End If
                  If (tmpLevel = 1) Then
                     CompanyOptions = .Options
                  End If
                  If (tmpLevel = 2) Then
                     CompanyOptions = .Options2
                  End If
                  If (tmpLevel = 3) Then
                     CompanyOptions = .Options3
                  End If
                  reqSysUserOptions = GetUserOptions(CompanyOptions, tmpMemberOptions)
                  SetCache "USEROPTIONS", reqSysUserOptions
               End With
            End If
            Set oCoption = Nothing
         End If
      End If
      
      If reqVisitDate = "" Then reqVisitDate = GetCache("VISITDATE")


      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            reqLevel = .Level
            reqOptions2 = .Options2
            tmpTitle = .Title
            tmpIcons = .Icons
            tmpRef = .Reference
            tmpLogon = .Logon
            If (InStr(reqSysUserOptions,"(") <> 0) Then
               tmpSocNet = .SocNet
            End If
            If (.MemberID = .GroupID) Then
               reqGroupID = .GroupID
            End If
            If (tmpTitle = 1) Then
               reqSysUserOptions = Replace(reqSysUserOptions,"A","")
               reqSysUserOptions = Replace(reqSysUserOptions,"o","")
               SetCache "USEROPTIONS", reqSysUserOptions
            End If
            
            tmp = Replace(.Identification, ",", "" )
            If tmp <> "" Then reqIdentify = 0

            tmpAuthUserID = .AuthUserID
            If (.Status <> 1) And (.Level <> 1) And (.Billing = 3) Then
               reqUpgrade = 1
            End If
            If (InStr(reqSysUserOptions,"i") <> 0) Then
               xmlDB = .Dashboard(CLng(reqMemberID), CLng(reqSysUserID), CDate(reqVisitDate), reqSysUserOptions)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            xmlMember = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
'tmpIcons = "EFGHIKL26ahow"
               xmlIcons = "<ICONS>"
               While tmpIcons <> "" 
                  tmpIcon = Left(tmpIcons, 1)
                  tmpIcons = Mid(tmpIcons, 2)
                  tmpName = ""
                  tmpFile = ""
                  tmpURL = ""
                  Select Case tmpIcon
                     Case "E"
                        If InStr(reqSysUserOptions,"E") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Sales"" file=""IconE.gif"" url=""8101.asp?memberid=" + CStr(reqMemberID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "F"
                        If InStr(reqSysUserOptions,"F") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Projects"" file=""IconF.gif"" url=""7501.asp?memberid=" + CStr(reqMemberID) + "&amp;companyid=" + CStr(reqCompanyID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "G"
                        If InStr(reqSysUserOptions,"G") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Mentoring"" file=""IconG.gif"" url=""0410.asp?memberid=" + CStr(reqMemberID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "H"
                        If InStr(reqSysUserOptions,"H") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Goals"" file=""IconH.gif"" url=""7001.asp?memberid=" + CStr(reqMemberID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "I"
                        If InStr(reqSysUserOptions,"I") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""MyInfo"" file=""IconI.gif"" target=""MyInfo"" secure=""True"" url=""0463.asp?memberid=" + CStr(reqMemberID) + "&amp;contentpage=3&amp;popup=1" + """/>"
                        End If
                     Case "K"
                        If InStr(reqSysUserOptions,"K") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Classes"" file=""IconK.gif"" url=""1311.asp?memberid=" + CStr(reqMemberID) + "&amp;companyid=" + CStr(reqCompanyID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "L"
                        If InStr(reqSysUserOptions,"L") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Assessments"" file=""IconL.gif"" url=""3411.asp?memberid=" + CStr(reqMemberID) + "&amp;companyid=" + CStr(reqCompanyID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "2"
                        If InStr(reqSysUserOptions,"2") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Calendar"" file=""Icon2.gif"" target=""Calendar"" url=""Calendar.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "6"
                        If InStr(reqSysUserOptions,"6") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Customers"" file=""Icon6.gif"" url=""8151.asp?memberid=" + CStr(reqMemberID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "a"
                        If InStr(reqSysUserOptions,"a") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Resources"" file=""Icon_a.gif"" url=""9304.asp?memberid=" + CStr(reqMemberID) + "&amp;GroupID=" + reqGroupID + "&amp;grpcompanyid=" + CSTR(reqCompanyID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "h"
                        If InStr(reqSysUserOptions,"h") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Leads"" file=""Icon_h.gif"" target=""Leads"" url=""8161.asp?memberid=" + CStr(reqMemberID) + "&amp;returnurl=0404.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "o"
                        If InStr(reqSysUserOptions,"o") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Genealogy"" file=""Icon_o.gif"" target=""Genealogy"" url=""0470.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "w"
                        If InStr(reqSysUserOptions,"w") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Finances"" file=""Icon_w.gif"" target=""Finances"" url=""0475.asp?contentpage=3&amp;popup=1&amp;memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "/"
                        If InStr(reqSysUserOptions,"/") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Expenses"" file=""Icon_ex.gif"" url=""6401.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                     Case "["
                        If InStr(reqSysUserOptions,"[") <> 0 Then
                           xmlIcons = xmlIcons + "<ICON name=""Performance"" file=""Performance48.gif"" target=""Performance"" url=""0445.asp?memberid=" + CStr(reqMemberID) + """/>"
                        End If
                  End Select
               Wend
               xmlIcons = xmlIcons + "</ICONS>"

         End With
      End If
      Set oMember = Nothing
      If (reqMemberID = 0) Then
         reqMemberID = reqSysMemberID
      End If
      If (reqCompanyID = 0) Then
         reqCompanyID = reqSysCompanyID
      End If

      If (reqCompanyID = 0) Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = "0404.htm"
               .Path = reqSysWebDirectory + "Sections\"
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If
      If (reqCompanyID > 0) Then
         tmpMemberPage = GetMemberOptions("MP")
         tmpGroupPage = GetMemberOptions("GP")

         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Path = reqSysWebDirectory + "Sections\Company/" + CStr(reqCompanyID)
               .Language = reqSysLanguage
               .Project = SysProject
               If (InStr(reqSysUserOptions,"~^") = 0) Then
                  If (reqCompanyID <> 5) Then
                     .Filename = "MemberNews" + CStr(reqLevel) + ".htm" 
                  End If
                  If (reqCompanyID = 5) Then
                     .Filename = "MemberNews" + CStr(reqLevel) + ".htm" 
                     If (tmpTitle = 1) Then
                        .Filename = "MemberNews" + CStr(reqLevel) + "r.htm" 
                     End If
                  End If
                  .Load 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpNews = .Data
                  If (reqCompanyID <> 5) Then
                     .Filename = tmpMemberPage
                  End If
                  If (reqCompanyID = 5) Then
                     .Filename = "Member.htm"
                     If (tmpTitle = 1) Then
                        .Filename = "Memberr.htm" 
                     End If
                  End If
                  .Load 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlHTMLFile = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (tmpGroupPage <> "") Then
                  .Filename = tmpGroupPage
                  .Load 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlHTMLMember = .XML("HTMLMember")
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oHTMLFile = Nothing
         
         xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqMemberID )
         xmlHTMLFile = Replace( xmlHTMLFile, "{lgn}", tmpLogon )
         xmlHTMLFile = Replace( xmlHTMLFile, "{news}", tmpNews )
'         xmlHTMLFile = Replace( xmlHTMLFile, "{eref}", Encript(tmpRef) )
         xmlHTMLMember = Replace( xmlHTMLMember, "{id}", reqMemberID )
         xmlHTMLMember = Replace( xmlHTMLMember, "{lgn}", tmpLogon )
'         xmlHTMLMember = Replace( xmlHTMLMember, "{eref}", Encript(tmpRef) )

         If InStr( reqOptions2, "M" ) = 0 Then
            repl = ""
         Else    
            repl = "<a href=""money.asp?memberid=" + CStr(reqMemberID) + """ target=""money""><img border=""0"" hspace=""0"" src=""http://www.cloudzow.com/Images/zowmoney.gif""><br>My ZowFinance</a>"
         End If   
         xmlHTMLFile = Replace( xmlHTMLFile, "{money}", repl )
         If InStr( reqOptions2, "U" ) = 0 Then
            repl = ""
         Else    
            repl = "<a href=""university.asp?memberid=" + CStr(reqMemberID) + """ target=""university""><img border=""0"" hspace=""0"" src=""http://www.cloudzow.com/Images/zowuniversity.gif""><br>My ZowUniversity</a>"
         End If   
         xmlHTMLFile = Replace( xmlHTMLFile, "{university}", repl )

      End If

      If (InStr(reqSysUserOptions,"s") <> 0) Then
         Set oShortcuts = server.CreateObject("ptsShortcutUser.CShortcuts")
         If oShortcuts Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsShortcutUser.CShortcuts"
         Else
            With oShortcuts
               .SysCurrentLanguage = reqSysLanguage
               .ListPinned tmpAuthUserID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlShortcuts = .XML(13)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oShortcuts = Nothing
      End If
      If (InStr(reqSysUserOptions,"(") <> 0) Then
         
If xmlShortcuts = "<PTSSHORTCUTS/>" OR  xmlShortcuts = "" Then 
   xmlShortcuts = "<PTSSHORTCUTS>" 
Else
   xmlShortcuts = Left(xmlShortcuts, Len(xmlShortcuts) - 15 )
End If   
If InStr(tmpSocNet, ":") > 0 Then
   aSocNets = split(tmpSocNet, ":")
   total = UBOUND(aSocNets)
   For x = 0 to total
      aSocNet = split(aSocNets(x), ";")
      user = CleanXML(TRIM(aSocNet(1)))
      If user <> "" Then
         Select Case aSocNet(0)
            Case "FB": 
               shortcut = "<PTSSHORTCUT entityid=""101"" shortcutname=""FaceBook"" url=""http://www.facebook.com/" + user + """ ispopup=""1""/>"
            Case "MS": 
               shortcut = "<PTSSHORTCUT entityid=""102"" shortcutname=""MySpace"" url=""http://www.myspace.com/" + user + """ ispopup=""1""/>"
            Case "TW": 
               shortcut = "<PTSSHORTCUT entityid=""103"" shortcutname=""Twitter"" url=""http://www.twitter.com/" + user + """ ispopup=""1""/>"
            Case "LI": 
               shortcut = "<PTSSHORTCUT entityid=""104"" shortcutname=""LinkedIn"" url=""http://www.linkedin.com/in/" + user + """ ispopup=""1""/>"
         End Select
         xmlShortcuts = xmlShortcuts + shortcut
      End If   
   Next
End If
xmlShortcuts = xmlShortcuts + "</PTSSHORTCUTS>"

      End If

      If (InStr(reqSysUserOptions,"i") <> 0) And (InStr(reqSysUserOptions,"2") <> 0) Then
         Set oAppts = server.CreateObject("ptsApptUser.CAppts")
         If oAppts Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppts"
         Else
            With oAppts
               .SysCurrentLanguage = reqSysLanguage
               .ListToday CLng(reqMemberID), CDate(reqSysDate), reqSysUserOptions
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
         'calculate and store day and time
         For Each oAppt in oAppts
            With oAppt
               .Opt = "0"
               If .StartDate <> .EndDate Then .Opt = "1"
               If .IsEdit <> "0" Then .Opt = "2"
               If .IsAllDay = 0 Then .ApptName = .StartTime + " " + .ApptName
               'convert ApptID for other types
               Select Case .ApptType
                  Case "-70" 
                     .ApptID = CLng(.ApptID) mod 700000000 'Goals 
                     'If the goal date has happened yet, don't mark status 
                     If CDate(.StartDate) >= Date() And .Status <> "3" Then .Status = 0
                  Case "-701" 
                     .ApptID = CLng(.ApptID) mod 700000000 'Service Goals 
                     'If the goal date has happened yet, don't mark status 
                     If CDate(.StartDate) >= Date() And .Status <> "3" Then .Status = 0
                  Case "-22" 
                     .ApptID = CLng(.ApptID) mod 220000000 'Leads 
                     If CDate(.StartDate) < Date() Then .CalendarID = 1 Else .CalendarID = 0
                  Case "-81" 
                     .ApptID = CLng(.ApptID) mod 810000000 'Sales 
                     If CDate(.StartDate) < Date() Then .CalendarID = 1 Else .CalendarID = 0
                  Case "-96" 
                     .ApptID = CLng(.ApptID) mod 960000000 'Events
                  Case "-75" 
                     .ApptID = CLng(.ApptID) mod 750000000 'Projects 
                     'If the project date has happened yet, don't mark status 
                     If CDate(.StartDate) >= Date() And .Status <> "2" Then .Status = 0
                  Case "-74" 
                     .ApptID = CLng(.ApptID) mod 740000000 'Tasks 
                     'If the task date has happened yet, don't mark status 
                     If CDate(.StartDate) >= Date() And .Status <> "2" Then .Status = 0
               End Select
               'Calculate the Military Time for sorting the appts 
               If .StartTime = "" Then 
                  .Reminder = 0
               Else
                  tmpTime = .StartTime
                  newTime = "0"
                  length = Len(tmpTime)
                  For x = 1 to length
                     c = Mid(tmpTime, x, 1)
                     If IsNumeric(c) Then newTime = newTime + c
                  Next
                  If Left(newTime,3) = "012" Then
                     If InStr(UCase(tmpTime), "A") Then 
                        newTime = "0" + Mid(tmpTime, 3,2)
                     End If
                  Else
                     If InStr(UCase(tmpTime), "P") Then 
                        newTime = (Clng(newTime) + 1200)
                     End If
                  End If
                  .Reminder = newTime
               End If   
            End With
         Next

               xmlAppts = xmlAppts + .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAppts = Nothing
      End If

      If (InStr(reqSysUserOptions,"i") <> 0) And (InStr(reqSysUserOptions,"H") <> 0) Then
         Set oGoals = server.CreateObject("ptsGoalUser.CGoals")
         If oGoals Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoals"
         Else
            With oGoals
               .SysCurrentLanguage = reqSysLanguage
               .ListActiveTrack CLng(reqMemberID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlGoals = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oGoals = Nothing
      End If
End Select

'-----get system data
xmlSystem = "<SYSTEM"
xmlSystem = xmlSystem + " headerimage=" + Chr(34) + reqSysHeaderImage + Chr(34)
xmlSystem = xmlSystem + " footerimage=" + Chr(34) + reqSysFooterImage + Chr(34)
xmlSystem = xmlSystem + " returnimage=" + Chr(34) + reqSysReturnImage + Chr(34)
xmlSystem = xmlSystem + " navbarimage=" + Chr(34) + reqSysNavBarImage + Chr(34)
xmlSystem = xmlSystem + " headerurl=" + Chr(34) + reqSysHeaderURL + Chr(34)
xmlSystem = xmlSystem + " returnurl=" + Chr(34) + CleanXML(reqSysReturnURL) + Chr(34)
xmlSystem = xmlSystem + " language=" + Chr(34) + reqSysLanguage + Chr(34)
xmlSystem = xmlSystem + " langdialect=" + Chr(34) + reqLangDialect + Chr(34)
xmlSystem = xmlSystem + " langcountry=" + Chr(34) + reqLangCountry + Chr(34)
xmlSystem = xmlSystem + " langdefault=" + Chr(34) + reqLangDefault + Chr(34)
xmlSystem = xmlSystem + " userid=" + Chr(34) + CStr(reqSysUserID) + Chr(34)
xmlSystem = xmlSystem + " usergroup=" + Chr(34) + CStr(reqSysUserGroup) + Chr(34)
xmlSystem = xmlSystem + " userstatus=" + Chr(34) + CStr(reqSysUserStatus) + Chr(34)
xmlSystem = xmlSystem + " username=" + Chr(34) + CleanXML(reqSysUserName) + Chr(34)
xmlSystem = xmlSystem + " customerid=" + Chr(34) + CStr(reqSysCustomerID) + Chr(34)
xmlSystem = xmlSystem + " employeeid=" + Chr(34) + CStr(reqSysEmployeeID) + Chr(34)
xmlSystem = xmlSystem + " affiliateid=" + Chr(34) + CStr(reqSysAffiliateID) + Chr(34)
xmlSystem = xmlSystem + " affiliatetype=" + Chr(34) + CStr(reqSysAffiliateType) + Chr(34)
xmlSystem = xmlSystem + " actioncode=" + Chr(34) + CStr(reqActionCode) + Chr(34)
xmlSystem = xmlSystem + " confirm=" + Chr(34) + CStr(reqConfirm) + Chr(34)
xmlSystem = xmlSystem + " pageData=" + Chr(34) + CleanXML(reqPageData) + Chr(34)
xmlSystem = xmlSystem + " pageURL=" + Chr(34) + CleanXML(reqPageURL) + Chr(34)
xmlSystem = xmlSystem + " currdate=" + Chr(34) + reqSysDate + Chr(34)
xmlSystem = xmlSystem + " currtime=" + Chr(34) + reqSysTime + Chr(34)
xmlSystem = xmlSystem + " currtimeno=" + Chr(34) + reqSysTimeno + Chr(34)
xmlSystem = xmlSystem + " servername=" + Chr(34) + reqSysServerName + Chr(34)
xmlSystem = xmlSystem + " serverpath=" + Chr(34) + reqSysServerPath + Chr(34)
xmlSystem = xmlSystem + " webdirectory=" + Chr(34) + reqSysWebDirectory + Chr(34)
xmlSystem = xmlSystem + " companyid=" + Chr(34) + CStr(reqSysCompanyID) + Chr(34)
xmlSystem = xmlSystem + " trainerid=" + Chr(34) + CStr(reqSysTrainerID) + Chr(34)
xmlSystem = xmlSystem + " memberid=" + Chr(34) + CStr(reqSysMemberID) + Chr(34)
xmlSystem = xmlSystem + " orgid=" + Chr(34) + CStr(reqSysOrgID) + Chr(34)
xmlSystem = xmlSystem + " usermode=" + Chr(34) + CStr(reqSysUserMode) + Chr(34)
xmlSystem = xmlSystem + " useroptions=" + Chr(34) + reqSysUserOptions + Chr(34)
xmlSystem = xmlSystem + " ga_acctid=" + Chr(34) + reqSysGA_ACCTID + Chr(34)
xmlSystem = xmlSystem + " ga_domain=" + Chr(34) + reqSysGA_DOMAIN + Chr(34)
xmlSystem = xmlSystem + " />"
xmlOwner = "<OWNER"
xmlOwner = xmlOwner + " id=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlOwner = xmlOwner + " title=" + Chr(34) + CleanXML(reqOwnerTitle) + Chr(34)
xmlOwner = xmlOwner + " entity=" + Chr(34) + CStr(reqOwner) + Chr(34)
xmlOwner = xmlOwner + " />"
xmlConfig = "<CONFIG"
xmlConfig = xmlConfig + " isdocuments=" + Chr(34) + GetCache("ISDOCUMENTS") + Chr(34)
xmlConfig = xmlConfig + " documentpath=" + Chr(34) + GetCache("DOCUMENTPATH") + Chr(34)
xmlConfig = xmlConfig + " />"
xmlParam = "<PARAM"
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " employeeid=" + Chr(34) + CStr(reqEmployeeID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " upgrade=" + Chr(34) + CStr(reqUpgrade) + Chr(34)
xmlParam = xmlParam + " tbimage=" + Chr(34) + CleanXML(reqTBImage) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " newmember=" + Chr(34) + CStr(reqNewMember) + Chr(34)
xmlParam = xmlParam + " visitdate=" + Chr(34) + CleanXML(reqVisitDate) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " level=" + Chr(34) + CStr(reqLevel) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " warn=" + Chr(34) + CStr(reqWarn) + Chr(34)
xmlParam = xmlParam + " options2=" + Chr(34) + CleanXML(reqOptions2) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlShortcuts
xmlTransaction = xmlTransaction +  xmlAppts
xmlTransaction = xmlTransaction +  xmlGoals
xmlTransaction = xmlTransaction +  xmlHTMLMember
xmlTransaction = xmlTransaction +  xmlHTMLWarn
xmlTransaction = xmlTransaction +  xmlDB
xmlTransaction = xmlTransaction +  xmlIcons
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\0404[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\0404[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0404 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

'-----append common labels
fileLanguage = "Language\Common[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Common[en].xml"
End If
Set oCommon = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oCommon.load server.MapPath(fileLanguage)
If oCommon.parseError <> 0 Then
   Response.Write "0404 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
   Response.End
End If
Set oLabels = oCommon.selectNodes("LANGUAGE/LABEL")
For Each oLabel In oLabels
Set oAdd = oLanguage.selectSingleNode("LANGUAGE").appendChild(oLabel.cloneNode(True))
Set oAdd = Nothing
Next
xmlLanguage = oLanguage.XML
Set oLanguage = Nothing

'-----If there is an Error, get the Error Labels XML
If xmlError <> "" Then
fileLanguage = "Language\Error[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Error[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0404 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlSystem
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlOwner
xmlData = xmlData +  xmlConfig
xmlData = xmlData +  xmlParent
xmlData = xmlData +  xmlBookmark
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "0404.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0404 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0404 Load file (oData) failed with error code " + CStr(oData.parseError)
   Response.Write "<BR/>" + xmlData
   Response.End
End If

If Len(reqSysTestFile) > 0 Then
   oData.save reqSysTestFile
End If

'-----transform the XML with the XSL
Response.Write oData.transformNode(oStyle)

Set oData = Nothing
Set oStyle = Nothing
Set oLanguage = Nothing
%>