<!--#include file="Include\System.asp"-->
<!--#include file="Include\StripHTML.asp"-->
<!--#include file="Include\2FA.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionUploadImage = 6
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
Dim oMerchant, xmlMerchant
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqMerchantID
Dim reqTxn
Dim reqUploadImage
Dim reqTextColor
Dim reqBackColor
Dim reqBackImage
Dim reqPageColor
Dim reqPageImage
Dim reqA
Dim reqB
Dim reqC
Dim reqD
Dim reqE
Dim reqF
Dim reqG
Dim reqH
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
   SetCache "15004URL", reqReturnURL
   SetCache "15004DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "15004")
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
reqMerchantID =  Numeric(GetInput("MerchantID", reqPageData))
reqTxn =  Numeric(GetInput("Txn", reqPageData))
reqUploadImage =  GetInput("UploadImage", reqPageData)
reqTextColor =  GetInput("TextColor", reqPageData)
reqBackColor =  GetInput("BackColor", reqPageData)
reqBackImage =  GetInput("BackImage", reqPageData)
reqPageColor =  GetInput("PageColor", reqPageData)
reqPageImage =  GetInput("PageImage", reqPageData)
reqA =  Numeric(GetInput("A", reqPageData))
reqB =  Numeric(GetInput("B", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqD =  Numeric(GetInput("D", reqPageData))
reqE =  Numeric(GetInput("E", reqPageData))
reqF =  Numeric(GetInput("F", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqH =  Numeric(GetInput("H", reqPageData))
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

Sub LoadStore()
   On Error Resume Next
   SetCache "IMAGEPATH", "/Images/Store/" + CSTR(reqMerchantID) + "/"

   Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
   If oMerchant Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
   Else
      With oMerchant
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMerchantID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            If Len(.Colors) > 0 Then
              a = Split(.Colors, ",")
              reqTextColor = a(0)
              reqBackColor = a(1)
              reqBackImage = a(2)
              reqPageColor = a(3)
              reqPageImage = a(4)
            End If
                 tmp = .StoreOptions
                 If InStr(tmp, "A") > 0 Then reqA = 1
                 If InStr(tmp, "B") > 0 Then reqB = 1
                 If InStr(tmp, "C") > 0 Then reqC = 1
                 If InStr(tmp, "D") > 0 Then reqD = 1
                 If InStr(tmp, "E") > 0 Then reqE = 1
                 If InStr(tmp, "F") > 0 Then reqF = 1
                 If InStr(tmp, "G") > 0 Then reqG = 1
            If InStr(tmp, "H") > 0 Then reqH = 1
          
         xmlMerchant = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMerchant = Nothing

   If (xmlError = "") Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = reqMerchantID
            .Path = reqSysWebDirectory + "Store"
            .Language = Request.Form.Item("Language")
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
End Sub

Sub SaveStore()
   On Error Resume Next

   Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
   If oMerchant Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
   Else
      With oMerchant
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMerchantID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .Description = Request.Form.Item("Description")
         .Image = Request.Form.Item("Image")
         .Email2 = Request.Form.Item("Email2")
         .Phone2 = Request.Form.Item("Phone2")
         
              .Colors = reqTextColor + "," + reqBackColor + "," + reqBackImage + "," + reqPageColor + "," + reqPageImage
              tmp = ""
              If reqA = 1 Then tmp = tmp + "A"
              If reqB = 1 Then tmp = tmp + "B"
              If reqC = 1 Then tmp = tmp + "C"
              If reqD = 1 Then tmp = tmp + "D"
              If reqE = 1 Then tmp = tmp + "E"
              If reqF = 1 Then tmp = tmp + "F"
              If reqG = 1 Then tmp = tmp + "G"
              If reqH = 1 Then tmp = tmp + "H"
              .StoreOptions = tmp
            
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            reqTxn = 1
         End If
         If (xmlError <> "") Then
            xmlMerchant = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (.IsOrg = 0) Then
            tmpDescription = StripHTML(.Description)
            Result = CLng(.UpdateFT(CLng(.MerchantID), .MerchantName, .City, .State, .Zip, .CountryName, tmpDescription))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oMerchant = Nothing

   If (xmlError = "") Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = reqMerchantID
            .Path = reqSysWebDirectory + "Store"
            .Language = Request.Form.Item("Language")
            .Project = SysProject
            .Data = Request.Form.Item("Data")
            .Save 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError <> "") Then
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
End Sub

Check2FAMerchant reqMerchantID
If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) Then
   SysMerchantID = Numeric(GetCache("MERCHANT"))
   If (reqMerchantID <> SysMerchantID) Then
      AbortUser()
   End If
End If
If (reqUploadImage <> "") Then

   Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
   If oMerchant Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
   Else
      With oMerchant
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMerchantID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Image = reqUploadImage
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMerchant = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadStore

   Case CLng(cActionUpdate):
      SaveStore
      LoadStore

   Case CLng(cActionUploadImage):
      SaveStore
      If (xmlError <> "") Then
         LoadStore
      End If

      If (xmlError = "") Then
         Response.Redirect "15020.asp" & "?MerchantID=" & reqMerchantID
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
xmlParam = xmlParam + " merchantid=" + Chr(34) + CStr(reqMerchantID) + Chr(34)
xmlParam = xmlParam + " txn=" + Chr(34) + CStr(reqTxn) + Chr(34)
xmlParam = xmlParam + " uploadimage=" + Chr(34) + CleanXML(reqUploadImage) + Chr(34)
xmlParam = xmlParam + " textcolor=" + Chr(34) + CleanXML(reqTextColor) + Chr(34)
xmlParam = xmlParam + " backcolor=" + Chr(34) + CleanXML(reqBackColor) + Chr(34)
xmlParam = xmlParam + " backimage=" + Chr(34) + CleanXML(reqBackImage) + Chr(34)
xmlParam = xmlParam + " pagecolor=" + Chr(34) + CleanXML(reqPageColor) + Chr(34)
xmlParam = xmlParam + " pageimage=" + Chr(34) + CleanXML(reqPageImage) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " b=" + Chr(34) + CStr(reqB) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " d=" + Chr(34) + CStr(reqD) + Chr(34)
xmlParam = xmlParam + " e=" + Chr(34) + CStr(reqE) + Chr(34)
xmlParam = xmlParam + " f=" + Chr(34) + CStr(reqF) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CStr(reqG) + Chr(34)
xmlParam = xmlParam + " h=" + Chr(34) + CStr(reqH) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Merchant[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Merchant[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "15004 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "15004 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "15004 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "15004.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "15004 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "15004 Load file (oData) failed with error code " + CStr(oData.parseError)
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