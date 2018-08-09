<!--#include file="Include\System.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCancel = 3
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
Dim oCoption, xmlCoption
Dim oNote, xmlNote
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqEnroll
Dim reqTxn
Dim reqMemberID
Dim reqMembership
Dim reqStatus
Dim reqLevel
Dim reqTitle
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
   SetCache "0413URL", reqReturnURL
   SetCache "0413DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0413")
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
reqEnroll =  Numeric(GetInput("Enroll", reqPageData))
reqTxn =  Numeric(GetInput("Txn", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqMembership =  Numeric(GetInput("Membership", reqPageData))
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqTitle =  GetInput("Title", reqPageData)
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

Sub DeleteMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Delete CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub MemberActivate()
   On Error Resume Next

   If (reqEnroll = 0) Then
      Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
      If oCoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
      Else
         With oCoption
            .SysCurrentLanguage = reqSysLanguage
            .FetchCompany CLng(reqSysCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            CompanyTrialDays = .TrialDays
            If (reqLevel = 1) Then
               tmpPrice = .Price
               tmpRetail = .Retail
               reqSysUserOptions = .Options
               reqTitle = .PaidName
            End If
            If (reqLevel = 2) Then
               tmpPrice = .Price2
               tmpRetail = .Retail2
               reqSysUserOptions = .Options2
               reqTitle = .PaidName2
            End If
            If (reqLevel = 3) Then
               tmpPrice = .Price3
               tmpRetail = .Retail3
               reqSysUserOptions = .Options3
               reqTitle = .PaidName3
            End If
         End With
      End If
      Set oCoption = Nothing
   End If

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.ReferralID <> 0) Then
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0437.asp?MemberID=" & reqMemberID
               oHTTP.send
            End If
            Set oHTTP = Nothing

         End If
         If (reqEnroll = 1) Then
            If (reqMembership = 2) Then
               .Status = 1
            End If
            If (reqMembership = 1) Then
               .Status = reqStatus
            End If
         End If
         If (reqEnroll = 0) Then
            If (reqStatus = 0) Then
               reqStatus = .Status
               If (.Status = 2) Or (.Status = 5) Then
                  .Status = 1
               End If
               If (.Status = 3) Then
                  If (CompanyTrialDays = 0) Or (.TrialDays <> 0) Then
                     .Status = 1
                  End If
                  If (CompanyTrialDays <> 0) And (.TrialDays = 0) Then
                     .Status = 2
                  End If
               End If
            End If
            OldStatus = .Status
            If (reqStatus <> 0) Then
               .Status = reqStatus
            End If
            NewStatus = .Status
            If (.Status = 2) And (CompanyTrialDays <> 0) And (.TrialDays = 0) Then
               .TrialDays = CompanyTrialDays
               .PaidDate = DATEADD("d", CompanyTrialDays, reqSysDate)
               tmpUpgraded = "TRIAL"
            End If
            If (.Status = 2) Then
               tmpUpgraded = "TRIAL"
            End If
            If (.Status = 1) Then
               .PaidDate = reqSysDate
               tmpUpgraded = "PAID"
            End If
            OldLevel = .Level
            If (reqLevel <> 0) Then
               .Level = reqLevel
            End If
            If (reqLevel = 0) Then
               .Level = 1
            End If
            NewLevel = .Level
            .Price = tmpPrice
            .Retail = tmpRetail
            .VisitDate = Now
            .StatusChange = 0
            .StatusDate = 0
            .EndDate = 0
            reqSysUserMode = .Status
            SetCache "USERMODE", reqSysUserMode
            MemberOptions = .Options
            If (InStr(MemberOptions,"E") = 0) Then
               reqSysUserOptions = Replace(reqSysUserOptions, "E", "")
            End If
            If (InStr(reqSysUserOptions,"F") > 0) Then
               If (InStr(MemberOptions,"F") = 0) Then
                  reqSysUserOptions = Replace(reqSysUserOptions, "F", "")
               End If
               If (InStr(MemberOptions,"f") > 0) Then
                  reqSysUserOptions = reqSysUserOptions + "f"
               End If
            End If
            If (tmpBilling <> 3) Then
               reqSysUserOptions = Replace(reqSysUserOptions, "V", "")
            End If
            SetCache "USEROPTIONS", reqSysUserOptions
         End If
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqEnroll = 0) Then
            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         SetMemberOptions reqSysMemberID, reqSysCompanyID, reqSysLanguage
      End With
   End If
   Set oMember = Nothing

   If (xmlError = "") And (reqEnroll = 0) And (tmpUpgraded <> "") Then
      Set oNote = server.CreateObject("ptsNoteUser.CNote")
      If oNote Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
      Else
         With oNote
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            If (OldStatus = 2) Then
               .Notes = "TRIAL Upgraded to " + tmpUpgraded + " (IP:" + Request.ServerVariables("REMOTE_ADDR") + ")"
            End If
            If (OldStatus = 3) Then
               .Notes = "FREE Upgraded to " + tmpUpgraded + " (IP:" + Request.ServerVariables("REMOTE_ADDR") + ")"
            End If
            If (OldStatus = 5) Then
               .Notes = "REACTIVATED" + " (IP:" + Request.ServerVariables("REMOTE_ADDR") + ")"
            End If
            If (OldStatus = NewStatus) Then
               .Notes = "LEVEL Upgraded from " + OldLevel + " to " + NewLevel + " (IP:" + Request.ServerVariables("REMOTE_ADDR") + ")"
            End If
            .AuthUserID = 1
            .NoteDate = Now
            .OwnerType = 4
            .OwnerID = reqMemberID
            NoteID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oNote = Nothing
   End If

   If (reqSysCompanyID = 6) Or (reqSysCompanyID = 7) Then
      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(CLng(reqSysCompanyID), 100, 0, CLng(reqMemberID), 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing
   End If
End Sub

Sub SendMail()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpAuthUser = .AuthUserID
         tmpStatus = .Status
         tmpMemberID = .MemberID
         tmpCompanyID = .CompanyID
         tmpMasterID = .MasterID
         
                  tmpMemberAdded = .NameLast + ", " + .NameFirst

      End With
   End If
   Set oMember = Nothing

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
         tmpSendEmail = .IsNewEmail
      End With
   End If
   Set oCoption = Nothing
   If (xmlError = "") And (tmpAuthUser > 0) Then
      If (tmpSendEmail = 1) Then

         If (reqSysUserGroup = 99) Then
            Response.Redirect "0105.asp" & "?AuthUserID=" & tmpAuthUser & "&MailReturnURL=" & "0430.asp?MemberID=" & tmpMemberID & "%26Enroll=" & reqEnroll
         End If

         If (reqSysUserGroup <> 99) Then
            Response.Redirect "0105.asp" & "?AuthUserID=" & tmpAuthUser & "&MailReturnURL=" & "0402.asp?CompanyID=" & tmpCompanyID & "%26MemberAdded=" & tmpMemberAdded
         End If
      End If
      If (tmpSendEmail = 0) Then

         If (reqSysUserGroup = 99) Then
            Response.Redirect "0430.asp" & "?MemberID=" & tmpMemberID & "&Enroll=" & reqEnroll
         End If

         If (reqSysUserGroup <> 99) Then
            Response.Redirect "0402.asp" & "?CompanyID=" & tmpCompanyID & "&MasterID=" & tmpMasterID
         End If
      End If
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqEnroll = 1) Then
         If (reqTxn = 1) Then
            MemberActivate
            SendMail
         End If
         If (reqTxn = 0) Then
            DeleteMember
         End If
      End If
      If (reqEnroll = 0) Then
         If (reqTxn = 1) Then
            MemberActivate
         End If
      End If

   Case CLng(cActionCancel):
      If (reqTxn = 1) Then

         Response.Redirect "0404.asp"
      End If
      If (reqTxn = 0) Then

         If (reqEnroll = 1) Then
            Response.Redirect "0000.asp"
         End If

         If (reqEnroll = 0) Then
            Response.Redirect "0404.asp"
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
xmlParam = xmlParam + " enroll=" + Chr(34) + CStr(reqEnroll) + Chr(34)
xmlParam = xmlParam + " txn=" + Chr(34) + CStr(reqTxn) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " membership=" + Chr(34) + CStr(reqMembership) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " level=" + Chr(34) + CStr(reqLevel) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlNote
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Member[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Member[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0413 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0413 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0413 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0413.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0413 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0413 Load file (oData) failed with error code " + CStr(oData.parseError)
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