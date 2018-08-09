<!--#include file="Include\System.asp"-->
<!--#include file="Include\2FA.asp"-->
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
Dim oMerchant, xmlMerchant
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqMerchantID
Dim reqCompanyID
Dim reqUser2FA
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
   SetCache "15010URL", reqReturnURL
   SetCache "15010DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "15010")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqUser2FA =  Numeric(GetInput("User2FA", reqPageData))
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

If (reqSysUserGroup > 23) And (reqSysUserGroup <> 51) Then
   reqUser2FA = Is2FAMerchant(reqMerchantID)
End If
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqUser2FA = 1
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMerchantID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.Status < 3) Then
               reqUser2FA = 1
            End If
            tmpMerchant = .MerchantName
            tmpName = .NameFirst + " " + .NameLast
            tmpEmail = .Email
            tmpEnrollDate = .EnrollDate
            tmpBillDate = .BillDate
            tmpBillDays = .BillDays
            tmpAccess = .Access
            xmlMerchant = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMerchant = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Path = reqSysWebDirectory + "Sections/Company/" + CStr(reqCompanyID)
            .Filename = "Merchant.htm"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqMerchantID )
            xmlHTMLFile = Replace( xmlHTMLFile, "{merchant}", tmpMerchant )
            xmlHTMLFile = Replace( xmlHTMLFile, "{name}", tmpName )
            xmlHTMLFile = Replace( xmlHTMLFile, "{email}", tmpEmail )
            xmlHTMLFile = Replace( xmlHTMLFile, "{enrolldate}", tmpEnrollDate )
          
         End With
      End If
      Set oHTMLFile = Nothing
      If (reqCompanyID = 21) Then

         Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
         If oMerchant Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
         Else
            With oMerchant
               .SysCurrentLanguage = reqSysLanguage
               PendingOrders = CLng(.Custom(CLng(reqMerchantID), 2, 0, 0, 0, ""))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMerchant = Nothing

         Set oNexxus = server.CreateObject("ptsNexxusUser.CNexxus")
         If oNexxus Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsNexxusUser.CNexxus"
         Else
            With oNexxus
               .SysCurrentLanguage = reqSysLanguage
               Result = .Custom(28, 0, CLng(reqMerchantID), 0)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oNexxus = Nothing
         
            strDisplayOrders = "show"
            If PendingOrders = 0 Then strDisplayOrders = "none"
            If reqUser2FA = 0 Then
            strDisplay2FA = "show"
            strDisplayButtons = "none"
            Else
            strDisplay2FA = "none"
            strDisplayButtons = "show"
            End If
            xmlHTMLFile = Replace( xmlHTMLFile, "{display2FA}", strDisplay2FA )
            xmlHTMLFile = Replace( xmlHTMLFile, "{DisplayButtons}", strDisplayButtons )
            xmlHTMLFile = Replace( xmlHTMLFile, "{displayOrders}", strDisplayOrders )
            xmlHTMLFile = Replace( xmlHTMLFile, "{pendingorders}", PendingOrders )

            tmpToday = FormatDateTime(reqSysDate,1)
            aSection = Split( Result, "|")
            a1 = Split( aSection(0), "^")
            a2 = Split( aSection(1), "^")
            a3 = Split( aSection(2), "^")
            a4 = Split( aSection(3), "^")
            a5 = Split( aSection(4), "^")
            tmpSales1 = FormatCurrency(a1(0))
            tmpSales2 = FormatCurrency(a1(1))
            tmpSales3 = FormatCurrency(a1(2))
            tmpSales4 = FormatCurrency(a1(3))
            If a2(0) = "" Then a2(0) = "No Promotions Done Yet!"
            If a3(0) = "" Then a3(0) = "No Rewards Defined Yet!"
            If tmpAccess = "" Then tmpAccess = "Anytime"
            tmpBill2 = FormatCurrency(a5(1))
            tmpBill4 = FormatCurrency(a5(3))
            tmpBill6 = FormatCurrency(a5(5))
            tmpBill8 = FormatCurrency(a5(7))
            tmpBillAmount = FormatCurrency( CCUR(a5(3)) - ( CCUR(a5(5)) + CCUR(a5(7)) ) )

            xmlHTMLFile = Replace( xmlHTMLFile, "{today}", tmpToday )
            xmlHTMLFile = Replace( xmlHTMLFile, "{sales1}", tmpSales1 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{sales2}", tmpSales2 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{sales3}", tmpSales3 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{sales4}", tmpSales4 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{promo1}", a2(0) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{promo2}", a2(1) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{promo3}", a2(2) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{promo4}", a2(3) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{reward1}", a3(0) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{reward2}", a3(1) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{reward3}", a3(2) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{reward4}", a3(3) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{refer1}", a4(0) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{refer2}", a4(1) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{refer3}", a4(2) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{refer4}", a4(3) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{access}", tmpAccess )
            xmlHTMLFile = Replace( xmlHTMLFile, "{billdays}", tmpBillDays )
            xmlHTMLFile = Replace( xmlHTMLFile, "{billdate}", tmpBillDate )
            xmlHTMLFile = Replace( xmlHTMLFile, "{billamount}", tmpBillAmount )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill1}", a5(0) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill2}", tmpBill2 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill3}", a5(2) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill4}", tmpBill4 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill5}", a5(4) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill6}", tmpBill6 )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill7}", a5(6) )
            xmlHTMLFile = Replace( xmlHTMLFile, "{bill8}", tmpBill8 )
          
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " user2fa=" + Chr(34) + CStr(reqUser2FA) + Chr(34)
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
fileLanguage = "Language" + "\15010[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\15010[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "15010 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "15010 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "15010 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "15010.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "15010 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "15010 Load file (oData) failed with error code " + CStr(oData.parseError)
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