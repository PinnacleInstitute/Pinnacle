<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\MarketMerchants.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionTestMarket = 5
Const cActionPreviewMarket = 6
Const cActionSendMarket = 7
Const cActionRefresh = 8
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
Dim oCountrys, xmlCountrys
Dim oMarket, xmlMarket
Dim oHTMLFile, xmlHTMLFile
Dim oConsumer, xmlConsumer
Dim oMerchant, xmlMerchant
'-----declare page parameters
Dim reqMarketID
Dim reqCompanyID
Dim reqCopyID
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
   SetCache "18203URL", reqReturnURL
   SetCache "18203DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "18203")
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
reqMarketID =  Numeric(GetInput("MarketID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqCopyID =  Numeric(GetInput("CopyID", reqPageData))
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

Sub LoadLists()
   On Error Resume Next

   Set oCountrys = server.CreateObject("ptsCountryUser.CCountrys")
   If oCountrys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountrys"
   Else
      With oCountrys
         .SysCurrentLanguage = reqSysLanguage
         xmlCountrys = xmlCountrys + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCountrys = Nothing
End Sub

Sub AddMarket()
   On Error Resume Next
   LoadLists
   If (reqCopyID = 0) Then
      tmpName = "Test Market"
      tmpFrom = "support@nexxusrewards.com"
      tmpSubject = "Nexxus Rewards for {firstname}"
      tmpCountryID = 224
      tmpTarget = ""
      tmpTestEmail = ""
   End If

   If (reqCopyID <> 0) Then
      Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
      If oMarket Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
      Else
         With oMarket
            .SysCurrentLanguage = reqSysLanguage
            .Load reqCopyID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpName = .MarketName
            tmpFrom = .FromEmail
            tmpSubject = .Subject
            tmpCountryID = .CountryID
            tmpTarget = .Target
            tmpTestEmail = .TestEmail
         End With
      End If
      Set oMarket = Nothing
   End If

   Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
   If oMarket Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
   Else
      With oMarket
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CompanyID = reqCompanyID
         .MarketName = tmpName
         .FromEmail = tmpFrom
         .Subject = tmpSubject
         .Status = 1
         .CountryID = tmpCountryID
         .Target = tmpTarget
         .CreateDate = reqSysDate
         .SendDate = reqSysDate
         .SendDays = 7
         .TestEmail = tmpTestEmail
         reqMarketID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlMarket = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMarket = Nothing

   If (reqCopyID <> 0) Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .FileName = reqCopyID
            .Path = reqSysWebDirectory + "Sections/Company/" & reqCompanyID & "/Market/"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .FileName = reqMarketID
            .Save 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
End Sub

Sub LoadMarket()
   On Error Resume Next
   LoadLists

   Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
   If oMarket Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
   Else
      With oMarket
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMarketID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (reqCompanyID = 0) Then
            reqCompanyID = .CompanyID
         End If
         xmlMarket = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMarket = Nothing

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .FileName = reqMarketID
         .Path = reqSysWebDirectory + "Sections/Company/" & reqCompanyID & "/Market/"
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

Sub SaveMarket()
   On Error Resume Next
   tmpTarget = Request.Form.Item("Target")
   tmpCountryID = Request.Form.Item("CountryID")

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         tmpConsumers = CLng(.CountMarketEmail(CLng(reqCompanyID), tmpTarget, tmpCountryID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oConsumer = Nothing

   Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
   If oMerchant Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
   Else
      With oMerchant
         .SysCurrentLanguage = reqSysLanguage
         tmpResults = .CountMarket(tmpTarget, tmpCountryID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
              a = split(tmpResults, "|")
              tmpMerchants = a(0)
              tmpOrgs = a(1)
            
      End With
   End If
   Set oMerchant = Nothing

   Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
   If oMarket Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
   Else
      With oMarket
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMarketID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Consumers = tmpConsumers
         .Merchants = tmpMerchants
         .Orgs = tmpOrgs
         reqCompanyID = .CompanyID

         .MarketName = Request.Form.Item("MarketName")
         .CountryID = Request.Form.Item("CountryID")
         .Target = Request.Form.Item("Target")
         .FromEmail = Request.Form.Item("FromEmail")
         .Subject = Request.Form.Item("Subject")
         .Status = Request.Form.Item("Status")
         .SendDate = Request.Form.Item("SendDate")
         .SendDays = Request.Form.Item("SendDays")
         .TestEmail = Request.Form.Item("TestEmail")
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError <> "") Then
            xmlMarket = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            LoadMarket
         End If
      End With
   End If
   Set oMarket = Nothing

   If (xmlError = "") Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .FileName = reqMarketID
            .Path = reqSysWebDirectory + "Sections/Company/" & reqCompanyID & "/Market/"
            .Language = reqSysLanguage
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

If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqMarketID <> 0) Then
         LoadMarket
      End If
      If (reqMarketID = 0) Then
         AddMarket
      End If

   Case CLng(cActionUpdate):
      SaveMarket

      If (xmlError = "") Then
         reqReturnURL = GetCache("18203URL")
         reqReturnData = GetCache("18203DATA")
         SetCache "18203URL", ""
         SetCache "18203DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("18203URL")
      reqReturnData = GetCache("18203DATA")
      SetCache "18203URL", ""
      SetCache "18203DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
      If oMarket Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
      Else
         With oMarket
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqMarketID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMarket = Nothing
      If (xmlError <> "") Then
         LoadMarket
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("18203URL")
         reqReturnData = GetCache("18203DATA")
         SetCache "18203URL", ""
         SetCache "18203DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionTestMarket):
      tmpEmail = Request.Form.Item("TestEmail")
      SaveMarket
      LoadMarket
      If (tmpEmail = "") Then
         DoError 10007, "", "Please enter a test market email address."
      End If
      If (tmpEmail <> "") Then
         tmpData = Request.Form.Item("Data")
         tmpTarget = Request.Form.Item("Target")
         tmpCountryID = Request.Form.Item("CountryID")
         
  GetMerchants tmpTarget, tmpCountryID, tmpFeatured, tmpNew, tmpMerchants, tmpOrgs

      End If

      Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
      If oMarket Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
      Else
         With oMarket
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMarketID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlMarket = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpTo = tmpEmail
            tmpFrom = .FromEmail
            tmpSender = tmpFrom
            
                     If InStr(tmpTo, "@") > 0 Then
              If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
              tmpSubject = Replace( .Subject, "{firstname}", "Bill" )
              tmpSubject = Replace( tmpSubject, "{lastname}", "Jones" )
              tmpBody = Replace( tmpData, "{firstname}", "Bill" )
              tmpBody = Replace( tmpBody, "{lastname}", "Jones" )
              tmpBody = Replace( tmpBody, "{id}", "0" )
              tmpBody = Replace( tmpBody, "{email}", .TestEmail )
              tmpBody = Replace( tmpBody, "{memberid}", "0" )

              tmpBody = Replace( tmpBody, "{featured-merchants}", tmpFeatured )
              tmpBody = Replace( tmpBody, "{new-merchants}", tmpNew )
              tmpBody = Replace( tmpBody, "{orgs}", tmpOrgs )
              tmpBody = Replace( tmpBody, "{merchants}", tmpMerchants )

              SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
              End If
            
         End With
      End If
      Set oMarket = Nothing

   Case CLng(cActionPreviewMarket):
      SaveMarket

      If (xmlError = "") Then
         Response.Redirect "18207.asp" & "?MarketID=" & reqMarketID
      End If

   Case CLng(cActionSendMarket):
      SaveMarket
      If (xmlError = "") Then
         Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
         If oHTTP Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
         Else
            tmpServer = "http://" + reqSysServerName + reqSysServerPath
            oHTTP.open "GET", tmpServer + "18206.asp" & "?MarketID=" & reqMarketID
            oHTTP.send
         End If
         Set oHTTP = Nothing
      End If

      reqReturnURL = GetCache("18203URL")
      reqReturnData = GetCache("18203DATA")
      SetCache "18203URL", ""
      SetCache "18203DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionRefresh):
      SaveMarket
      LoadMarket
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
xmlParam = xmlParam + " marketid=" + Chr(34) + CStr(reqMarketID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " copyid=" + Chr(34) + CStr(reqCopyID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlMarket
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Market[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Market[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "18203 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "18203 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "18203 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "18203.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "18203 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "18203 Load file (oData) failed with error code " + CStr(oData.parseError)
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