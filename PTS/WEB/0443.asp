<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
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
Dim oTitles, xmlTitles
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqParentID
Dim reqcontentpage
Dim reqPopup
Dim reqRefName
Dim reqOptions
Dim reqMemberOptions
Dim reqStatus
Dim reqVisitDate
Dim reqIdentify
Dim reqAuthUserID
Dim reqGroupID
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
   SetCache "0443URL", reqReturnURL
   SetCache "0443DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0443")
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
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
reqcontentpage =  Numeric(GetInput("contentpage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqRefName =  GetInput("RefName", reqPageData)
reqOptions =  GetInput("Options", reqPageData)
reqMemberOptions =  GetInput("MemberOptions", reqPageData)
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqVisitDate =  GetInput("VisitDate", reqPageData)
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqAuthUserID =  Numeric(GetInput("AuthUserID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
tmpUserGroup = 0
tmpIsDiscount = 0
reqcontentpage = 3
reqPopup = 1
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 61
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

Sub UpdateMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqParentID = .ReferralID
         reqStatus = .Status
         reqVisitDate = .VisitDate
         reqAuthUserID = .AuthUserID
         tmpUserGroup = .UserGroup
         tmpIsDiscount = .IsDiscount
         oldStatus = .Status
         oldTitle = .Title
         oldReferralID = .ReferralID
         oldSponsorID = .SponsorID

         .ReferralID = Request.Form.Item("ReferralID")
         .MentorID = Request.Form.Item("MentorID")
         .SponsorID = Request.Form.Item("SponsorID")
         .Sponsor2ID = Request.Form.Item("Sponsor2ID")
         .Sponsor3ID = Request.Form.Item("Sponsor3ID")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .IsCompany = Request.Form.Item("IsCompany")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Email2 = Request.Form.Item("Email2")
         .EnrollDate = Request.Form.Item("EnrollDate")
         .EndDate = Request.Form.Item("EndDate")
         .PaidDate = Request.Form.Item("PaidDate")
         .Status = Request.Form.Item("Status")
         .IsRemoved = Request.Form.Item("IsRemoved")
         .Level = Request.Form.Item("Level")
         .TrialDays = Request.Form.Item("TrialDays")
         .StatusDate = Request.Form.Item("StatusDate")
         .StatusChange = Request.Form.Item("StatusChange")
         .LevelChange = Request.Form.Item("LevelChange")
         .Title = Request.Form.Item("Title")
         .MinTitle = Request.Form.Item("MinTitle")
         .TitleDate = Request.Form.Item("TitleDate")
         .Qualify = Request.Form.Item("Qualify")
         .QualifyDate = Request.Form.Item("QualifyDate")
         .GroupID = Request.Form.Item("GroupID")
         .Reference = Request.Form.Item("Reference")
         newStatus = .Status
         newTitle = .Title
         newReferralID = .ReferralID
         newSponsorID = .SponsorID
         If (newSponsorID <> 0) And (newSponsorID <> oldSponsorID) Then
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0437.asp?MemberID=" & reqMemberID
               oHTTP.send
            End If
            Set oHTTP = Nothing

         End If
         If (.CompanyName = "") Then
            .CompanyName = .NameLast + ", " + .NameFirst
         End If
         If (.EndDate = "0") And (.Status = 5) Then
            .EndDate = Now
         End If
         If ((.Status = 1) Or (.Status = 2)) And (.Level = 0) Then
            .Level = 1
         End If
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (newTitle <> oldTitle) Then

            Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
            If oMemberTitle Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
            Else
               With oMemberTitle
                  .SysCurrentLanguage = reqSysLanguage
                  .MemberID = reqMemberID
                  .TitleDate = Now
                  .Title = newTitle
                  .Add CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oMemberTitle = Nothing
         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing
End Sub

Sub LoadMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqStatus = .Status
         reqMemberOptions = .Options
         tmpLevel = .Level
         reqVisitDate = .VisitDate
         reqAuthUserID = .AuthUserID
         tmpUserGroup = .UserGroup
         tmpIsDiscount = .IsDiscount
         If (.MemberID = .GroupID) Then
            reqGroupID = .GroupID
         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   If (reqCompanyID > 0) Then
      Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
      If oCoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
      Else
         With oCoption
            .SysCurrentLanguage = reqSysLanguage
            .FetchCompany CLng(reqCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqRefName = .RefName
            reqIdentify = .Identify
            tmpInputOptions = .InputOptions
            If (tmpInputOptions <> "") Then
            End If
            If (tmpLevel = 0) Then
               reqOptions = .FreeOptions
            End If
            If (tmpLevel = 1) Then
               reqOptions = .Options
            End If
            If (tmpLevel = 2) Then
               reqOptions = .Options2
            End If
            If (tmpLevel = 3) Then
               reqOptions = .Options3
            End If
            reqMemberOptions = reqMemberOptions + reqOptions
         End With
      End If
      Set oCoption = Nothing
   End If

   If (InStr(reqSysUserOptions,"v") <> 0) Or (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
      Set oTitles = server.CreateObject("ptsTitleUser.CTitles")
      If oTitles Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTitleUser.CTitles"
      Else
         With oTitles
            .SysCurrentLanguage = reqSysLanguage
            xmlTitles = xmlTitles + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oTitles = Nothing
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadMember

   Case CLng(cActionUpdate):
      UpdateMember
      LoadMember
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
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqcontentpage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " refname=" + Chr(34) + CleanXML(reqRefName) + Chr(34)
xmlParam = xmlParam + " options=" + Chr(34) + CleanXML(reqOptions) + Chr(34)
xmlParam = xmlParam + " memberoptions=" + Chr(34) + CleanXML(reqMemberOptions) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " visitdate=" + Chr(34) + CStr(reqVisitDate) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " authuserid=" + Chr(34) + CStr(reqAuthUserID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlTitles
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
   Response.Write "0443 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0443 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0443 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
If (reqSysUserGroup <= 23) Then
s = "<MENU name=""MemberMenu"" type=""bar"" menuwidth=""120"">"
s=s+   "<ITEM label=""Personal"">"
s=s+      "<IMAGE name=""MyInfo.gif""/>"
         If (reqcontentpage = 0) Then
s=s+      "<ITEM label=""Home"">"
s=s+         "<LINK name=""0404"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""Icons"">"
s=s+         "<LINK name=""0431"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Resources"">"
s=s+         "<LINK name=""9304"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""GroupID"" value=""" & reqGroupID & """/>"
s=s+            "<PARAM name=""GrpCompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Mentoring"">"
s=s+         "<LINK name=""0410"" nodata=""true"" target=""Mentoring"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Genealogy"">"
s=s+         "<LINK name=""0470"" nodata=""true"" target=""Genealogy"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Goals"">"
s=s+         "<LINK name=""7001"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Calendar"">"
s=s+         "<LINK name=""Calendar"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Projects"">"
s=s+         "<LINK name=""7501"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""SupportTickets"">"
s=s+         "<LINK name=""9506"" nodata=""true"" target=""SupportTickets"">"
s=s+            "<PARAM name=""T"" value=""" & 04 & """/>"
s=s+            "<PARAM name=""I"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         If (reqIdentify <> 0) Then
s=s+      "<ITEM label=""Identification"">"
s=s+         "<LINK name=""0426"" nodata=""true"" target=""Identify"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (tmpIsDiscount <> 0) Then
s=s+      "<ITEM label=""Referrals"">"
s=s+         "<LINK name=""0408"" nodata=""true"">"
s=s+            "<PARAM name=""ReferralID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Finance"">"
s=s+      "<IMAGE name=""Finance.gif""/>"
s=s+      "<ITEM label=""SalesOrders"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""1""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Payments"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""2""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Bonuses"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""3""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Billing"">"
s=s+         "<LINK name=""1011"" nodata=""true"">"
s=s+            "<PARAM name=""OwnerType"" value=""" & 04 & """/>"
s=s+            "<PARAM name=""OwnerID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""AutoShip"">"
s=s+         "<LINK name=""0433"" nodata=""true"" target=""AutoShip"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Sales"">"
s=s+      "<IMAGE name=""Prospect.gif""/>"
s=s+      "<ITEM label=""LeadManager"">"
s=s+         "<LINK name=""8161"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""SalesSystem"">"
s=s+         "<LINK name=""8101"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Service"">"
s=s+         "<LINK name=""8151"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""PartyPlans"">"
s=s+         "<LINK name=""2511"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Training"">"
s=s+      "<IMAGE name=""Catalog.gif""/>"
s=s+      "<ITEM label=""Classes"">"
s=s+         "<LINK name=""1311"" nodata=""true"" target=""Classes"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""CertReport"">"
s=s+         "<LINK name=""3411"" nodata=""true"" target=""CertReport"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""TrainingBuddy"">"
s=s+         "<LINK name=""0440"" nodata=""true"" target=""Buddy"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""VisitDate"" value=""" & reqVisitDate & """/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Tools"">"
s=s+      "<IMAGE name=""Tools.gif""/>"
         If (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""ResetLogon"">"
s=s+         "<LINK name=""0104"" nodata=""true"">"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""ViewLogon"">"
s=s+         "<LINK name=""0113"" nodata=""true"">"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""IPs"">"
s=s+         "<LINK name=""7111"" nodata=""true"">"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Assign"">"
s=s+         "<LINK name=""8101"" nodata=""true"" target=""Assign"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""AssignID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""ImportCustomers"">"
s=s+         "<LINK name=""8116"" nodata=""true"" target=""Import"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""ExportCustomers"">"
s=s+         "<LINK name=""8117"" nodata=""true"" target=""Export"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlMemberMenu = s

End If
s = "<TAB name=""MemberTab"">"
s=s+   "<ITEM label=""ViewStatus"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabStatus',1))""/>"
s=s+   "</ITEM>"
      If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
s=s+   "<ITEM label=""Notes"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabNotes',1))""/>"
s=s+   "</ITEM>"
      End If
s=s+   "<ITEM label=""ViewGroup"" width=""100"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabGroup',1))""/>"
s=s+   "</ITEM>"
s=s+"</TAB>"
xmlMemberTab = s

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
xmlData = xmlData +  xmlMemberMenu
xmlData = xmlData +  xmlMemberTab
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "0443.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0443 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0443 Load file (oData) failed with error code " + CStr(oData.parseError)
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