<!--#include file="Include\System.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionSend = 1
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
Dim oPages, xmlPages
Dim oAuthUser, xmlAuthUser
Dim oProspect, xmlProspect
Dim oMember, xmlMember
Dim oHTMLFile, xmlHTMLFile
Dim oMail, xmlMail
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqOwnerType
Dim reqOwnerID
Dim reqMemberID
Dim reqCompanyID
Dim reqTemplateID
Dim reqSent
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
   SetCache "0502URL", reqReturnURL
   SetCache "0502DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0502")
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
reqOwnerType =  Numeric(GetInput("OwnerType", reqPageData))
reqOwnerID =  Numeric(GetInput("OwnerID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqTemplateID =  Numeric(GetInput("TemplateID", reqPageData))
reqSent =  Numeric(GetInput("Sent", reqPageData))
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

Sub LoadList()
   On Error Resume Next
   tmpGroupID = Numeric(GetCache("GROUPID"))
   If (reqOwnerType = 22) Then
      tmpResource = 9
      tmpPageType = 4
   End If
   If (reqOwnerType = 81) Then
      tmpResource = 10
      tmpPageType = 3
   End If
   If (reqOwnerType = -81) Then
      tmpResource = 11
      tmpPageType = 5
   End If
   tmpGroupID1 = 0
   tmpGroupID2 = 0
   tmpGroupID3 = 0
   If (reqSysUserGroup <> 41) Then
      tmpGroupID = reqMemberID
      GetResources tmpGroupID
   End If
   If (tmpGroupID <> 0) Then
      GetResource tmpResource, tmpGroupID1, tmpGroupID2, tmpGroupID3
   End If

   Set oPages = server.CreateObject("ptsPageUser.CPages")
   If oPages Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPages"
   Else
      With oPages
         .SysCurrentLanguage = reqSysLanguage
         xmlPages = .EnumPage(reqCompanyID, CLng(reqMemberID), tmpGroupID1, tmpGroupID2, tmpGroupID3, tmpPageType)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPages = Nothing
End Sub

Sub LoadMail()
   On Error Resume Next
   LoadList

   If (reqSysUserID <> 0) Then
      Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
      If oAuthUser Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
      Else
         With oAuthUser
            .SysCurrentLanguage = reqSysLanguage
            .AuthUserID = reqSysUserID
            .Load CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpFrom = .Email
         End With
      End If
      Set oAuthUser = Nothing
   End If

   If (reqOwnerType = 22) Or (reqOwnerType = 81) Or (reqOwnerType = -81) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqOwnerID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCompanyID = .CompanyID
            tmpTo = .Email
            tmpID = .ProspectID
            tmpName = .ProspectName
            tmpStreet = .Street + " " + .Unit
            tmpCity = .City
            tmpState = .State
            tmpZip = .Zip
            tmpCountry = .Country
            tmpFirstName = .NameFirst
            tmpLastName = .NameLast
            tmpEmail = .Email
            tmpPhone = .Phone1
            tmpSource = .Source
            If (.NextEvent <> 0) Then
               tmpEvent = .NextDate + " " + .NextTime
            End If
         End With
      End If
      Set oProspect = Nothing
   End If

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSignature = .Signature
            tmpMID = .MemberID
            tmpMFirstName = .NameFirst
            tmpMLastName = .NameLast
            tmpMEmail = .Email
            tmpMPhone = .Phone1
            If (reqOwnerType = 22) Then
               tmpUseType = 4
            End If
            If (reqOwnerType = 81) Then
               tmpUseType = 5
            End If
            If (reqOwnerType = -81) Then
               tmpUseType = 6
            End If
            Signature = .GetSignature(CLng(reqMemberID), tmpUseType, 0, reqSysLanguage)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Signature <> "") Then
               tmpSignature = Signature
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqTemplateID = 0) Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Project = SysProject
            .Data = "<BR><BR>" + tmpSignature
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
   tmpSubject = ""
   If (reqTemplateID <> 0) Then

      Set oPage = server.CreateObject("ptsPageUser.CPage")
      If oPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPage"
      Else
         With oPage
            .SysCurrentLanguage = reqSysLanguage
            .Load reqTemplateID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSubject = .PageName
         End With
      End If
      Set oPage = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = reqTemplateID & ".htm"
            .Path = reqSysWebDirectory + "Pages\"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   tmpSubject = Replace( tmpSubject, "{firstname}", CleanXMLComment(tmpFirstName) )
   tmpSubject = Replace( tmpSubject, "{lastname}", CleanXMLComment(tmpLastName) )

   xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", CleanXMLComment(tmpSignature) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{companyname}", CleanXMLComment(tmpName) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{street}", CleanXMLComment(tmpStreet) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{city}", CleanXMLComment(tmpCity) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{state}", CleanXMLComment(tmpState) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{zip}", CleanXMLComment(tmpZip) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{country}", CleanXMLComment(tmpCountry) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{firstname}", CleanXMLComment(tmpFirstName) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{lastname}", CleanXMLComment(tmpLastName) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{email}", CleanXMLComment(tmpEmail) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{phone}", CleanXMLComment(tmpPhone) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{source}", CleanXMLComment(tmpSource) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{id}", tmpID )
   xmlHTMLFile = Replace( xmlHTMLFile, "{event}", CleanXMLComment(tmpEvent) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{m-firstname}", CleanXMLComment(tmpMFirstName) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{m-lastname}", CleanXMLComment(tmpMLastName) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{m-email}", CleanXMLComment(tmpMEmail) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{m-phone}", CleanXMLComment(tmpMPhone) )
   xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", tmpMID )

         End With
      End If
      Set oHTMLFile = Nothing
   End If

   Set oMail = server.CreateObject("ptsMailUser.CMail")
   If oMail Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMailUser.CMail"
   Else
      With oMail
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .MailFrom = tmpFrom
         .MailTo = tmpTo
         .Subject = tmpSubject
         xmlMail = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMail = Nothing
End Sub

Sub ReloadMail()
   On Error Resume Next
   LoadList

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Project = SysProject
         .Data = Request.Form.Item("Data")
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing

   Set oMail = server.CreateObject("ptsMailUser.CMail")
   If oMail Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMailUser.CMail"
   Else
      With oMail
         .SysCurrentLanguage = reqSysLanguage
         .Load reqTemplateID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .MailFrom = Request.Form.Item("MailFrom")
         .MailTo = Request.Form.Item("MailTo")
         .CC = Request.Form.Item("CC")
         .BCC = Request.Form.Item("BCC")
         .Subject = Request.Form.Item("Subject")
         xmlMail = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMail = Nothing
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadMail

   Case CLng(cActionSend):

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load reqCompanyID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .Email
         End With
      End If
      Set oCompany = Nothing

      Set oMail = server.CreateObject("ptsMailUser.CMail")
      If oMail Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMailUser.CMail"
      Else
         With oMail
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = reqOwnerType
            .OwnerID = reqOwnerID
            .MemberID = reqMemberID
            .MailDate = Now

            .MailFrom = Request.Form.Item("MailFrom")
            .MailTo = Request.Form.Item("MailTo")
            .CC = Request.Form.Item("CC")
            .BCC = Request.Form.Item("BCC")
            .Subject = Request.Form.Item("Subject")
            tmpFrom = .MailFrom
            tmpTo = .MailTo
            tmpCC = .CC
            tmpBCC = .BCC
            tmpSubject = .Subject
            tmpBody = Request.Form.Item("Data")
            MailID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMail = Nothing
      SendEmail reqCompanyid, tmpSender, tmpFrom, tmpTo, tmpCC, tmpBCC, tmpSubject, tmpBody

      If (xmlError = "") Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .FileName = "Mail" & MailID & ".htm"
               .Path = reqSysWebDirectory + "Sections\Company\" & reqCompanyID & "\Mail\"
               .Language = "en"
               .Project = SysProject
               .Data = tmpBody
               .Save 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If
      If (xmlError = "") Then
         reqSent = 1
      End If
      If (xmlError <> "") Then
         ReloadMail
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
xmlParam = xmlParam + " ownertype=" + Chr(34) + CStr(reqOwnerType) + Chr(34)
xmlParam = xmlParam + " ownerid=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " templateid=" + Chr(34) + CStr(reqTemplateID) + Chr(34)
xmlParam = xmlParam + " sent=" + Chr(34) + CStr(reqSent) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPages
xmlTransaction = xmlTransaction +  xmlAuthUser
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMail
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Mail[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Mail[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0502 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0502 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0502 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0502.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0502 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0502 Load file (oData) failed with error code " + CStr(oData.parseError)
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