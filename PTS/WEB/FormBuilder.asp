<!--#include file="Include\System.asp"-->
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
'-----declare page parameters
Dim reqMemberID
Dim reqURL
Dim reqProspect
Dim reqFirst
Dim reqLast
Dim reqEmail
Dim reqPhone
Dim reqPhone2
Dim reqTimeZone
Dim reqBestTime
Dim reqDescription
Dim reqSource
Dim reqStreet
Dim reqUnit
Dim reqCity
Dim reqState
Dim reqZip
Dim reqCountry
Dim reqrFirst
Dim reqrLast
Dim reqrEmail
Dim reqrPhone
Dim reqrPhone2
Dim reqrTimeZone
Dim reqrBestTime
Dim reqrDescription
Dim reqrSource
Dim reqrStreet
Dim reqrUnit
Dim reqrCity
Dim reqrState
Dim reqrZip
Dim reqrCountry
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
   SetCache "FormBuilderURL", reqReturnURL
   SetCache "FormBuilderDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "formbuilder")
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
reqURL =  Numeric(GetInput("URL", reqPageData))
reqProspect =  Numeric(GetInput("Prospect", reqPageData))
reqFirst =  Numeric(GetInput("First", reqPageData))
reqLast =  Numeric(GetInput("Last", reqPageData))
reqEmail =  Numeric(GetInput("Email", reqPageData))
reqPhone =  Numeric(GetInput("Phone", reqPageData))
reqPhone2 =  Numeric(GetInput("Phone2", reqPageData))
reqTimeZone =  Numeric(GetInput("TimeZone", reqPageData))
reqBestTime =  Numeric(GetInput("BestTime", reqPageData))
reqDescription =  Numeric(GetInput("Description", reqPageData))
reqSource =  Numeric(GetInput("Source", reqPageData))
reqStreet =  Numeric(GetInput("Street", reqPageData))
reqUnit =  Numeric(GetInput("Unit", reqPageData))
reqCity =  Numeric(GetInput("City", reqPageData))
reqState =  Numeric(GetInput("State", reqPageData))
reqZip =  Numeric(GetInput("Zip", reqPageData))
reqCountry =  Numeric(GetInput("Country", reqPageData))
reqrFirst =  Numeric(GetInput("rFirst", reqPageData))
reqrLast =  Numeric(GetInput("rLast", reqPageData))
reqrEmail =  Numeric(GetInput("rEmail", reqPageData))
reqrPhone =  Numeric(GetInput("rPhone", reqPageData))
reqrPhone2 =  Numeric(GetInput("rPhone2", reqPageData))
reqrTimeZone =  Numeric(GetInput("rTimeZone", reqPageData))
reqrBestTime =  Numeric(GetInput("rBestTime", reqPageData))
reqrDescription =  Numeric(GetInput("rDescription", reqPageData))
reqrSource =  Numeric(GetInput("rSource", reqPageData))
reqrStreet =  Numeric(GetInput("rStreet", reqPageData))
reqrUnit =  Numeric(GetInput("rUnit", reqPageData))
reqrCity =  Numeric(GetInput("rCity", reqPageData))
reqrState =  Numeric(GetInput("rState", reqPageData))
reqrZip =  Numeric(GetInput("rZip", reqPageData))
reqrCountry =  Numeric(GetInput("rCountry", reqPageData))
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


               reqURL = "http://" + reqSysServerName + reqSysServerPath + "AddContact.asp"
            
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqFirst = 1
      reqLast = 1
      reqEmail = 1
      reqPhone = 1
      reqrFirst = 1
      reqrLast = 1
      reqrEmail = 1
      reqrPhone = 1
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
xmlParam = xmlParam + " url=" + Chr(34) + CStr(reqURL) + Chr(34)
xmlParam = xmlParam + " prospect=" + Chr(34) + CStr(reqProspect) + Chr(34)
xmlParam = xmlParam + " first=" + Chr(34) + CStr(reqFirst) + Chr(34)
xmlParam = xmlParam + " last=" + Chr(34) + CStr(reqLast) + Chr(34)
xmlParam = xmlParam + " email=" + Chr(34) + CStr(reqEmail) + Chr(34)
xmlParam = xmlParam + " phone=" + Chr(34) + CStr(reqPhone) + Chr(34)
xmlParam = xmlParam + " phone2=" + Chr(34) + CStr(reqPhone2) + Chr(34)
xmlParam = xmlParam + " timezone=" + Chr(34) + CStr(reqTimeZone) + Chr(34)
xmlParam = xmlParam + " besttime=" + Chr(34) + CStr(reqBestTime) + Chr(34)
xmlParam = xmlParam + " description=" + Chr(34) + CStr(reqDescription) + Chr(34)
xmlParam = xmlParam + " source=" + Chr(34) + CStr(reqSource) + Chr(34)
xmlParam = xmlParam + " street=" + Chr(34) + CStr(reqStreet) + Chr(34)
xmlParam = xmlParam + " unit=" + Chr(34) + CStr(reqUnit) + Chr(34)
xmlParam = xmlParam + " city=" + Chr(34) + CStr(reqCity) + Chr(34)
xmlParam = xmlParam + " state=" + Chr(34) + CStr(reqState) + Chr(34)
xmlParam = xmlParam + " zip=" + Chr(34) + CStr(reqZip) + Chr(34)
xmlParam = xmlParam + " country=" + Chr(34) + CStr(reqCountry) + Chr(34)
xmlParam = xmlParam + " rfirst=" + Chr(34) + CStr(reqrFirst) + Chr(34)
xmlParam = xmlParam + " rlast=" + Chr(34) + CStr(reqrLast) + Chr(34)
xmlParam = xmlParam + " remail=" + Chr(34) + CStr(reqrEmail) + Chr(34)
xmlParam = xmlParam + " rphone=" + Chr(34) + CStr(reqrPhone) + Chr(34)
xmlParam = xmlParam + " rphone2=" + Chr(34) + CStr(reqrPhone2) + Chr(34)
xmlParam = xmlParam + " rtimezone=" + Chr(34) + CStr(reqrTimeZone) + Chr(34)
xmlParam = xmlParam + " rbesttime=" + Chr(34) + CStr(reqrBestTime) + Chr(34)
xmlParam = xmlParam + " rdescription=" + Chr(34) + CStr(reqrDescription) + Chr(34)
xmlParam = xmlParam + " rsource=" + Chr(34) + CStr(reqrSource) + Chr(34)
xmlParam = xmlParam + " rstreet=" + Chr(34) + CStr(reqrStreet) + Chr(34)
xmlParam = xmlParam + " runit=" + Chr(34) + CStr(reqrUnit) + Chr(34)
xmlParam = xmlParam + " rcity=" + Chr(34) + CStr(reqrCity) + Chr(34)
xmlParam = xmlParam + " rstate=" + Chr(34) + CStr(reqrState) + Chr(34)
xmlParam = xmlParam + " rzip=" + Chr(34) + CStr(reqrZip) + Chr(34)
xmlParam = xmlParam + " rcountry=" + Chr(34) + CStr(reqrCountry) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\FormBuilder[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\FormBuilder[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "FormBuilder Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "FormBuilder Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "FormBuilder Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "FormBuilder.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "FormBuilder Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "FormBuilder Load file (oData) failed with error code " + CStr(oData.parseError)
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