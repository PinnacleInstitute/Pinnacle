<!--#include file="Include\System.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
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
Dim oMember, xmlMember
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqMember2FA
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
   SetCache "m_MemberDashboardURL", reqReturnURL
   SetCache "m_MemberDashboardDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_memberdashboard")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMember2FA =  Numeric(GetInput("Member2FA", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0
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

If (reqSysUserGroup = 41) Then
   reqMember2FA = Is2FA(reqSysUserID)
End If
If (reqSysUserGroup <> 41) Then
   reqMember2FA = 1
End If
If (reqSysUserGroup = 41) Then
   If (reqMemberID = 0) Then
      reqMemberID = reqSysMemberID
   End If
   If (reqMemberID <> reqSysMemberID) Then
      AbortUser()
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqMemberID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqSysUserGroup = 41) And (.Status > 3) Then
               AbortUser()
            End If
            reqCompanyID = .CompanyID
            tmpLevel = .Level
            tmpLogon = .Logon
            tmpName = .NameFirst + " " + .NameLast
            tmpReferralID = .ReferralID
            xmlMember = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqCompanyID = 21) Then
               tmpPersonalPoints = INT(.MasterPrice)
               tmpTeamPoints = .MasterMembers
               If (tmpLevel = 0) Then
                  .Load tmpReferralID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpSignature = .Signature
               End If
            End If
         End With
      End If
      Set oMember = Nothing
      tmpMemberPage = GetMemberOptions("MP")

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
            .Language = reqSysLanguage
            .Project = SysProject
            .Filename = tmpMemberPage
            If (.Filename = "") Then
               .Filename = "member.htm"
            End If
            .Filename = "m_" + .Filename
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqMemberID )
            xmlHTMLFile = Replace( xmlHTMLFile, "{lgn}", tmpLogon )
            xmlHTMLFile = Replace( xmlHTMLFile, "{name}", tmpName )
          
         End With
      End If
      Set oHTMLFile = Nothing
      If (reqCompanyID = 21) Then
         If (tmpLevel = 0) Then
            
              xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", tmpSignature )
            
         End If
         If (tmpLevel = 1) Then

            Set oNexxus = server.CreateObject("ptsNexxusUser.CNexxus")
            If oNexxus Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsNexxusUser.CNexxus"
            Else
               With oNexxus
                  .SysCurrentLanguage = reqSysLanguage
                  Result = .Custom(500, 0, reqMemberID, 0)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  
                a = Split(Result, "|")
                tmpStatus = a(0)
                tmpPaymentID = a(1)
                tmpAmount = a(2)
              
                  Result = .Custom(8, 0, reqMemberID, 0)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oNexxus = Nothing
            
              If tmpStatus = 0 Then strDisplay = "none" Else strDisplay = "block"
              If tmpStatus = 1 Then strPayment = "First"
              If tmpStatus = 2 Then strPayment = "Next"
              strAmount = FormatCurrency(tmpAmount)
              xmlHTMLFile = Replace( xmlHTMLFile, "{display}", strDisplay )
              xmlHTMLFile = Replace( xmlHTMLFile, "{amount}", strAmount )
              xmlHTMLFile = Replace( xmlHTMLFile, "{payment}", strPayment )

              If reqMember2FA = 0 Then strDisplay = "block" Else strDisplay = "none"
              xmlHTMLFile = Replace( xmlHTMLFile, "{display2FA}", strDisplay )

              tmpToday = FormatDateTime(reqSysDate,1)
              aSection = Split( Result, "|")
              a1 = Split( aSection(0), ";")
              a2 = Split( aSection(1), ";")
              a3 = Split( aSection(2), ";")
              a4 = Split( aSection(3), ";")
              a5 = Split( aSection(4), ";")
              a6 = Split( aSection(5), ";")
              a7 = Split( aSection(6), ";")
              a8 = Split( aSection(7), ";")
              a9 = Split( aSection(8), ";")
              a10 = Split( aSection(9), ";")
              a11 = Split( aSection(10), ";")
              tmpTeam3 = FormatCurrency(a3(2))
              tmpTeam4 = FormatCurrency(a3(3))
              tmpFinance1 = FormatCurrency(a4(0))
              tmpFinance2 = FormatCurrency(a4(1))
              tmpFinance3 = FormatCurrency(a4(2))
              tmpFinance4 = FormatCurrency(a4(3))
              tmpQualify5 = FormatCurrency(a5(4))
              tmpAdvance2 = a6(1)
              If tmpAdvance2 = "1" Then tmpAdvance2 = "1 Referral" Else tmpAdvance2 = FormatCurrency(tmpAdvance2) + " GV"
              tmpCert1 = FormatCurrency(a10(4))
              tmpCert2 = FormatCurrency(a10(5))
              tmpCert3 = FormatCurrency(a10(6))
              tmpCert4 = FormatCurrency(a10(7))
              tmpCert5 = a10(8)
              tmpMember3 =  a1(2)
              If tmpMember3 <> "" Then tmpMember3 = "Founding Affiliate (" + tmpMember3 + ")<BR>"
              tmpMember4 =  a1(3)
              If tmpMember4 <> "" Then tmpMember4 = "Fast Start Days: <B>" + tmpMember4 + " (pts:" + CSTR(tmpPersonalPoints) + "/" + CSTR(tmpTeamPoints) + ")" + "</B><BR>"
              tmpProduct4 =  a2(3)
              If tmpProduct4 <> "" Then tmpProduct4 = "Certified Cryptocurrency<BR>Specialist - CCS (" + tmpProduct4 + ")<BR>"

              xmlHTMLFile = Replace( xmlHTMLFile, "{today}", tmpToday )
              xmlHTMLFile = Replace( xmlHTMLFile, "{member1}", a1(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{member2}", a1(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{member3}", tmpMember3 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{member4}", tmpMember4 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{product1}", a2(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{product2}", a2(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{product3}", a2(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{product4}", tmpProduct4 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{team1}", a3(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{team2}", a3(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{team3}", tmpTeam3 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{team4}", tmpTeam4 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{finance1}", tmpFinance1 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{finance2}", tmpFinance2 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{finance3}", tmpFinance3 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{finance4}", tmpFinance4 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify1}", a5(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify2}", a5(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify3}", a5(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify4}", a5(3) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify5}", tmpQualify5 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{qualify6}", a5(5) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{advance1}", a6(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{advance2}", tmpAdvance2 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{advance3}", a6(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{advance4}", a6(3) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader1a}", a7(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader1b}", a7(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader2a}", a7(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader2b}", a7(3) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader3a}", a7(4) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader3b}", a7(5) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader4a}", a7(6) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{leader4b}", a7(7) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{ticket1}", a8(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{ticket2}", a8(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{market1}", a9(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{market2}", a9(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{market3}", a9(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{market4}", a9(3) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert1}", a10(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert2}", a10(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert3}", a10(2) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert4}", a10(3) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert1m}", tmpCert1 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert2m}", tmpCert2 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert3m}", tmpCert3 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert4m}", tmpCert4 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{cert5}", tmpCert5 )
              xmlHTMLFile = Replace( xmlHTMLFile, "{reward1}", a11(0) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{reward2}", a11(1) )
              xmlHTMLFile = Replace( xmlHTMLFile, "{reward3}", a11(2) )

              If a11(3) = 1 Then strDisplay = "show" Else strDisplay = "none"
              xmlHTMLFile = Replace( xmlHTMLFile, "{DisplayShoppers}", strDisplay )
              If a11(4) = 1 Then strDisplay = "show" Else strDisplay = "none"
              xmlHTMLFile = Replace( xmlHTMLFile, "{DisplayMerchants}", strDisplay )

            
         End If
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " member2fa=" + Chr(34) + CStr(reqMember2FA) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Business[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Business[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_MemberDashboard Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_MemberDashboard Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_MemberDashboard Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_MemberDashboard.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_MemberDashboard Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_MemberDashboard Load file (oData) failed with error code " + CStr(oData.parseError)
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