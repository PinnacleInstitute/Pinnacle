<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
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
Dim oBusiness, xmlBusiness
Dim oEmail, xmlEmail
Dim oCompany, xmlCompany
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqMailReturnURL
Dim reqEmailID
Dim reqCompanyID
Dim reqMemberID
Dim reqProspectID
Dim reqNewsLetterID
On Error Resume Next

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
pos = InStr(LCASE(reqSysServerPath), "8809")
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
reqMailReturnURL =  GetInput("MailReturnURL", reqPageData)
reqEmailID =  Numeric(GetInput("EmailID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
reqNewsLetterID =  Numeric(GetInput("NewsLetterID", reqPageData))

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
'-----create a DOM object for the XSL
xslPage = "8809.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8809 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqEmailID = 0 Then
         Response.Redirect Replace(reqMailReturnURL, "%26", "&")
      End If
   
      'Insure that the first test for a valid email passes
      tmpTo = "@"

      Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
      If oBusiness Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
      Else
         With oBusiness
            .SysCurrentLanguage = reqSysLanguage
            .Load 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .SystemEmail
         End With
      End If
      Set oBusiness = Nothing

      Set oEmail = server.CreateObject("ptsEmailUser.CEmail")
      If oEmail Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailUser.CEmail"
      Else
         With oEmail
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqEmailID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            tmpEmailName = .EmailName
            tmpFile = .FileName
            tmpFrom = .FromEmail
            tmpSubject = .Subject
            reqNewsLetterID = .NewsLetterID
         End With
      End If
      Set oEmail = Nothing

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqCompanyID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            CompanyEmail = .Email
            CompanyFirstName = .NameFirst
            CompanyLastName = .NameLast
            CompanyPhone = .Phone1
         End With
      End If
      Set oCompany = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .FileName = tmpFile
            If (reqCompanyID <> 0) Then
               .Path = reqSysWebDirectory + "Sections/Company/" & reqCompanyID & "/Msg/"
            End If
            If (reqCompanyID = 0) Then
               .Path = reqSysWebDirectory + "Sections/Msg/"
            End If
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing

'-----*****Setup for Email Message*****
If tmpSysLanguage <> reqSysLanguage Then
   tmpSysLanguage = reqSysLanguage
End If

'-----get the language XML
fileLanguage = "Language" + "\Email[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Email[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8809 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8809 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8809 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

xmlParam = "<PARAM"
xmlParam = xmlParam + " mailreturnurl=" + Chr(34) + CleanXML(reqMailReturnURL) + Chr(34)
xmlParam = xmlParam + " emailid=" + Chr(34) + CStr(reqEmailID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " newsletterid=" + Chr(34) + CStr(reqNewsLetterID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBusiness
xmlTransaction = xmlTransaction +  xmlEmail
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlSystem
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8809 Load file (oData) failed with error code " + CStr(oData.parseError)
   Response.Write "<BR/>" + xmlData
   Response.End
End If

If Len(reqSysTestFile) > 0 Then
   oData.save reqSysTestFile
End If

'-----transform the XML with the XSL
tmpBody = oData.transformNode(oStyle)

tmpTest =  Numeric(GetInput("TEST", reqPageData))
If tmpTest <> 0 Then
   response.write "<br>sender: " + tmpSender
   response.write "<br>from: " + tmpFrom
   response.write "<br>to: " + tmpTo
   response.write "<br>subject: " + tmpSubject
   response.write "<br>body:<br>" + tmpBody
End If

      
         tmpMasterFrom = tmpFrom
         tmpMasterSubject = tmpSubject
         tmpMasterBody = tmpBody
         tmpCount = 0
         
If InStr(tmpFrom, "@")=0 AND InStr(tmpFrom, "{m-email}")=0 Then tmpFrom = ""
If tmpFrom <> "" Then

         Set oProspects = server.CreateObject("ptsProspectUser.CProspects")
         If oProspects Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspects"
         Else
            With oProspects
               .SysCurrentLanguage = reqSysLanguage
               .ListEmail reqEmailID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

               For Each oProspect in oProspects
                  With oProspect
                     tmpTo = .Email
                     tmpFirstName = .NameFirst
                     tmpLastName = .NameLast
                     tmpID = .ProspectID
                     tmpMID = .MemberID
                     tmpSignature = .Description
                     tmpMEmail = .Street
                     tmpMNameFirst = .Phone1
                     tmpMNameLast = .Phone2
                     If tmpMEmail = "" Then
                        tmpMEmail = CompanyEmail
                     End If

                     tmpFrom = Replace( tmpMasterFrom, "{m-email}", tmpMEmail )
                     tmpSubject = Replace( tmpMasterSubject, "{firstname}", tmpFirstName )
                     tmpSubject = Replace( tmpSubject, "{lastname}", tmpLastName )
                     tmpSubject = Replace( tmpSubject, "{id}", tmpID )
                     tmpSubject = Replace( tmpSubject, "{m-firstname}", tmpMNameFirst )
                     tmpSubject = Replace( tmpSubject, "{m-lastname}", tmpMNameLast )
                     tmpBody = Replace( tmpMasterBody, "{firstname}", tmpFirstName )
                     tmpBody = Replace( tmpBody, "{lastname}", tmpLastName )
                     tmpBody = Replace( tmpBody, "{id}", tmpID )
                     tmpBody = Replace( tmpBody, "{m-firstname}", tmpMNameFirst )
                     tmpBody = Replace( tmpBody, "{m-lastname}", tmpMNameLast )
                     tmpBody = Replace( tmpBody, "{m-id}", tmpMID )
                     tmpBody = Replace( tmpBody, "{signature}", tmpSignature )
                     tmpBody = Replace( tmpBody, "{n}", reqNewsLetterID )
                     tmpBody = Replace( tmpBody, "{m}", tmpMID )
                  End With
                  If tmpTo <> "" Then
                     tmpCount = tmpCount + 1

         Set oMail = server.CreateObject("CDO.Message")
         If oMail Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
         Else
            With oMail
               .Sender = tmpSender
               .From = tmpFrom
               .To = tmpTo
               .Subject = tmpSubject
               .HTMLBody = tmpBody
               If tmpTest = 0 Then .Send
            End With
         End If
         Set oMail = Nothing
      
                  End If

               '--- Update Prospect EmailDate, EmailID
               Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
               If oProspect Is Nothing Then
                  DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
               Else
                  With oProspect
                     .Load CLng(tmpID), CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     .EmailID = "0"
                     .EmailDate = ""
                     .Save 1
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End With
               End If
               Set oProspect = Nothing

               '--- Add Note
               If tmpTo <> "" Then
                  Set oNote = server.CreateObject("ptsNoteUser.CNote")
                  If oNote Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
                  Else
                     With oNote
                        .NoteDate = Now
                        .OwnerType = 81
                        .OwnerID = tmpID
                        .AuthUserID = 1
                        .IsLocked = 1
                        .Notes = "EMAIL=" + tmpEmailName
                        .Add(1)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End With
                  End If
                  Set oNote = Nothing
               End If
   
               Next
            End With
         End If
         Set oProspects = Nothing
End If

Set oEmail = server.CreateObject("ptsEmailUser.CEmail")
If oEmail Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailUser.CEmail"
Else
   With oEmail
      .SysClientProject SysClient, SysProject
      .Load CLng(reqEmailID), 1
      .Status = 3
      .Mailings = .Mailings + 1
      .Emails = .Emails + tmpCount
      .Save 1
   End With
End If
Set oEmail = Nothing

End Select

If reqMailReturnURL <> "" Then
   Response.Redirect Replace(reqMailReturnURL, "%26", "&")
End If

Set oData = Nothing
Set oStyle = Nothing
Set oLanguage = Nothing
%>