<!--#include file="Include\System.asp"-->
<!--#include file="Include\CompanyMember.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCancel = 3
Const cActionFind = 5
Const cActionPrevious = 6
Const cActionNext = 7
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
Dim oProjects, xmlProjects
Dim oBookmark, xmlBookmark
'-----other transaction data variables
Dim xmlProjectTypes
'-----declare page parameters
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqCompanyID
Dim reqMemberID
Dim reqSecurityLevel
Dim reqStatus
Dim reqProjectTypeID
Dim reqM
Dim reqContentPage
Dim reqPopup
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
   SetCache "7501URL", reqReturnURL
   SetCache "7501DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "7501")
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
reqSecurityLevel =  Numeric(GetInput("SecurityLevel", reqPageData))
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqProjectTypeID =  Numeric(GetInput("ProjectTypeID", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
If (reqFindTypeID = 0) Then
   reqFindTypeID = 7520
End If
reqSecurityLevel = -1
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

If (reqCompanyID <> 0) And (reqSysCompanyID = 0) Then
   SetCache "COMPANYID", reqCompanyID
End If
If (reqCompanyID = 0) Then
   reqCompanyID = GetCache("COMPANYID")
End If
If (reqMemberID <> 0) And (reqSysMemberID = 0) Then
   SetCache "MEMBERID", reqMemberID
End If
If (reqSysUserGroup > 23) And (reqMemberID = 0) Then
   reqMemberID = GetCache("MEMBERID")
End If
If (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"F") = 0) And (InStr(reqSysUserOptions,"f") = 0) And (reqM = 0) Then

   Response.Redirect "0419.asp" & "?CompanyID=" & reqCompanyID & "&Error=" & 1
End If
If (reqSysUserGroup = 41) And (reqM = 0) Then
   GetCompanyMember reqCompanyID, reqMemberID
   If (InStr(reqSysUserOptions, "f") <> 0) Then
      reqSecurityLevel = GetMemberOptions("S")
   End If
End If
If (reqSysUserGroup <> 41) Or (reqM <> 0) Then

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (InStr(.Options, "f") <> 0) Then
               reqSecurityLevel = .Secure
            End If
         End With
      End If
      Set oMember = Nothing
   End If
End If
If (reqMemberID <> 0) And (reqCompanyID = 0) Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
      End With
   End If
   Set oMember = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqM <> 0) Then
         SetCache "MENTORINGID", reqMemberID
      End If
      tmpMentoringID = GetCache("MENTORINGID")
      If (tmpMentoringID = "") Then
         tmpMentoringID = -1
      End If
      If (reqSysUserGroup = 41) Then
         If (CLng(reqMemberID) <> CLng(reqSysMemberID)) And (CLng(reqMemberID) <> CLng(tmpMentoringID)) Then

            Response.Redirect "0101.asp" & "?ActionCode=" & 9
         End If
         If (CLng(reqCompanyID) <> CLng(reqSysCompanyID)) Then

            Response.Redirect "0101.asp" & "?ActionCode=" & 9
         End If
      End If
      reqStatus = -1
      reqBookmark = ""
      reqDirection = 1

      Set oProjects = server.CreateObject("ptsProjectUser.CProjects")
      If oProjects Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProjects"
      Else
         With oProjects
            .SysCurrentLanguage = reqSysLanguage
            .FindTypeID = reqFindTypeID
            xmlProjects = .XML(14)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProjects = Nothing

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("7501URL")
      reqReturnData = GetCache("7501DATA")
      SetCache "7501URL", ""
      SetCache "7501DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionFind):
      reqBookmark = ""
      reqDirection = 1

   Case CLng(cActionPrevious):
      reqDirection = 2

   Case CLng(cActionNext):
      reqDirection = 1
End Select

Set oProjects = server.CreateObject("ptsProjectUser.CProjects")
If oProjects Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectUser.CProjects"
Else
   With oProjects
      .SysCurrentLanguage = reqSysLanguage
      If (reqStatus = -1) Then
         If (reqProjectTypeID = 0) Then
            If (reqMemberID = 0) Then
               reqBookmark = .Find(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqMemberID <> 0) Then
               If (reqSecurityLevel >= 0) Then
                  reqBookmark = .FindSecure(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqMemberID), reqSecurityLevel, CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqSecurityLevel < 0) Then
                  reqBookmark = .FindAssigned(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
         If (reqProjectTypeID <> 0) Then
            If (reqMemberID = 0) Then
               reqBookmark = .FindType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqProjectTypeID), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqMemberID <> 0) Then
               If (reqSecurityLevel >= 0) Then
                  reqBookmark = .FindSecureType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqProjectTypeID), CLng(reqMemberID), reqSecurityLevel, CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqSecurityLevel < 0) Then
                  reqBookmark = .FindAssignedType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqProjectTypeID), CLng(reqMemberID), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
      End If
      If (reqStatus <> -1) Then
         If (reqProjectTypeID = 0) Then
            If (reqMemberID = 0) Then
               reqBookmark = .FindStatus(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqStatus), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqMemberID <> 0) Then
               If (reqSecurityLevel >= 0) Then
                  reqBookmark = .FindSecureStatus(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqMemberID), reqSecurityLevel, CLng(reqStatus), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqSecurityLevel < 0) Then
                  reqBookmark = .FindAssignedStatus(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqStatus), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
         If (reqProjectTypeID <> 0) Then
            If (reqMemberID = 0) Then
               reqBookmark = .FindStatusType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqProjectTypeID), CLng(reqStatus), CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqMemberID <> 0) Then
               If (reqSecurityLevel >= 0) Then
                  reqBookmark = .FindSecureStatusType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqCompanyID), CLng(reqProjectTypeID), CLng(reqMemberID), reqSecurityLevel, CLng(reqStatus), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqSecurityLevel < 0) Then
                  reqBookmark = .FindAssignedStatusType(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqProjectTypeID), CLng(reqMemberID), CLng(reqStatus), CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
      End If
      xmlProjects = .XML(15)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oProjects = Nothing

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

Set oProjectTypes = server.CreateObject("ptsProjectTypeUser.CProjectTypes")
If oProjectTypes Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsProjectTypeUser.CProjectTypes"
Else
   With oProjectTypes
      .SysCurrentLanguage = reqSysLanguage
      xmlProjectTypes = xmlProjectTypes + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oProjectTypes = Nothing

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
xmlParam = xmlParam + " securitylevel=" + Chr(34) + CStr(reqSecurityLevel) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " projecttypeid=" + Chr(34) + CStr(reqProjectTypeID) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlProjects
xmlTransaction = xmlTransaction +  xmlProjectTypes
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Project[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Project[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "7501 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "7501 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "7501 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
s = "<MENU name=""ProjectMenu"" type=""bar"" menuwidth=""110"">"
s=s+   "<ITEM label=""Project"">"
s=s+      "<IMAGE name=""Project.gif""/>"
s=s+      "<ITEM label=""NewProject"">"
s=s+         "<LINK name=""7502"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
s=s+      "<ITEM label=""ProjectTypes"">"
s=s+         "<LINK name=""7311"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""Help"">"
s=s+         "<LINK name=""Page"" target=""Help"">"
s=s+            "<PARAM name=""Page"" value=""HelpPCSUser""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Reports"">"
s=s+      "<IMAGE name=""Report.gif""/>"
s=s+      "<ITEM label=""WhatsNew"">"
s=s+         "<LINK name=""7524"" nodata=""true"" target=""WhatsNew"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""SecurityLevel"" value=""" & reqSecurityLevel & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Projects"">"
s=s+         "<LINK name=""7525"" nodata=""true"" target=""Projects"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Tasks"">"
s=s+         "<LINK name=""7426"" nodata=""true"" target=""Tasks"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Notes"">"
s=s+         "<LINK name=""7526"" target=""Notes"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlProjectMenu = s

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
xmlData = xmlData +  xmlProjectMenu
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "7501.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "7501 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "7501 Load file (oData) failed with error code " + CStr(oData.parseError)
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