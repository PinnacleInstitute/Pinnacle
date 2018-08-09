<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionReload = 5
Const cActionUploadEmailees = 6
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
Dim oEmailList, xmlEmailList
Dim oEmailSource, xmlEmailSource
Dim oEmailSources, xmlEmailSources
'-----other transaction data variables
Dim xmlFieldList
Dim xmlQueryData
'-----declare page parameters
Dim reqEmailListID
Dim reqCount
Dim reqCompanyID
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
   SetCache "8903URL", reqReturnURL
   SetCache "8903DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "8903")
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
reqEmailListID =  Numeric(GetInput("EmailListID", reqPageData))
reqCount =  Numeric(GetInput("Count", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqCount = -1
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

Sub SaveEmailList()
   On Error Resume Next

   Set oEmailList = server.CreateObject("ptsEmailListUser.CEmailList")
   If oEmailList Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailListUser.CEmailList"
   Else
      With oEmailList
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqEmailListID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID

         .EmailListName = Request.Form.Item("EmailListName")
         .SourceType = Request.Form.Item("SourceType")
         .CustomID = Request.Form.Item("CustomID")
         .Param1 = Request.Form.Item("Param1")
         .Param2 = Request.Form.Item("Param2")
         .Param3 = Request.Form.Item("Param3")
         .Param4 = Request.Form.Item("Param4")
         .Param5 = Request.Form.Item("Param5")
         .CustomID = Request.Form.Item("CustomID")
         .Param1 = Request.Form.Item("Param1")
         .Param2 = Request.Form.Item("Param2")
         .Param3 = Request.Form.Item("Param3")
         .Param4 = Request.Form.Item("Param4")
         .Param5 = Request.Form.Item("Param5")
         .EmailSourceID = Request.Form.Item("EmailSourceID")
         If (reqCompanyID = 0) Then
            
            tmpInclude = Request.Item("EmailSourceInclude")
      
            tmpQueryStr = "<WTSELECT include='" & tmpInclude & "'"
            If (tmpInclude = "Top") Then
               tmpQueryStr = tmpQueryStr & " qty='" & Request.Item("EmailSourceQuantity") & "'"
            Else
               tmpQueryStr = tmpQueryStr & " qty=''"               
            End If
            tmpQueryStr = tmpQueryStr & "/>"
            
            For expcount = 1 To 5
               tmpQueryStr = tmpQueryStr & "<WTATTRIBUTE name='data" & CStr(expcount) & "' src='" & Request.Item("EmailSourceMisc" & CStr(expcount)) & "'/>"
            Next
            
            For expcount = 1 To 3
               tmpQueryStr = tmpQueryStr & "<WTCONDITION expr='" & Request.Item( "EmailSourceExpr" & CStr(expcount) ) & "' oper='" & Request.Item("EmailSourceOper" & CStr(expcount)) & "' value='" & Request.Item( "EmailSourceValue" & CStr(expcount) ) & "'"
               If (expcount > 1) Then
                  tmpQueryStr = tmpQueryStr & " connector='" & Request.Item("EmailSourceConnector" & expcount) & "'"
               End If
               tmpQueryStr = tmpQueryStr & "/>"
            Next
            
            .Query = tmpQueryStr & "<WTORDERBY name='" & Request.Item("EmailSourceOrderBy") & "' order='" & Request.Item("EmailSourceOrder") & "'/>"

         End If
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError <> "") Then
            LoadEmailList
         End If
      End With
   End If
   Set oEmailList = Nothing
End Sub

Sub LoadEmailList()
   On Error Resume Next

   Set oEmailList = server.CreateObject("ptsEmailListUser.CEmailList")
   If oEmailList Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailListUser.CEmailList"
   Else
      With oEmailList
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqEmailListID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         tmpEmailSourceID = .EmailSourceID
         
                  xmlQueryData = "<QUERYDATA>" & .Query & "</QUERYDATA>"   
               
         xmlEmailList = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oEmailList = Nothing

   If (reqCompanyID = 0) Then
      Set oEmailSource = server.CreateObject("ptsEmailSourceUser.CEmailSource")
      If oEmailSource Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailSourceUser.CEmailSource"
      Else
         With oEmailSource
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpEmailSourceID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  xmlFieldList = "<FIELDLIST><ENUM id='0' name='' src=''/>" & .EmailSourceFields & "</FIELDLIST>"   
               
         End With
      End If
      Set oEmailSource = Nothing
   End If

   If (reqCompanyID = 0) Then
      Set oEmailSources = server.CreateObject("ptsEmailSourceUser.CEmailSources")
      If oEmailSources Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailSourceUser.CEmailSources"
      Else
         With oEmailSources
            .SysCurrentLanguage = reqSysLanguage
            xmlEmailSources = .EnumEmailSource(tmpEmailSourceID, "EmailSource", CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oEmailSources = Nothing
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadEmailList

   Case CLng(cActionUpdate):
      SaveEmailList

      If (xmlError = "") Then
         reqReturnURL = GetCache("8903URL")
         reqReturnData = GetCache("8903DATA")
         SetCache "8903URL", ""
         SetCache "8903DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("8903URL")
      reqReturnData = GetCache("8903DATA")
      SetCache "8903URL", ""
      SetCache "8903DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oEmailList = server.CreateObject("ptsEmailListUser.CEmailList")
      If oEmailList Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailListUser.CEmailList"
      Else
         With oEmailList
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqEmailListID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oEmailList = Nothing
      If (xmlError <> "") Then
         LoadEmailList
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("8903URL")
         reqReturnData = GetCache("8903DATA")
         SetCache "8903URL", ""
         SetCache "8903DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionReload):
      
               tmpSourceType = Request.Item("SourceType")
            

      Set oEmailList = server.CreateObject("ptsEmailListUser.CEmailList")
      If oEmailList Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailListUser.CEmailList"
      Else
         With oEmailList
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqEmailListID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .SourceType = tmpSourceType
            
                  tmpEmailSourceID = Request.Item("EmailSourceID")
                  If (Not IsNumeric(tmpEmailSourceID)) Then tmpEmailSourceID = CLng(0) Else tmpEmailSourceID = CLng(tmpEmailSourceID)
                  If (tmpEmailSourceID <> .EmailSourceID And tmpEmailSourceID > 0) Then
                     .Query = ""
                  Else
                     tmpEmailSourceID = .EmailSourceID
                  End If
               
            .EmailSourceID = tmpEmailSourceID
            
                  xmlQueryData = "<QUERYDATA>" & .Query & "</QUERYDATA>"   
               
            xmlEmailList = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oEmailList = Nothing

      Set oEmailSource = server.CreateObject("ptsEmailSourceUser.CEmailSource")
      If oEmailSource Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailSourceUser.CEmailSource"
      Else
         With oEmailSource
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpEmailSourceID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  xmlFieldList = "<FIELDLIST><ENUM id='0' name='' src=''/>" & .EmailSourceFields & "</FIELDLIST>"      
               
         End With
      End If
      Set oEmailSource = Nothing

      Set oEmailSources = server.CreateObject("ptsEmailSourceUser.CEmailSources")
      If oEmailSources Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailSourceUser.CEmailSources"
      Else
         With oEmailSources
            .SysCurrentLanguage = reqSysLanguage
            xmlEmailSources = .EnumEmailSource(tmpEmailSourceID, "EmailSource", CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oEmailSources = Nothing

   Case CLng(cActionUploadEmailees):
      SaveEmailList

      If (xmlError = "") Then
         Response.Redirect "8706.asp" & "?EmailListID=" & reqEmailListID & "&CompanyID=" & reqCompanyID
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
xmlParam = xmlParam + " emaillistid=" + Chr(34) + CStr(reqEmailListID) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlEmailList
xmlTransaction = xmlTransaction +  xmlEmailSource
xmlTransaction = xmlTransaction +  xmlEmailSources
xmlTransaction = xmlTransaction +  xmlFieldList
xmlTransaction = xmlTransaction +  xmlQueryData
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\EmailList[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\EmailList[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8903 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8903 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8903 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "8903.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8903 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8903 Load file (oData) failed with error code " + CStr(oData.parseError)
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