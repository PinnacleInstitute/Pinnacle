<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionFind = 5
Const cActionPrevious = 6
Const cActionNext = 7
Const cActionAddPayout = 8
Const cActionAddPayment = 9
Const cActionAddWithraw = 10
Const cActionTransfer = 11
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
Dim oMember, xmlMember
Dim oPayout, xmlPayout
Dim oCompany, xmlCompany
Dim oPayouts, xmlPayouts
Dim oBookmark, xmlBookmark
'-----declare page parameters
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqOwnerType
Dim reqOwnerID
Dim reqFromDate
Dim reqToDate
Dim reqAvailable
Dim reqPending
Dim reqTotal
Dim reqDeleteID
Dim reqEmailID
Dim reqWithdraw
Dim reqNegative
Dim reqTransfer
Dim reqPayment
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
   SetCache "0831URL", reqReturnURL
   SetCache "0831DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0831")
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
reqSearchText =  GetInput("SearchText", reqPageData)
reqFindTypeID =  Numeric(GetInput("FindTypeID", reqPageData))
reqBookmark =  GetInput("Bookmark", reqPageData)
reqDirection =  Numeric(GetInput("Direction", reqPageData))
reqOwnerType =  Numeric(GetInput("OwnerType", reqPageData))
reqOwnerID =  Numeric(GetInput("OwnerID", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
reqAvailable =  GetInput("Available", reqPageData)
reqPending =  GetInput("Pending", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqDeleteID =  Numeric(GetInput("DeleteID", reqPageData))
reqEmailID =  Numeric(GetInput("EmailID", reqPageData))
reqWithdraw =  Numeric(GetInput("Withdraw", reqPageData))
reqNegative =  Numeric(GetInput("Negative", reqPageData))
reqTransfer =  Numeric(GetInput("Transfer", reqPageData))
reqPayment =  Numeric(GetInput("Payment", reqPageData))
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

If (reqFindTypeID = 0) Then
   reqFindTypeID = 0810
End If
reqTransfer = 1
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqWithdraw = 1
End If
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysCompanyID = 17) Or (reqSysCompanyID = 21) Then
   reqPayment = 1
End If
If (reqSysUserGroup = 41) Then
   If (reqSysCompanyID = 17) Or (reqSysCompanyID = 21) Then
      tmp2FA = Is2FA(reqSysUserID)
      If (tmp2FA = 0) Then
         reqTransfer = -1
         reqWithdraw = -1
      End If
   End If
End If
If (reqSysUserGroup = 41) And (reqOwnerID <> reqSysMemberID) Then
   AbortUser()
End If
If (reqSysUserGroup = 41) Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqOwnerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.Status > 3) Then
            AbortUser()
         End If
      End With
   End If
   Set oMember = Nothing
End If
If (reqDeleteID <> 0) Then

   Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
   If oPayout Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
   Else
      With oPayout
         .SysCurrentLanguage = reqSysLanguage
         .Load reqDeleteID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.Status = 4) Or (.Status = 5) Then
            .Delete reqDeleteID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oPayout = Nothing

   Response.Redirect "0831.asp" & "?OwnerType=" & reqOwnerType & "&OwnerID=" & reqOwnerID
End If
If (reqEmailID <> 0) Then

   Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
   If oPayout Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
   Else
      With oPayout
         .SysCurrentLanguage = reqSysLanguage
         .Load reqEmailID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpAmount = FormatCurrency(ABS(.Amount),2)
      End With
   End If
   Set oPayout = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqOwnerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpFirstName = .NameFirst
         tmpLastName = .NameLast
         tmpCompanyID = .CompanyID
         tmpTo = .Email
      End With
   End If
   Set oMember = Nothing

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load tmpCompanyID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
         tmpFrom = .Email
      End With
   End If
   Set oCompany = Nothing
   tmpSubject = "Withdrawal Request Verification"
   
            reqAmount = FormatCurrency(reqAmount,2)
               tmpURL = "http://" + reqSysServerName + reqSysServerPath + "0835.asp?p=" + CSTR(reqPayoutID)
          tmpBody = tmpFirstName + " " + tmpLastName + "<p><a href=""" + tmpURL + """>Click Here to verify your withdrawal request for " + CSTR(reqAmount) + ".</a>"
            SendEmail tmpCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
          

   Response.Redirect "0831.asp" & "?OwnerType=" & reqOwnerType & "&OwnerID=" & reqOwnerID
End If
tmpShow = 0
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
   tmpShow = 1
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqToDate = reqSysDate
      reqFromDate = DateAdd("m", -2, reqToDate)
      reqBookmark = ""
      reqDirection = 1

      Set oPayouts = server.CreateObject("ptsPayoutUser.CPayouts")
      If oPayouts Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayouts"
      Else
         With oPayouts
            .SysCurrentLanguage = reqSysLanguage
            .FindTypeID = reqFindTypeID
            xmlPayouts = .XML(14)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayouts = Nothing

   Case CLng(cActionFind):
      reqBookmark = ""
      reqDirection = 1

   Case CLng(cActionPrevious):
      reqDirection = 2

   Case CLng(cActionNext):
      reqDirection = 1

   Case CLng(cActionAddPayout):

      Response.Redirect "0802.asp" & "?OwnerType=" & reqOwnerType & "&OwnerID=" & reqOwnerID & "&contentpage=" & 3 & "&popup=" & 0 & "&wallet=" & 1 & "&ReturnURL=" & reqPageURL

   Case CLng(cActionAddPayment):

      Response.Redirect "0832.asp" & "?OwnerID=" & reqOwnerID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionAddWithraw):

      Response.Redirect "0834.asp" & "?OwnerID=" & reqOwnerID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionTransfer):

      Response.Redirect "0833.asp" & "?OwnerID=" & reqOwnerID & "&ReturnURL=" & reqPageURL
End Select

Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
If oPayout Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
Else
   With oPayout
      .SysCurrentLanguage = reqSysLanguage
      Result = .WalletTotal(CLng(reqOwnerType), CLng(reqOwnerID))
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      
          a = Split(Result, ";")
          If a(0) < 0 Then reqNegative = 1
          reqAvailable = FormatCurrency(a(0),2)
          reqPending = FormatCurrency(a(1),2)
          reqTotal = FormatCurrency(a(2),2)
        
   End With
End If
Set oPayout = Nothing

If (reqWithdraw = 0) Then
   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqOwnerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.IsIncluded = 0) Then
            reqWithdraw = 2
         End If
         If (.IsIncluded <> 0) Then
            reqWithdraw = 1
         End If
      End With
   End If
   Set oMember = Nothing
End If

Set oPayouts = server.CreateObject("ptsPayoutUser.CPayouts")
If oPayouts Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayouts"
Else
   With oPayouts
      .SysCurrentLanguage = reqSysLanguage
      reqBookmark = .FindDateOwnerShow(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqOwnerType), CLng(reqOwnerID), CDate(reqFromDate), CDate(reqToDate), tmpShow, CLng(reqSysUserID))
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      
          For Each oItem in oPayouts
            With oItem
            If CCUR(.Amount) < 0 Then .CompanyID = 0
            End With
          Next
          reqAvailable = FormatCurrency(reqAvailable,2)
        
      xmlPayouts = .XML(15)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oPayouts = Nothing

Set oBookmark = server.CreateObject("wtSystem.CBookmark")
If oBookmark Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - wtSystem.CBookmark"
Else
   With oBookmark
      .LastBookmark = reqBookmark
      xmlBookmark = .XML()
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oBookmark = Nothing

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
xmlParam = xmlParam + " searchtext=" + Chr(34) + CleanXML(reqSearchText) + Chr(34)
xmlParam = xmlParam + " findtypeid=" + Chr(34) + CStr(reqFindTypeID) + Chr(34)
xmlParam = xmlParam + " bookmark=" + Chr(34) + CleanXML(reqBookmark) + Chr(34)
xmlParam = xmlParam + " direction=" + Chr(34) + CStr(reqDirection) + Chr(34)
xmlParam = xmlParam + " ownertype=" + Chr(34) + CStr(reqOwnerType) + Chr(34)
xmlParam = xmlParam + " ownerid=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " available=" + Chr(34) + CStr(reqAvailable) + Chr(34)
xmlParam = xmlParam + " pending=" + Chr(34) + CStr(reqPending) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CStr(reqTotal) + Chr(34)
xmlParam = xmlParam + " deleteid=" + Chr(34) + CStr(reqDeleteID) + Chr(34)
xmlParam = xmlParam + " emailid=" + Chr(34) + CStr(reqEmailID) + Chr(34)
xmlParam = xmlParam + " withdraw=" + Chr(34) + CStr(reqWithdraw) + Chr(34)
xmlParam = xmlParam + " negative=" + Chr(34) + CStr(reqNegative) + Chr(34)
xmlParam = xmlParam + " transfer=" + Chr(34) + CStr(reqTransfer) + Chr(34)
xmlParam = xmlParam + " payment=" + Chr(34) + CStr(reqPayment) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlPayout
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlPayouts
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Payout[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Payout[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0831 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0831 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0831 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0831.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0831 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0831 Load file (oData) failed with error code " + CStr(oData.parseError)
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