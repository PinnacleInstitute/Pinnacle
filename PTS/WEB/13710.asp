<!--#include file="Include\System.asp"-->
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
Dim oProfile, xmlProfile
Dim oMember, xmlMember
Dim oHTMLFile, xmlHTMLFile
'-----other transaction data variables
Dim xmlCover
Dim xmlCongrats
Dim xmlContents
Dim xmlThinking
Dim xmlDefinitions
Dim xmlStrength
Dim xmlWeakness
Dim xmlActionPlan
Dim xmlTOP
'-----declare page parameters
Dim reqProfileID
Dim reqCompanyID
Dim reqMemberID
Dim reqProfileType
Dim reqDetail
Dim reqPrint
Dim reqSampleGraphName
Dim reqSampleGraphPath
Dim reqVQITop
Dim reqVQILeft
Dim reqVQETop
Dim reqVQELeft
Dim reqVQSTop
Dim reqVQSLeft
Dim reqSQITop
Dim reqSQILeft
Dim reqSQETop
Dim reqSQELeft
Dim reqSQSTop
Dim reqSQSLeft
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
   SetCache "13710URL", reqReturnURL
   SetCache "13710DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "13710")
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
reqProfileID =  Numeric(GetInput("ProfileID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqProfileType =  Numeric(GetInput("ProfileType", reqPageData))
reqDetail =  Numeric(GetInput("Detail", reqPageData))
reqPrint =  Numeric(GetInput("Print", reqPageData))
reqSampleGraphName =  GetInput("SampleGraphName", reqPageData)
reqSampleGraphPath =  GetInput("SampleGraphPath", reqPageData)
reqVQITop =  Numeric(GetInput("VQITop", reqPageData))
reqVQILeft =  Numeric(GetInput("VQILeft", reqPageData))
reqVQETop =  Numeric(GetInput("VQETop", reqPageData))
reqVQELeft =  Numeric(GetInput("VQELeft", reqPageData))
reqVQSTop =  Numeric(GetInput("VQSTop", reqPageData))
reqVQSLeft =  Numeric(GetInput("VQSLeft", reqPageData))
reqSQITop =  Numeric(GetInput("SQITop", reqPageData))
reqSQILeft =  Numeric(GetInput("SQILeft", reqPageData))
reqSQETop =  Numeric(GetInput("SQETop", reqPageData))
reqSQELeft =  Numeric(GetInput("SQELeft", reqPageData))
reqSQSTop =  Numeric(GetInput("SQSTop", reqPageData))
reqSQSLeft =  Numeric(GetInput("SQSLeft", reqPageData))
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

reqCompanyID = 16
xmlTOP = "<TOP><!--" + "<HEAD><TITLE>Profile Report</TITLE></HEAD>" + "--></TOP>"
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      tmpMemberName = ""
      tmpMemberFirst = ""
      tmpProfileDate = ""
      tmpGroupName = ""
      tmpGroupEmail = ""
      tmpGroupPhone = ""

      Set oProfile = server.CreateObject("ptsProfileUser.CProfile")
      If oProfile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProfileUser.CProfile"
      Else
         With oProfile
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqProfileID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqMemberID = .MemberID
            reqProfileType = .ProfileType
            If (reqProfileType < 1) Or (reqProfileType > 4) Then
               reqProfileType = 1
            End If
            tmpProfileDate = .ProfileDate
            reqSampleGraphName = "Graph[" + reqSysLanguage + "].jpg"
            Path = "Sections/Company/" + CStr(reqCompanyID) + "/Profile" + CStr(reqProfileType)
            reqSampleGraphPath = Path + "/"
            LanguageFile = Path
            
                  pos = InStr( tmpProfileDate, " " )
                  If pos > 0 Then tmpProfileDate = Left(tmpProfileDate, pos-1)

                  reqVQILeft = 75 - (26 + (2 * CLng(.VQClarity_I)))
                  reqVQELeft = 75 - (26 + (2 * CLng(.VQClarity_E)))
                  reqVQSLeft = 75 - (26 + (2 * CLng(.VQClarity_S)))
                  reqSQILeft = 75 - (26 + (2 * CLng(.SQClarity_I)))
                  reqSQELeft = 75 - (26 + (2 * CLng(.SQClarity_E)))
                  reqSQSLeft = 75 - (26 + (2 * CLng(.SQClarity_S)))

                  reqVQITop = (88 - (6 + (2 * CLng(.VQClarity_I)))) - (CLng(.xVQBias_I) * 8)
                  reqVQETop = (88 - (6 + (2 * CLng(.VQClarity_E)))) - (CLng(.xVQBias_E) * 8)
                  reqVQSTop = (88 - (6 + (2 * CLng(.VQClarity_S)))) - (CLng(.xVQBias_S) * 8)
                  reqSQITop = (88 - (6 + (2 * CLng(.SQClarity_I)))) - (CLng(.xSQBias_I) * 8)
                  reqSQETop = (88 - (6 + (2 * CLng(.SQClarity_E)))) - (CLng(.xSQBias_E) * 8)
                  reqSQSTop = (88 - (6 + (2 * CLng(.SQClarity_S)))) - (CLng(.xSQBias_S) * 8)
               
            xmlProfile = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProfile = Nothing

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpGroupID = .GroupID
            tmpMemberName = .NameFirst + " " + .NameLast
            tmpMemberFirst = .NameFirst
            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (tmpGroupID <> 0) Then
               .Load tmpGroupID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpGroupName = .CompanyName
               tmpGroupEmail = .Email
               tmpGroupPhone = .Phone1
            End If
         End With
      End If
      Set oMember = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Path = reqSysWebDirectory + "Sections/Company/" + CStr(reqCompanyID) + "/Profile" + CStr(reqProfileType)
            .Language = reqSysLanguage
            .Project = SysProject
            .Filename = "Cover.htm"
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlCover = .XML("Cover")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  xmlCover = Replace( xmlCover, "{name}", tmpMemberName )
                  xmlCover = Replace( xmlCover, "{date}", tmpProfileDate )
                  xmlCover = Replace( xmlCover, "{g-name}", tmpGroupName )
                  xmlCover = Replace( xmlCover, "{g-email}", tmpGroupEmail )
                  xmlCover = Replace( xmlCover, "{g-phone}", tmpGroupPhone )
               
            .Filename = "Thinking.htm"
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlThinking = .XML("Thinking")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Filename = "Definitions.htm"
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlDefinitions = .XML("Definitions")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Filename = "ActionPlan.htm"
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlActionPlan = .XML("ActionPlan")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqDetail = 0) Then
               .Filename = "Contents2.htm"
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlContents = .XML("Contents")
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqDetail <> 0) Then
               .Filename = "Congrats.htm"
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlCongrats = .XML("Congrats")
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
                     xmlCongrats = Replace( xmlCongrats, "{firstname}", tmpMemberFirst )
                     xmlCongrats = Replace( xmlCongrats, "{date}", tmpProfileDate )
                     xmlCongrats = Replace( xmlCongrats, "{g-name}", tmpGroupName )
                     xmlCongrats = Replace( xmlCongrats, "{g-email}", tmpGroupEmail )
                     xmlCongrats = Replace( xmlCongrats, "{g-phone}", tmpGroupPhone )
                  
               .Filename = "Contents.htm"
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlContents = .XML("Contents")
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Filename = "Strength.htm"
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlStrength = .XML("Strength")
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Filename = "Weakness.htm"
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlWeakness = .XML("Weakness")
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oHTMLFile = Nothing

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("13710URL")
      reqReturnData = GetCache("13710DATA")
      SetCache "13710URL", ""
      SetCache "13710DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
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
xmlParam = xmlParam + " profileid=" + Chr(34) + CStr(reqProfileID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " profiletype=" + Chr(34) + CStr(reqProfileType) + Chr(34)
xmlParam = xmlParam + " detail=" + Chr(34) + CStr(reqDetail) + Chr(34)
xmlParam = xmlParam + " print=" + Chr(34) + CStr(reqPrint) + Chr(34)
xmlParam = xmlParam + " samplegraphname=" + Chr(34) + CleanXML(reqSampleGraphName) + Chr(34)
xmlParam = xmlParam + " samplegraphpath=" + Chr(34) + CleanXML(reqSampleGraphPath) + Chr(34)
xmlParam = xmlParam + " vqitop=" + Chr(34) + CStr(reqVQITop) + Chr(34)
xmlParam = xmlParam + " vqileft=" + Chr(34) + CStr(reqVQILeft) + Chr(34)
xmlParam = xmlParam + " vqetop=" + Chr(34) + CStr(reqVQETop) + Chr(34)
xmlParam = xmlParam + " vqeleft=" + Chr(34) + CStr(reqVQELeft) + Chr(34)
xmlParam = xmlParam + " vqstop=" + Chr(34) + CStr(reqVQSTop) + Chr(34)
xmlParam = xmlParam + " vqsleft=" + Chr(34) + CStr(reqVQSLeft) + Chr(34)
xmlParam = xmlParam + " sqitop=" + Chr(34) + CStr(reqSQITop) + Chr(34)
xmlParam = xmlParam + " sqileft=" + Chr(34) + CStr(reqSQILeft) + Chr(34)
xmlParam = xmlParam + " sqetop=" + Chr(34) + CStr(reqSQETop) + Chr(34)
xmlParam = xmlParam + " sqeleft=" + Chr(34) + CStr(reqSQELeft) + Chr(34)
xmlParam = xmlParam + " sqstop=" + Chr(34) + CStr(reqSQSTop) + Chr(34)
xmlParam = xmlParam + " sqsleft=" + Chr(34) + CStr(reqSQSLeft) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlProfile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlCover
xmlTransaction = xmlTransaction +  xmlCongrats
xmlTransaction = xmlTransaction +  xmlContents
xmlTransaction = xmlTransaction +  xmlThinking
xmlTransaction = xmlTransaction +  xmlDefinitions
xmlTransaction = xmlTransaction +  xmlStrength
xmlTransaction = xmlTransaction +  xmlWeakness
xmlTransaction = xmlTransaction +  xmlActionPlan
xmlTransaction = xmlTransaction +  xmlTOP
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = LanguageFile + "\Profile[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Profile[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "13710 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

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
   Response.Write "13710 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "13710.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "13710 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "13710 Load file (oData) failed with error code " + CStr(oData.parseError)
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