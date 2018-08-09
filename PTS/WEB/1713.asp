<!--#include file="Include\System.asp"-->
<!--#include file="Include\Search.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionList = 1
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
Dim oQuestionTypes, xmlQuestionTypes
Dim oQuestionType, xmlQuestionType
Dim oQuestions, xmlQuestions
'-----declare page parameters
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqIsSearch
Dim reqCompanyID
Dim reqUserType
Dim reqTopic
Dim reqContentPage
Dim reqPopup
Dim reqURL
Dim reqCustom
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
   SetCache "1713URL", reqReturnURL
   SetCache "1713DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "1713")
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
reqIsSearch =  Numeric(GetInput("IsSearch", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqUserType =  Numeric(GetInput("UserType", reqPageData))
reqTopic =  Numeric(GetInput("Topic", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqURL =  GetInput("URL", reqPageData)
reqCustom =  Numeric(GetInput("Custom", reqPageData))
If (tmpSecurityLevel = "") Then
   tmpSecurityLevel = 0
End If
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

Sub InitQuestions()
   On Error Resume Next
   tmpSecurityLevel = GetCache("SECURITYLEVEL")
   If (tmpSecurityLevel = "") Then
      tmpSecurityLevel = 0
   End If
   If (reqSysUserGroup = 41) Then

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqSysMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpLevel = .Level
         End With
      End If
      Set oMember = Nothing
   End If

   Set oQuestionTypes = server.CreateObject("ptsQuestionTypeUser.CQuestionTypes")
   If oQuestionTypes Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionTypeUser.CQuestionTypes"
   Else
      With oQuestionTypes
         .SysCurrentLanguage = reqSysLanguage
         If (reqCustom <> 0) Then
            xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), reqCustom, 0, reqTopic, , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqCustom = 0) Then
            If (reqSysUserGroup = 99) Then
               xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 1, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqSysUserGroup = 41) Then
               If (tmpLevel <> 0) Then
                  xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 3, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (tmpLevel = 0) Then
                  xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 2, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
               xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 4, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqSysUserGroup <= 23) Then
               xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 5, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
      End With
   End If
   Set oQuestionTypes = Nothing
End Sub

Sub InitCompanyQuestions()
   On Error Resume Next
   tmpSecurityLevel = GetCache("SECURITYLEVEL")
   If (tmpSecurityLevel = "") Then
      tmpSecurityLevel = 0
   End If

   Set oQuestionTypes = server.CreateObject("ptsQuestionTypeUser.CQuestionTypes")
   If oQuestionTypes Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionTypeUser.CQuestionTypes"
   Else
      With oQuestionTypes
         .SysCurrentLanguage = reqSysLanguage
         If (reqSysUserGroup = 99) Then
            xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 1, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup = 41) Then
            xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 3, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
            xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 4, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqSysUserGroup <= 23) Then
            xmlQuestionTypes = .EnumOnly(CLng(reqCompanyID), 5, tmpSecurityLevel, reqTopic, , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oQuestionTypes = Nothing
End Sub

Sub LoadQuestionTopics()
   On Error Resume Next
   InitQuestions
End Sub

Sub GetCompanyTopic()
   On Error Resume Next

   Set oQuestionType = server.CreateObject("ptsQuestionTypeUser.CQuestionType")
   If oQuestionType Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionTypeUser.CQuestionType"
   Else
      With oQuestionType
         .SysCurrentLanguage = reqSysLanguage
         If (reqUserType = 0) Then
            reqTopic = CLng(.FirstAll(CLng(reqCompanyID), tmpSecurityLevel))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqUserType <> 0) Then
            reqTopic = CLng(.FirstOnly(CLng(reqCompanyID), CLng(reqUserType), tmpSecurityLevel))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oQuestionType = Nothing
End Sub

reqURL = "http://" + reqSysServerName + reqSysServerPath + "Article.asp?a="
If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
If (reqSysCompanyID = 0) Then
   reqSysCompanyID = reqCompanyID
   SetCompanyHeader reqCompanyID, reqSysLanguage
End If
If (reqCompanyID = 21) Then
   If (reqSysUserGroup = 99) Then
      MerchantID = Numeric(GetCache("MERCHANT"))
      If (MerchantID <> "") Then
         reqCustom = 1
      End If
      If (reqCustom = 0) Then
         ConsumerID = Numeric(GetCache("CONSUMER"))
         If (ConsumerID <> "") Then
            reqCustom = -1
         End If
      End If
   End If
End If
If (reqCompanyID <> 0) Then
   If (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"S") = 0) Then

      Response.Redirect "0419.asp" & "?CompanyID=" & reqCompanyID & "&Error=" & 1
   End If
End If
If (reqCompanyID = 0) Then
   If (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"T") = 0) Then

      Response.Redirect "0419.asp" & "?CompanyID=" & reqCompanyID & "&Error=" & 1
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 41) And (reqCompanyID <> 0) Then
         If (reqCompanyID <> reqSysCompanyID) Then

            Response.Redirect "0101.asp" & "?ActionCode=" & 9
         End If
      End If
      If (reqCompanyID <> 0) Then
         GetCompanyTopic
      End If
      LoadQuestionTopics
      reqBookmark = ""
      reqDirection = 1

      If (reqTopic <> 0) Then
         Set oQuestions = server.CreateObject("ptsQuestionUser.CQuestions")
         If oQuestions Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionUser.CQuestions"
         Else
            With oQuestions
               .SysCurrentLanguage = reqSysLanguage
               .List reqTopic, tmpSecurityLevel, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlQuestions = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oQuestions = Nothing
      End If

   Case CLng(cActionList):
      tmpSecurityLevel = GetCache("SECURITYLEVEL")
      If (tmpSecurityLevel = "") Then
         tmpSecurityLevel = 0
      End If
      reqTopic = Request.Form.Item("Topic")
      LoadQuestionTopics

      If (reqTopic <> 0) Then
         Set oQuestions = server.CreateObject("ptsQuestionUser.CQuestions")
         If oQuestions Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionUser.CQuestions"
         Else
            With oQuestions
               .SysCurrentLanguage = reqSysLanguage
               .List reqTopic, tmpSecurityLevel, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlQuestions = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oQuestions = Nothing
      End If

   Case CLng(cActionFind):
      LoadQuestionTopics
      reqBookmark = ""
      reqDirection = 1
      reqIsSearch = 1
      If (reqSearchText = "") Then
         DoError 10004, "", "Oops, Please enter text to search for."
         reqIsSearch = 0
      End If

   Case CLng(cActionPrevious):
      LoadQuestionTopics
      reqDirection = 2
      reqIsSearch = 1

   Case CLng(cActionNext):
      LoadQuestionTopics
      reqDirection = 1
      reqIsSearch = 1
End Select

If (reqIsSearch = 1) Then
   Set oQuestions = server.CreateObject("ptsQuestionUser.CQuestions")
   If oQuestions Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsQuestionUser.CQuestions"
   Else
      With oQuestions
         .SysCurrentLanguage = reqSysLanguage
         
   tmpSearchText = Trim(reqSearchText)
   If InStr(tmpSearchText, " " ) > 0 Then
      If InStr(tmpSearchText, chr(34) ) = 0 Then tmpSearchText = chr(34) + tmpSearchText + chr(34)
   End If

   reqBookmark = .Search(reqBookmark, tmpSearchText, reqDirection, CLng(reqCompanyID), tmpSecurityLevel)

   'Check for error for Noise Words only
   If Err.Number = -2147217900 Then
      Err.Number = 0
      reqSearchText = ""
   End If
   If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         xmlQuestions = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oQuestions = Nothing
End If

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
xmlParam = xmlParam + " issearch=" + Chr(34) + CStr(reqIsSearch) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " usertype=" + Chr(34) + CStr(reqUserType) + Chr(34)
xmlParam = xmlParam + " topic=" + Chr(34) + CStr(reqTopic) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " url=" + Chr(34) + CleanXML(reqURL) + Chr(34)
xmlParam = xmlParam + " custom=" + Chr(34) + CStr(reqCustom) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlQuestionTypes
xmlTransaction = xmlTransaction +  xmlQuestionType
xmlTransaction = xmlTransaction +  xmlQuestions
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Question[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Question[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "1713 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "1713 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "1713 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "1713.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "1713 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "1713 Load file (oData) failed with error code " + CStr(oData.parseError)
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