<!--#include file="Include\System.asp"-->
<!--#include file="Include\Debt.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
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
Dim oHTMLFile, xmlHTMLFile
Dim oTaxRate, xmlTaxRate
Dim oHomeTax, xmlHomeTax
'-----declare page parameters
Dim reqMemberID
Dim reqC
Dim reqDeduct
Dim reqAmount
Dim reqMonthly
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
   SetCache "10400URL", reqReturnURL
   SetCache "10400DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "10400")
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
reqC =  Numeric(GetInput("C", reqPageData))
reqDeduct =  GetInput("Deduct", reqPageData)
reqAmount =  GetInput("Amount", reqPageData)
reqMonthly =  GetInput("Monthly", reqPageData)
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

Sub LoadHTML()
   On Error Resume Next

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "HomeTax.htm"
         .Path = reqSysWebDirectory + "Sections"
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
End Sub

Sub GetRates()
   On Error Resume Next

   Set oTaxRate = server.CreateObject("ptsTaxRateUser.CTaxRate")
   If oTaxRate Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsTaxRateUser.CTaxRate"
   Else
      With oTaxRate
         .SysCurrentLanguage = reqSysLanguage
         .FetchRate YEAR(reqSysDate), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpMilesRate = .Rate
         If (tmpMilesRate = 0) Then
            tmpMilesRate = .51
         End If
      End With
   End If
   Set oTaxRate = Nothing
End Sub

Function CalcTax(oItem)
   On Error Resume Next
   
         With oItem
            reqDeduct = 0
            reqDeduct = reqDeduct + CleanNumber(.Home) * ( CleanNumber(.Office) / 100 ) * 12
            reqDeduct = reqDeduct + CleanNumber(.Miles) * tmpMilesRate * 12
            reqDeduct = reqDeduct + CleanNumber(.Meetings) * 12
            reqDeduct = reqDeduct + CleanNumber(.Meals) * .5 * 12
            reqDeduct = reqDeduct + CleanNumber(.Supplies) * 12
            reqDeduct = reqDeduct + CleanNumber(.Gifts) * 12
            reqDeduct = reqDeduct + CleanNumber(.Materials) * 12
            reqDeduct = reqDeduct + CleanNumber(.Phones) * 12
            reqDeduct = reqDeduct + CleanNumber(.Internet) * 12
            reqDeduct = reqDeduct + CleanNumber(.Kids) * 12
            reqDeduct = reqDeduct + CleanNumber(.Subscriptions) * 12
            reqDeduct = reqDeduct + CleanNumber(.Entertainment) * 12
            reqDeduct = reqDeduct + CleanNumber(.Activities) * 12
            reqDeduct = reqDeduct + CleanNumber(.Events) * 12
            reqDeduct = reqDeduct + CleanNumber(.Medical) * 12
            reqDeduct = reqDeduct + CleanNumber(.Recreational) * 12
            Select Case .TaxRate
               Case 1: reqAmount = reqDeduct * .10
               Case 2: reqAmount = reqDeduct * .15
               Case 3: reqAmount = reqDeduct * .25
               Case 4: reqAmount = reqDeduct * .28
               Case 5: reqAmount = reqDeduct * .33
               Case 6: reqAmount = reqDeduct * .35
               Case Else: reqAmount = reqDeduct * .33
            End Select            
         End With
         reqDeduct = FormatCurrency(reqDeduct)
         reqAmount = FormatCurrency(reqAmount)
         reqMonthly = FormatCurrency( reqAmount / 12 )

End Function

tmpMilesRate = 0
If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then
   AbortUser()
End If
If (reqSysCompanyID = 0) Then
   reqSysCompanyID = reqC
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oHomeTax = server.CreateObject("ptsHomeTaxUser.CHomeTax")
      If oHomeTax Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsHomeTaxUser.CHomeTax"
      Else
         With oHomeTax
            .SysCurrentLanguage = reqSysLanguage
            .HomeTaxID = 0
            If (reqMemberID <> 0) Then
               .FetchMember CLng(reqMemberID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (.HomeTaxID <> 0) Then
               GetRates
               CalcTax(oHomeTax)
            End If
            If (.HomeTaxID = 0) Then
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .MemberID = reqMemberID
               .TaxRate = 5
               If (reqMemberID <> 0) Then
                  HomeTaxID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            xmlHomeTax = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHomeTax = Nothing
      LoadHTML

   Case CLng(cActionUpdate):

      Set oHomeTax = server.CreateObject("ptsHomeTaxUser.CHomeTax")
      If oHomeTax Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsHomeTaxUser.CHomeTax"
      Else
         With oHomeTax
            .SysCurrentLanguage = reqSysLanguage
            If (reqMemberID <> 0) Then
               .FetchMember CLng(reqMemberID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If

            .Office = Request.Form.Item("Office")
            .Home = Request.Form.Item("Home")
            .Miles = Request.Form.Item("Miles")
            .Meetings = Request.Form.Item("Meetings")
            .Meals = Request.Form.Item("Meals")
            .Supplies = Request.Form.Item("Supplies")
            .Materials = Request.Form.Item("Materials")
            .Phones = Request.Form.Item("Phones")
            .Internet = Request.Form.Item("Internet")
            .Medical = Request.Form.Item("Medical")
            .Subscriptions = Request.Form.Item("Subscriptions")
            .Entertainment = Request.Form.Item("Entertainment")
            .Activities = Request.Form.Item("Activities")
            .Events = Request.Form.Item("Events")
            .Recreational = Request.Form.Item("Recreational")
            .Kids = Request.Form.Item("Kids")
            .Gifts = Request.Form.Item("Gifts")
            .TaxRate = Request.Form.Item("TaxRate")
            GetRates
            CalcTax(oHomeTax)
            If (reqMemberID <> 0) Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            xmlHomeTax = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHomeTax = Nothing
      LoadHTML
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
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " deduct=" + Chr(34) + CStr(reqDeduct) + Chr(34)
xmlParam = xmlParam + " amount=" + Chr(34) + CStr(reqAmount) + Chr(34)
xmlParam = xmlParam + " monthly=" + Chr(34) + CStr(reqMonthly) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlTaxRate
xmlTransaction = xmlTransaction +  xmlHomeTax
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\HomeTax[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\HomeTax[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "10400 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "10400 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "10400 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "10400.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "10400 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "10400 Load file (oData) failed with error code " + CStr(oData.parseError)
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