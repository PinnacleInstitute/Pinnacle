<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdateExit = 1
Const cActionUpdate = 5
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionUploadImage = 6
Const cActionInventory = 7
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
Dim oProduct, xmlProduct
Dim oProductTypes, xmlProductTypes
Dim oCommPlans, xmlCommPlans
'-----declare page parameters
Dim reqProductID
Dim reqMemberID
Dim reqCompanyID
Dim reqUploadImage
Dim reqImagePath
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
   SetCache "5003URL", reqReturnURL
   SetCache "5003DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5003")
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
reqProductID =  Numeric(GetInput("ProductID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqUploadImage =  GetInput("UploadImage", reqPageData)
reqImagePath =  GetInput("ImagePath", reqPageData)
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

Sub UpdateProduct()
   On Error Resume Next

   Set oProduct = server.CreateObject("ptsProductUser.CProduct")
   If oProduct Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
   Else
      With oProduct
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProductID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID

         .CompanyID = Request.Form.Item("CompanyID")
         .ProductTypeID = Request.Form.Item("ProductTypeID")
         .Code = Request.Form.Item("Code")
         .Seq = Request.Form.Item("Seq")
         .ProductName = Request.Form.Item("ProductName")
         .Image = Request.Form.Item("Image")
         .Price = Request.Form.Item("Price")
         .OriginalPrice = Request.Form.Item("OriginalPrice")
         .BV = Request.Form.Item("BV")
         .CommPlan = Request.Form.Item("CommPlan")
         .IsActive = Request.Form.Item("IsActive")
         .Levels = Request.Form.Item("Levels")
         .IsPublic = Request.Form.Item("IsPublic")
         .IsPrivate = Request.Form.Item("IsPrivate")
         .NoQty = Request.Form.Item("NoQty")
         .Inventory = Request.Form.Item("Inventory")
         .InStock = Request.Form.Item("InStock")
         .ReOrder = Request.Form.Item("ReOrder")
         .Attribute1 = Request.Form.Item("Attribute1")
         .Attribute2 = Request.Form.Item("Attribute2")
         .Attribute3 = Request.Form.Item("Attribute3")
         .Recur = Request.Form.Item("Recur")
         .RecurTerm = Request.Form.Item("RecurTerm")
         .OrderMin = Request.Form.Item("OrderMin")
         .OrderMax = Request.Form.Item("OrderMax")
         .OrderMul = Request.Form.Item("OrderMul")
         .OrderGrp = Request.Form.Item("OrderGrp")
         .IsTaxable = Request.Form.Item("IsTaxable")
         .TaxRate = Request.Form.Item("TaxRate")
         .Tax = Request.Form.Item("Tax")
         .IsShip = Request.Form.Item("IsShip")
         .QV = Request.Form.Item("QV")
         .Ship1 = Request.Form.Item("Ship1")
         .Ship1a = Request.Form.Item("Ship1a")
         .Ship2 = Request.Form.Item("Ship2")
         .Ship2a = Request.Form.Item("Ship2a")
         .Ship3 = Request.Form.Item("Ship3")
         .Ship3a = Request.Form.Item("Ship3a")
         .Ship4 = Request.Form.Item("Ship4")
         .Ship4a = Request.Form.Item("Ship4a")
         .Description = Request.Form.Item("Description")
         .Fulfill = Request.Form.Item("Fulfill")
         .Data = Request.Form.Item("Data")
         .FulFillInfo = Request.Form.Item("FulFillInfo")
         .InputOptions = Request.Form.Item("InputOptions")
         .Email = Request.Form.Item("Email")
         If (.CommPlan <> 0) And (.BV = "$0.00") Then
            .BV = .Price
         End If
         
      .Description = Replace( .Description, "<p>", "" )
      .Description = Replace( .Description, "</p>", "" )

      If .Inventory = 3 Then
         If .Attribute1 <> "" Then
            If InStr(.InputOptions, .Attribute1 + ":" ) = 0 Then
                  DoError 10120, "", "Oops, Missing Custom Field for Inventory Attribute."
            End If
         End If
         If .Attribute2 <> "" Then
            If InStr(.InputOptions, .Attribute2 + ":" ) = 0 Then
                  DoError 10120, "", "Oops, Missing Custom Field for Inventory Attribute."
            End If
         End If
         If .Attribute3 <> "" Then
            If InStr(.InputOptions, .Attribute3 + ":" ) = 0 Then
                  DoError 10120, "", "Oops, Missing Custom Field for Inventory Attribute."
            End If
         End If
      End If

         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProduct = Nothing
End Sub

Sub LoadProduct()
   On Error Resume Next

   Set oProduct = server.CreateObject("ptsProductUser.CProduct")
   If oProduct Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
   Else
      With oProduct
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProductID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqImagePath = "company/" + CStr(reqCompanyID)
         xmlProduct = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProduct = Nothing

   Set oProductTypes = server.CreateObject("ptsProductTypeUser.CProductTypes")
   If oProductTypes Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductTypeUser.CProductTypes"
   Else
      With oProductTypes
         .SysCurrentLanguage = reqSysLanguage
         xmlProductTypes = xmlProductTypes + .EnumCompanyAll(CLng(reqCompanyID), , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProductTypes = Nothing

   Set oCommPlans = server.CreateObject("ptsCommPlanUser.CCommPlans")
   If oCommPlans Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCommPlanUser.CCommPlans"
   Else
      With oCommPlans
         .SysCurrentLanguage = reqSysLanguage
         xmlCommPlans = xmlCommPlans + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCommPlans = Nothing
End Sub

If (reqUploadImage <> "") Then
   reqProductID = GetCache("PRODUCTID")

   Set oProduct = server.CreateObject("ptsProductUser.CProduct")
   If oProduct Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
   Else
      With oProduct
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProductID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Image = reqUploadImage
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProduct = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadProduct

   Case CLng(cActionUpdateExit):
      UpdateProduct
      If (xmlError <> "") Then
         LoadProduct
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("5003URL")
         reqReturnData = GetCache("5003DATA")
         SetCache "5003URL", ""
         SetCache "5003DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUpdate):
      UpdateProduct
      LoadProduct

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("5003URL")
      reqReturnData = GetCache("5003DATA")
      SetCache "5003URL", ""
      SetCache "5003DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oProduct = server.CreateObject("ptsProductUser.CProduct")
      If oProduct Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductUser.CProduct"
      Else
         With oProduct
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqProductID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProduct = Nothing
      If (xmlError <> "") Then
         LoadProduct
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("5003URL")
         reqReturnData = GetCache("5003DATA")
         SetCache "5003URL", ""
         SetCache "5003DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUploadImage):
      UpdateProduct
      If (xmlError <> "") Then
         LoadProduct
      End If

      If (xmlError = "") Then
         Response.Redirect "5020.asp" & "?CompanyID=" & reqCompanyID & "&ProductID=" & reqProductID
      End If

   Case CLng(cActionInventory):
      UpdateProduct
      If (xmlError <> "") Then
         LoadProduct
      End If

      If (xmlError = "") Then
         Response.Redirect "10511.asp" & "?MemberID=" & reqMemberID & "&ProductID=" & reqProductID & "&ReturnURL=" & reqPageURL
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
xmlParam = xmlParam + " productid=" + Chr(34) + CStr(reqProductID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " uploadimage=" + Chr(34) + CleanXML(reqUploadImage) + Chr(34)
xmlParam = xmlParam + " imagepath=" + Chr(34) + CleanXML(reqImagePath) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlProduct
xmlTransaction = xmlTransaction +  xmlProductTypes
xmlTransaction = xmlTransaction +  xmlCommPlans
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Product[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Product[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "5003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "5003 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "5003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "5003.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "5003 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "5003 Load file (oData) failed with error code " + CStr(oData.parseError)
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