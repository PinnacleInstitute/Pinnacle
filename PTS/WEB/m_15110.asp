<!--#include file="Include\System.asp"-->
<!--#include file="Include\Company.asp"-->
<!--#include file="Include\Coins.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionNewShopper = 1
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
Dim oConsumer, xmlConsumer
Dim oRewards, xmlRewards
'-----other transaction data variables
Dim xmlReward2
'-----declare page parameters
Dim reqConsumerID
Dim reqC
Dim reqReferrals
Dim reqReward1
Dim reqReward2
Dim reqReward3
Dim reqReward4
Dim reqNXCPrice
Dim reqReward1Price
Dim reqReward2Price
Dim reqReward3Price
Dim reqNXCPriceText
Dim reqURL
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
   SetCache "m_15110URL", reqReturnURL
   SetCache "m_15110DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_15110")
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
reqConsumerID =  Numeric(GetInput("ConsumerID", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqReferrals =  Numeric(GetInput("Referrals", reqPageData))
reqReward1 =  GetInput("Reward1", reqPageData)
reqReward2 =  GetInput("Reward2", reqPageData)
reqReward3 =  GetInput("Reward3", reqPageData)
reqReward4 =  GetInput("Reward4", reqPageData)
reqNXCPrice =  GetInput("NXCPrice", reqPageData)
reqReward1Price =  GetInput("Reward1Price", reqPageData)
reqReward2Price =  GetInput("Reward2Price", reqPageData)
reqReward3Price =  GetInput("Reward3Price", reqPageData)
reqNXCPriceText =  GetInput("NXCPriceText", reqPageData)
reqURL =  GetInput("URL", reqPageData)
If (reqC = 0) Then
   reqC = 21
End If
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


          reqURL = "http://" + reqSysServerName + reqSysServerPath + "NewShopper.asp?s=" + CStr(reqConsumerID)
        
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            Result = .Custom(CLng(reqConsumerID), 1, 0, 0, "")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            NXCprice = CoinPrice( 2, "USD" )
            
              a = Split(Result, "|")
              total = UBOUND(a)
              reqReferrals = a(0)
              reqReward1 = a(1)
              reqReward2 = a(2)
              reqReward3 = a(3)
              reqReward4 = a(4)
              reqReward1Price = FormatCurrency(reqReward1 * NXCPrice)
              reqReward2Price = FormatCurrency(reqReward2 * NXCPrice)
              reqReward3Price = FormatCurrency(reqReward3 * NXCPrice)
              reqNXCPriceText = FormatCurrency(NXCPrice,4)
            
         End With
      End If
      Set oConsumer = Nothing

      Set oRewards = server.CreateObject("ptsRewardUser.CRewards")
      If oRewards Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsRewardUser.CRewards"
      Else
         With oRewards
            .SysCurrentLanguage = reqSysLanguage
            .ListCash CLng(reqConsumerID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            For Each oItem in oRewards
            With oItem
            If .Amount < 0 Then .RewardType = 0
            End With
            Next
          
            xmlRewards = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .ListPointsSummary CLng(reqConsumerID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlReward2 = .XML(13, "Reward2")
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oRewards = Nothing

   Case CLng(cActionNewShopper):

      Response.Redirect "m_NewShopper.asp" & "?S=" & reqConsumerID & "&Ret=" & 1 & "&ReturnURL=" & reqPageURL
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
xmlParam = xmlParam + " consumerid=" + Chr(34) + CStr(reqConsumerID) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " referrals=" + Chr(34) + CStr(reqReferrals) + Chr(34)
xmlParam = xmlParam + " reward1=" + Chr(34) + CStr(reqReward1) + Chr(34)
xmlParam = xmlParam + " reward2=" + Chr(34) + CStr(reqReward2) + Chr(34)
xmlParam = xmlParam + " reward3=" + Chr(34) + CStr(reqReward3) + Chr(34)
xmlParam = xmlParam + " reward4=" + Chr(34) + CStr(reqReward4) + Chr(34)
xmlParam = xmlParam + " nxcprice=" + Chr(34) + CStr(reqNXCPrice) + Chr(34)
xmlParam = xmlParam + " reward1price=" + Chr(34) + CleanXML(reqReward1Price) + Chr(34)
xmlParam = xmlParam + " reward2price=" + Chr(34) + CleanXML(reqReward2Price) + Chr(34)
xmlParam = xmlParam + " reward3price=" + Chr(34) + CleanXML(reqReward3Price) + Chr(34)
xmlParam = xmlParam + " nxcpricetext=" + Chr(34) + CleanXML(reqNXCPriceText) + Chr(34)
xmlParam = xmlParam + " url=" + Chr(34) + CleanXML(reqURL) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlRewards
xmlTransaction = xmlTransaction +  xmlReward2
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Consumer[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Consumer[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_15110 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_15110 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_15110 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_15110.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_15110 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_15110 Load file (oData) failed with error code " + CStr(oData.parseError)
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