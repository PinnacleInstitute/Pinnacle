<!--#include file="Include\System.asp"-->
<!--#include file="Include\InputOptions.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCheckout = 2
Const cActionShipping = 4
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
Dim oSalesOrder, xmlSalesOrder
Dim oCoption, xmlCoption
Dim oMember, xmlMember
Dim oSalesItems, xmlSalesItems
Dim oProductTypes, xmlProductTypes
'-----declare page parameters
Dim reqShoppingCartID
Dim reqCompanyID
Dim reqMemberID
Dim reqSponsorID
Dim reqNoAdd
Dim reqShipping
Dim reqShipOption
Dim reqCode
Dim reqBadProduct
Dim reqInvalid
Dim reqEditItems
Dim reqDirty
Dim reqProductTypeID
Dim reqPublic
Dim reqLevel
Dim reqRemovePromo
Dim reqCredit
Dim reqReferredBy
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
   SetCache "5251URL", reqReturnURL
   SetCache "5251DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5251")
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
reqShoppingCartID =  Numeric(GetInput("ShoppingCartID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqSponsorID =  Numeric(GetInput("SponsorID", reqPageData))
reqNoAdd =  Numeric(GetInput("NoAdd", reqPageData))
reqShipping =  Numeric(GetInput("Shipping", reqPageData))
reqShipOption =  GetInput("ShipOption", reqPageData)
reqCode =  GetInput("Code", reqPageData)
reqBadProduct =  GetInput("BadProduct", reqPageData)
reqInvalid =  Numeric(GetInput("Invalid", reqPageData))
reqEditItems =  Numeric(GetInput("EditItems", reqPageData))
reqDirty =  Numeric(GetInput("Dirty", reqPageData))
reqProductTypeID =  Numeric(GetInput("ProductTypeID", reqPageData))
reqPublic =  Numeric(GetInput("Public", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqRemovePromo =  Numeric(GetInput("RemovePromo", reqPageData))
reqCredit =  GetInput("Credit", reqPageData)
reqReferredBy =  GetInput("ReferredBy", reqPageData)
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

Sub GoProducts()
   On Error Resume Next

   Response.Redirect "5252.asp" & "?ProductTypeID=" & reqProductTypeID & "&CompanyID=" & reqCompanyID & "&MemberID=" & reqMemberID & "&SponsorID=" & reqSponsorID & "&Public=" & reqPublic & "&Level=" & reqLevel & "&ReturnURL=" & reqPageURL
End Sub

Sub LoadShoppingCart()
   On Error Resume Next
   reqShoppingCartID = Numeric(GetCache("SHOPPINGCART"))
   tmpSalesItems = 0

   If (reqShoppingCartID <> 0) Then
      Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
      If oSalesOrder Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
      Else
         With oSalesOrder
            .SysCurrentLanguage = reqSysLanguage
            .Load reqShoppingCartID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            If (.MemberID = 0) And (reqMemberID <> 0) Then
               .MemberID = reqMemberID
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            reqMemberID = .MemberID
            xmlSalesOrder = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqShipping = CLng(.GetShipping(reqShoppingCartID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSalesOrder = Nothing
   End If

   If (reqShipping <> 0) Then
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
            reqShipOption = .Shopping
         End With
      End If
      Set oCoption = Nothing
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
            reqPublic = 0
            reqLevel = .Level
            reqCredit = .Custom(CLng(reqCompanyID), CLng(reqMemberID), 100)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
      If reqCredit <> "" Then
         If reqCredit = "0.00" Then
            reqCredit = ""
         Else   
            reqCredit = FormatCurrency(reqCredit)
         End If
      End If

            xmlMember = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqSponsorID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqSponsorID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .NameFirst + " " + .NameLast
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqShoppingCartID <> 0) Then
      Set oSalesItems = server.CreateObject("ptsSalesItemUser.CSalesItems")
      If oSalesItems Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItems"
      Else
         With oSalesItems
            .SysCurrentLanguage = reqSysLanguage
            .ListSalesOrder reqShoppingCartID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            For Each oSalesItem in oSalesItems
               tmpSalesItems = tmpSalesItems + 1
               With oSalesItem
                  'Remove locks from sales items for employees, company administrators and group managers
                     If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
                     .Locks = 0
                  End If   
                     If .Locks = 0 Then reqEditItems = 1
                  .Price = CCUR(.Price) + CCUR(.OptionPrice)
                  .OptionPrice = CCUR(.Price) * CLng(.Quantity)
                  tmpValid = IsValidInputOptions( .InputOptions, .InputValues)
                  If tmpValid = 0 Then 
                     reqInvalid = reqInvalid + 1
                     .Invalid = 1
                  Else   
                     .Invalid = 0
                  End If   

'                  If .InputValues <> "" Then
'                     pos = InStr(.InputValues, "(")
'                     If pos > 0 Then
'                        .InputValues = Left(.InputValues, pos-1)
'                     End If
'                  End If
               End With
            Next

            xmlSalesItems = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oSalesItems = Nothing
   End If
   If (reqCompanyID = 0) Then
      reqCompanyID = reqSysCompanyID
   End If

   If (reqNoAdd = 0) Then
      Set oProductTypes = server.CreateObject("ptsProductTypeUser.CProductTypes")
      If oProductTypes Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProductTypeUser.CProductTypes"
      Else
         With oProductTypes
            .SysCurrentLanguage = reqSysLanguage
            If (reqPublic <> 0) Then
               xmlProductTypes = .EnumCompanyPublic(CLng(reqCompanyID), tmpProductTypeID, , CLng(reqSysUserID))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqPublic = 0) Then
               If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
                  xmlProductTypes = .EnumCompanyAll(CLng(reqCompanyID), tmpProductTypeID, , CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) And (reqSysUserGroup <> 52) Then
                  xmlProductTypes = .EnumCompany(CLng(reqCompanyID), CStr(reqLevel), tmpProductTypeID, , CLng(reqSysUserID))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End With
      End If
      Set oProductTypes = Nothing
   End If
   If (tmpSalesItems = 0) Then
      
Set oProductType = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oProductType.loadXML xmlProductTypes
Set oItems = oProductType.selectNodes("PTSPRODUCTTYPES/ENUM") 
x = 0
id = 0
For Each oItem In oItems
   x = x + 1
   id = oItem.getAttribute("id") 
Next
Set oItems = Nothing
Set oProductType = Nothing

If( x = 2 ) Then
   reqProductTypeID = id
   GoProducts()   
End If

   End If
End Sub

Sub SaveSalesOrder()
   On Error Resume Next
   reqShoppingCartID = Numeric(GetCache("SHOPPINGCART"))

   If (reqCode <> "") Then
      Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
      If oSalesOrder Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
      Else
         With oSalesOrder
            .SysCurrentLanguage = reqSysLanguage
            Result = CLng(.GetPromotion(reqShoppingCartID, reqCode))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCode = ""
            If (result = 1) Then
               DoError 10015, "", "Oops, Invalid Promotion Code."
            End If
            If (result = 2) Then
               DoError 10016, "", "Oops, The Promotion has not started."
            End If
            If (result = 3) Then
               DoError 10017, "", "Oops, The Promotion has expired."
            End If
            If (result = 4) Then
               DoError 10018, "", "Oops, The Promotion has been used."
            End If
         End With
      End If
      Set oSalesOrder = Nothing
   End If

   Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
   If oSalesOrder Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
   Else
      With oSalesOrder
         .SysCurrentLanguage = reqSysLanguage
         .Load reqShoppingCartID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Ship = Request.Form.Item("Ship")
         .Notes = Request.Form.Item("Notes")
         If (reqRemovePromo <> 0) Then
            .PromotionID = 0
            reqRemovePromo = 0
         End If
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSalesOrder = Nothing
End Sub

Sub ValidateSalesItems()
   On Error Resume Next
   reqShoppingCartID = Numeric(GetCache("SHOPPINGCART"))

   Set oSalesItems = server.CreateObject("ptsSalesItemUser.CSalesItems")
   If oSalesItems Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItems"
   Else
      With oSalesItems
         .SysCurrentLanguage = reqSysLanguage
         .ListSalesOrder reqShoppingCartID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            For Each oSalesItem in oSalesItems
               With oSalesItem
                  tmpErrors = ValidateInputOptions( .InputOptions, .InputValues)
               End With
            Next

      End With
   End If
   Set oSalesItems = Nothing
End Sub

reqDirty = 0
reqPublic = 1
If (reqProductTypeID <> 0) Then
   GoProducts
End If
If (reqSponsorID = 0) Then
   reqSponsorID = Numeric(GetCache("A"))
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
            If reqBadProduct <> "" Then
               Set oProduct = server.CreateObject("ptsProductUser.CProduct")
               aProducts = Split(reqBadProduct, ",")
               reqTotal = UBOUND(aProducts)
               For x = 0 to reqTotal
                  productid = aProducts(x)
                  With oProduct
                     .Load productid, 1
                     DoError 0, "", "Oops, " + .ProductName + " is no longer available."
                  End With
               Next
               Set oProduct = Nothing
            End If

      SetCache "SHOPPINGCART", ""
      If (reqShoppingCartID <> 0) Then
         SetCache "SHOPPINGCART", reqShoppingCartID
      End If
      If (reqCompanyID = 0) Then
         reqCompanyID = reqSysCompanyID
      End If
      If (reqMemberID = 0) Then
         reqMemberID = reqSysMemberID
      End If
      LoadShoppingCart

   Case CLng(cActionCheckout):
      SaveSalesOrder
      ValidateSalesItems
      If (xmlError <> "") Then
         LoadShoppingCart
      End If

      If (xmlError = "") Then
         Response.Redirect "5253.asp" & "?SponsorID=" & reqSponsorID & "&MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionShipping):
      SaveSalesOrder
      LoadShoppingCart
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
xmlParam = xmlParam + " shoppingcartid=" + Chr(34) + CStr(reqShoppingCartID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " sponsorid=" + Chr(34) + CStr(reqSponsorID) + Chr(34)
xmlParam = xmlParam + " noadd=" + Chr(34) + CStr(reqNoAdd) + Chr(34)
xmlParam = xmlParam + " shipping=" + Chr(34) + CStr(reqShipping) + Chr(34)
xmlParam = xmlParam + " shipoption=" + Chr(34) + CleanXML(reqShipOption) + Chr(34)
xmlParam = xmlParam + " code=" + Chr(34) + CleanXML(reqCode) + Chr(34)
xmlParam = xmlParam + " badproduct=" + Chr(34) + CleanXML(reqBadProduct) + Chr(34)
xmlParam = xmlParam + " invalid=" + Chr(34) + CStr(reqInvalid) + Chr(34)
xmlParam = xmlParam + " edititems=" + Chr(34) + CStr(reqEditItems) + Chr(34)
xmlParam = xmlParam + " dirty=" + Chr(34) + CStr(reqDirty) + Chr(34)
xmlParam = xmlParam + " producttypeid=" + Chr(34) + CStr(reqProductTypeID) + Chr(34)
xmlParam = xmlParam + " public=" + Chr(34) + CStr(reqPublic) + Chr(34)
xmlParam = xmlParam + " level=" + Chr(34) + CStr(reqLevel) + Chr(34)
xmlParam = xmlParam + " removepromo=" + Chr(34) + CStr(reqRemovePromo) + Chr(34)
xmlParam = xmlParam + " credit=" + Chr(34) + CleanXML(reqCredit) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlSalesOrder
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlSalesItems
xmlTransaction = xmlTransaction +  xmlProductTypes
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\5251[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\5251[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "5251 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "5251 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "5251 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "5251.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "5251 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "5251 Load file (oData) failed with error code " + CStr(oData.parseError)
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