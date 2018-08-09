<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionFind = 5
Const cActionPrevious = 6
Const cActionNext = 7
Const cActionSearchMember = 8
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
Dim oContests, xmlContests
Dim oContest, xmlContest
Dim oMetrics, xmlMetrics
Dim oBookmark, xmlBookmark
'-----declare page parameters
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqCompanyID
Dim reqMemberID
Dim reqGroupID
Dim reqFromDate
Dim reqToDate
Dim reqTerm
Dim reqScope
Dim reqRpt
Dim reqPos
Dim reqContestID
Dim reqPrivate
Dim reqNoDates
Dim reqEnrollDate
Dim reqSearchMember
Dim reqOwnerContestID
Dim reqContestName
Dim reqCustom1
Dim reqCustom2
Dim reqCustom3
Dim reqCustom4
Dim reqCustom5
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
   SetCache "11710URL", reqReturnURL
   SetCache "11710DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "11710")
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
reqSearchText =  GetInput("SearchText", reqPageData)
reqFindTypeID =  Numeric(GetInput("FindTypeID", reqPageData))
reqBookmark =  GetInput("Bookmark", reqPageData)
reqDirection =  Numeric(GetInput("Direction", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqTerm =  Numeric(GetInput("Term", reqPageData))
reqScope =  Numeric(GetInput("Scope", reqPageData))
reqRpt =  Numeric(GetInput("Rpt", reqPageData))
reqPos =  Numeric(GetInput("Pos", reqPageData))
reqContestID =  Numeric(GetInput("ContestID", reqPageData))
reqPrivate =  Numeric(GetInput("Private", reqPageData))
reqNoDates =  Numeric(GetInput("NoDates", reqPageData))
reqEnrollDate =  GetInput("EnrollDate", reqPageData)
reqSearchMember =  GetInput("SearchMember", reqPageData)
reqOwnerContestID =  Numeric(GetInput("OwnerContestID", reqPageData))
reqContestName =  GetInput("ContestName", reqPageData)
reqCustom1 =  Numeric(GetInput("Custom1", reqPageData))
reqCustom2 =  Numeric(GetInput("Custom2", reqPageData))
reqCustom3 =  Numeric(GetInput("Custom3", reqPageData))
reqCustom4 =  Numeric(GetInput("Custom4", reqPageData))
reqCustom5 =  Numeric(GetInput("Custom5", reqPageData))
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

Sub LoadContests()
   On Error Resume Next

   Set oContests = server.CreateObject("ptsContestUser.CContests")
   If oContests Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsContestUser.CContests"
   Else
      With oContests
         .SysCurrentLanguage = reqSysLanguage
         xmlContests = .EnumContest(CLng(reqMemberID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  xmlContests = Replace(xmlContests, CHR(34) + " " + CHR(34), CHR(34) + "Show All" + CHR(34))
               
      End With
   End If
   Set oContests = Nothing
End Sub

reqFindTypeID = 11791
If (reqContestID = 0) Then
   reqContestID = reqOwnerContestID
End If
If (reqEnrollDate = "") Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqEnrollDate = DateValue(.EnrollDate)
      End With
   End If
   Set oMember = Nothing
End If
If (reqContestID = 0) And (reqActionCode = 0) Then
   If (reqMemberID = 0) Then
      reqMemberID = reqSysMemberID
   End If

   Set oContest = server.CreateObject("ptsContestUser.CContest")
   If oContest Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsContestUser.CContest"
   Else
      With oContest
         .SysCurrentLanguage = reqSysLanguage
         ContestID = CLng(.Active(CLng(reqMemberID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (ContestID <> 0) Then
            reqContestID = ContestID
         End If
      End With
   End If
   Set oContest = Nothing
End If
If (reqContestID <> 0) Then

   Set oContest = server.CreateObject("ptsContestUser.CContest")
   If oContest Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsContestUser.CContest"
   Else
      With oContest
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqContestID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqPrivate = .IsPrivate
         reqScope = 1
         If (.MemberID <> 0) Then
            reqScope = 2
         End If
         reqRpt = .Metric
         reqCustom1 = .Custom1
         reqCustom2 = .Custom2
         reqCustom3 = .Custom3
         reqCustom4 = .Custom4
         reqCustom5 = .Custom5
         reqContestName = .ContestName
         If (.StartDate <> "0") Then
            reqFromDate = .StartDate
            reqToDate = .EndDate
            reqNoDates = 1
            reqTerm = 0
         End If
         If (.StartDate = "0") Then
            reqNoDates = 0
            If (reqTerm = 0) Then
               reqTerm = 1
               reqFromDate = reqEnrollDate
               reqToDate = reqSysDate
            End If
         End If
      End With
   End If
   Set oContest = Nothing
End If
If (reqContestID = 0) And (reqTerm = 0) Then
   reqTerm = 1
   reqFromDate = reqEnrollDate
   reqToDate = reqSysDate
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqCompanyID = 0) Then
         reqCompanyID = reqSysCompanyID
      End If
      If (reqMemberID = 0) Then
         reqMemberID = reqSysMemberID
      End If
      If (reqGroupID = 0) Then
         reqGroupID = Numeric(GetCache("GROUPID"))
      End If
      If (reqContestID = 0) Then
         reqScope = 1
         If (reqGroupID <> 0) Then
            reqScope = 2
         End If
         reqRpt = 1
         reqTerm = 1
         reqFromDate = reqEnrollDate
         reqToDate = reqSysDate
      End If
      reqBookmark = ""
      reqDirection = 1
      reqPos = 0

      If (reqGroupID = 0) And (reqMemberID <> 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqGroupID = .GroupID
            End With
         End If
         Set oMember = Nothing
      End If

      Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
      If oMetrics Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
      Else
         With oMetrics
            .SysCurrentLanguage = reqSysLanguage
            .FindTypeID = reqFindTypeID
            xmlMetrics = .XML(14)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMetrics = Nothing

   Case CLng(cActionFind):
      reqBookmark = ""
      reqDirection = 1
      reqPos = 0
      reqSearchMember = ""

   Case CLng(cActionPrevious):
      reqDirection = 2
      reqPos = reqPos - 20

   Case CLng(cActionNext):
      reqDirection = 1
      reqPos = reqPos + 20

   Case CLng(cActionSearchMember):
      reqBookmark = ""
      reqDirection = 1
      reqPos = 0
End Select

Set oMetrics = server.CreateObject("ptsMetricUser.CMetrics")
If oMetrics Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsMetricUser.CMetrics"
Else
   With oMetrics
      .SysCurrentLanguage = reqSysLanguage
      If (reqRpt <> 0) Then
         If (reqSearchMember = "") Then
            If (reqPrivate = 0) Then
               If (reqScope = 1) Then
                  reqBookmark = .LeaderCompany(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 2) Then
                  reqBookmark = .LeaderGroup(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqGroupID), CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 3) Then
                  reqBookmark = .LeaderMentor(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqSysMemberID), CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (reqPrivate <> 0) Then
               reqBookmark = .LeaderPrivate(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqContestID), CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
         If (reqSearchMember <> "") Then
            If (reqPrivate = 0) Then
               If (reqScope = 1) Then
                  .MemberCompany CLng(reqCompanyID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 2) Then
                  .MemberGroup CLng(reqGroupID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 3) Then
                  .MemberMentor CLng(reqSysMemberID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (reqPrivate <> 0) Then
               .MemberPrivate CLng(reqContestID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqRpt)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
      End If
      If (reqRpt = 0) Then
         If (reqSearchMember = "") Then
            If (reqPrivate = 0) Then
               If (reqScope = 1) Then
                  reqBookmark = .LeaderCompanyCustom(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 2) Then
                  reqBookmark = .LeaderGroupCustom(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqGroupID), CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 3) Then
                  reqBookmark = .LeaderMentorCustom(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqSysMemberID), CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (reqPrivate <> 0) Then
               reqBookmark = .LeaderPrivateCustom(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqContestID), CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
         If (reqSearchMember <> "") Then
            If (reqPrivate = 0) Then
               If (reqScope = 1) Then
                  .MemberCompanyCustom CLng(reqCompanyID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 2) Then
                  .MemberGroupCustom CLng(reqGroupID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqScope = 3) Then
                  .MemberMentorCustom CLng(reqSysMemberID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (reqPrivate <> 0) Then
               .MemberPrivateCustom CLng(reqContestID), reqSearchMember, CDate(reqFromDate), CDate(reqToDate), CLng(reqCustom1), CLng(reqCustom2), CLng(reqCustom3), CLng(reqCustom4), CLng(reqCustom5)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
      End If
      xmlMetrics = .XML(15)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oMetrics = Nothing

Set oBookmark = server.CreateObject("wtSystem.CBookmark")
If oBookmark Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - wtSystem.CBookmark"
Else
   With oBookmark
      .LastBookmark = reqBookmark
      xmlBookmark = .XML()
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oBookmark = Nothing

LoadContests
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
xmlParam = xmlParam + " searchtext=" + Chr(34) + CleanXML(reqSearchText) + Chr(34)
xmlParam = xmlParam + " findtypeid=" + Chr(34) + CStr(reqFindTypeID) + Chr(34)
xmlParam = xmlParam + " bookmark=" + Chr(34) + CleanXML(reqBookmark) + Chr(34)
xmlParam = xmlParam + " direction=" + Chr(34) + CStr(reqDirection) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " term=" + Chr(34) + CStr(reqTerm) + Chr(34)
xmlParam = xmlParam + " scope=" + Chr(34) + CStr(reqScope) + Chr(34)
xmlParam = xmlParam + " rpt=" + Chr(34) + CStr(reqRpt) + Chr(34)
xmlParam = xmlParam + " pos=" + Chr(34) + CStr(reqPos) + Chr(34)
xmlParam = xmlParam + " contestid=" + Chr(34) + CStr(reqContestID) + Chr(34)
xmlParam = xmlParam + " private=" + Chr(34) + CStr(reqPrivate) + Chr(34)
xmlParam = xmlParam + " nodates=" + Chr(34) + CStr(reqNoDates) + Chr(34)
xmlParam = xmlParam + " enrolldate=" + Chr(34) + CStr(reqEnrollDate) + Chr(34)
xmlParam = xmlParam + " searchmember=" + Chr(34) + CleanXML(reqSearchMember) + Chr(34)
xmlParam = xmlParam + " ownercontestid=" + Chr(34) + CStr(reqOwnerContestID) + Chr(34)
xmlParam = xmlParam + " contestname=" + Chr(34) + CleanXML(reqContestName) + Chr(34)
xmlParam = xmlParam + " custom1=" + Chr(34) + CStr(reqCustom1) + Chr(34)
xmlParam = xmlParam + " custom2=" + Chr(34) + CStr(reqCustom2) + Chr(34)
xmlParam = xmlParam + " custom3=" + Chr(34) + CStr(reqCustom3) + Chr(34)
xmlParam = xmlParam + " custom4=" + Chr(34) + CStr(reqCustom4) + Chr(34)
xmlParam = xmlParam + " custom5=" + Chr(34) + CStr(reqCustom5) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlContests
xmlTransaction = xmlTransaction +  xmlContest
xmlTransaction = xmlTransaction +  xmlMetrics
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Metric[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Metric[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "11710 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "11710 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "11710 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "11710.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "11710 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "11710 Load file (oData) failed with error code " + CStr(oData.parseError)
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