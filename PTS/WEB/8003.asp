<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionDelete = 4
Const cActionUpload = 5
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
Dim oAttachment, xmlAttachment
Dim oSessionLesson, xmlSessionLesson
Dim oSession, xmlSession
'-----declare page parameters
Dim reqAttachmentID
Dim reqUploadID
Dim reqUploadError
Dim reqUploadErrorDesc
Dim reqCompanyID
Dim reqContentPage
Dim reqPopup
Dim reqTxn
Dim reqMini
Dim reqParentType
Dim reqParentID
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
   SetCache "8003URL", reqReturnURL
   SetCache "8003DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "8003")
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
reqAttachmentID =  Numeric(GetInput("AttachmentID", reqPageData))
reqUploadID =  Numeric(GetInput("UploadID", reqPageData))
reqUploadError =  Numeric(GetInput("UploadError", reqPageData))
reqUploadErrorDesc =  GetInput("UploadErrorDesc", reqPageData)
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqTxn =  Numeric(GetInput("Txn", reqPageData))
reqMini =  Numeric(GetInput("Mini", reqPageData))
reqParentType =  Numeric(GetInput("ParentType", reqPageData))
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
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

Sub ReturnAttachment()
   On Error Resume Next
   
            reqReturnURL = GetCache("8003URL")
            reqReturnData = GetCache("8003DATA")
            If Len(reqReturnURL) = 0 Then reqReturnURL = reqSysReturnURL
            SetCache "8003URL", ""
            SetCache "8003DATA", ""
            If (Len(reqReturnURL) > 0) Then
               SetCache "RETURNURL", reqReturnURL
               SetCache "RETURNDATA", reqReturnData
               Response.Redirect Replace(reqReturnURL, "%26", "&")
            End If

End Sub

Sub UpdateAttachment()
   On Error Resume Next

   Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
   If oAttachment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttachmentUser.CAttachment"
   Else
      With oAttachment
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqAttachmentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqParentType = .ParentType
         reqParentID = .ParentID

         .ParentID = Request.Form.Item("ParentID")
         .AuthUserID = Request.Form.Item("AuthUserID")
         .AttachName = Request.Form.Item("AttachName")
         .Description = Request.Form.Item("Description")
         .Status = Request.Form.Item("Status")
         .AttachDate = Request.Form.Item("AttachDate")
         .ExpireDate = Request.Form.Item("ExpireDate")
         .Secure = Request.Form.Item("Secure")
         .Score = Request.Form.Item("Score")
         If (reqCompanyID = 0) Then
            reqCompanyID = .CompanyID
         End If
         tmpLinkName = Request.Form.Item("LinkName")
         
            If tmpLinkName <> "" Then
               .FileName = tmpLinkName
               .IsLink = "1"
            End If   

         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (.Status = 1) And (.ParentType = 28) Then
            Result = CLng(.UpdateFT(CLng(.AttachmentID), .AttachName, .Description))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            reqTxn = 1
            If (.ParentType = 24) Then
               CalcGrade
            End If
         End If
         If (xmlError <> "") Or (reqPopup <> 0) Then
            xmlAttachment = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oAttachment = Nothing
End Sub

Sub CalcGrade()
   On Error Resume Next

   Set oSessionLesson = server.CreateObject("ptsSessionLessonUser.CSessionLesson")
   If oSessionLesson Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionLessonUser.CSessionLesson"
   Else
      With oSessionLesson
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqParentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSessionID = .SessionID
      End With
   End If
   Set oSessionLesson = Nothing

   Set oSession = server.CreateObject("ptsSessionUser.CSession")
   If oSession Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSessionUser.CSession"
   Else
      With oSession
         .SysCurrentLanguage = reqSysLanguage
         result = CLng(.SetStatus(tmpSessionID, ""))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSession = Nothing
End Sub

If (reqUploadError <> 0) Then
   
               DoError reqUploadError, "Upload", reqUploadErrorDesc

End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
      If oAttachment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttachmentUser.CAttachment"
      Else
         With oAttachment
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqAttachmentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqParentType = .ParentType
            reqParentID = .ParentID
            
      If IsLink <> "0" Then
         reqURL = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Attachments\" & tmpParentType & "\" & tmpParentID & "\"
         tmpFileName = tmpFilePath + tmpFileName
         Set Obj = Server.CreateObject("Scripting.FileSystemObject")
         If Obj.FileExists(tmpFileName) Then
            Obj.DeleteFile(tmpFileName)
         End If
         Set Obj = Nothing 
      End If

            xmlAttachment = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAttachment = Nothing

   Case CLng(cActionUpdate):
      UpdateAttachment
      If (xmlError = "") And (reqPopup = 0) Then
         ReturnAttachment
      End If

   Case CLng(cActionDelete):

      Set oAttachment = server.CreateObject("ptsAttachmentUser.CAttachment")
      If oAttachment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAttachmentUser.CAttachment"
      Else
         With oAttachment
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqAttachmentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpFileName = .FileName
            reqParentType = .ParentType
            reqParentID = .ParentID
            tmpParentID = .ParentID
            tmpIsLink = .IsLink
            .Delete CLng(reqAttachmentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError = "") Then
               reqTxn = 2
               If (.ParentType = 24) Then
                  CalcGrade
               End If
            End If
            If (xmlError <> "") Then
               xmlAttachment = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oAttachment = Nothing
      If (xmlError = "") Then
         
      If IsLink <> "0" Then
         tmpFilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "Attachments\" & reqParentType & "\" & tmpParentID & "\"
         tmpFileName = tmpFilePath + tmpFileName
         Set Obj = Server.CreateObject("Scripting.FileSystemObject")
         If Obj.FileExists(tmpFileName) Then
            Obj.DeleteFile(tmpFileName)
         End If
         Set Obj = Nothing 
      End If

      End If
      If (xmlError = "") Then
         ReturnAttachment
      End If

   Case CLng(cActionUpload):
      UpdateAttachment
      If (xmlError = "") Then
         If (reqCompanyID <> 0) Then

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
                  tmpUploadURL = ""
                  SetCache "SIZELIMIT", .DocSizeLimit
               End With
            End If
            Set oCoption = Nothing

            If (tmpUploadURL <> "") Then
               Response.Redirect "8021.asp" & "?AttachmentID=" & reqAttachmentID & "&UploadURL=" & tmpUploadURL & "&ContentPage=" & reqContentPage & "&Mini=" & reqMini & "&ReturnURL=" & GetCache("8003URL")
            End If
         End If

         Response.Redirect "8020.asp" & "?AttachmentID=" & reqAttachmentID & "&ContentPage=" & reqContentPage & "&Mini=" & reqMini
      End If

   Case CLng(cActionCancel):
      ReturnAttachment
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
xmlParam = xmlParam + " attachmentid=" + Chr(34) + CStr(reqAttachmentID) + Chr(34)
xmlParam = xmlParam + " uploadid=" + Chr(34) + CStr(reqUploadID) + Chr(34)
xmlParam = xmlParam + " uploaderror=" + Chr(34) + CStr(reqUploadError) + Chr(34)
xmlParam = xmlParam + " uploaderrordesc=" + Chr(34) + CleanXML(reqUploadErrorDesc) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " txn=" + Chr(34) + CStr(reqTxn) + Chr(34)
xmlParam = xmlParam + " mini=" + Chr(34) + CStr(reqMini) + Chr(34)
xmlParam = xmlParam + " parenttype=" + Chr(34) + CStr(reqParentType) + Chr(34)
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlAttachment
xmlTransaction = xmlTransaction +  xmlSessionLesson
xmlTransaction = xmlTransaction +  xmlSession
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Attachment[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Attachment[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8003 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "8003.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8003 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8003 Load file (oData) failed with error code " + CStr(oData.parseError)
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