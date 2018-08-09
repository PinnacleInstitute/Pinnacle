<!--#include file="Include\System.asp"-->
<!--#include file="Include\Audit.asp"-->
<!--#include file="Include\IP.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 2
Const cActionCancel = 3
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
Dim oCoption, xmlCoption
Dim oPayout, xmlPayout
Dim oPayments, xmlPayments
'-----declare page parameters
Dim reqOwnerID
Dim reqCompanyID
Dim reqMemberID
Dim reqPaymentID
Dim reqAvailable
Dim reqMemberName
Dim reqCount
Dim reqTxn
Dim reqOverride
Dim reqNote
Dim reqMember2FA
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
   SetCache "0832URL", reqReturnURL
   SetCache "0832DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0832")
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
reqOwnerID =  Numeric(GetInput("OwnerID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqPaymentID =  Numeric(GetInput("PaymentID", reqPageData))
reqAvailable =  GetInput("Available", reqPageData)
reqMemberName =  GetInput("MemberName", reqPageData)
reqCount =  Numeric(GetInput("Count", reqPageData))
reqTxn =  Numeric(GetInput("Txn", reqPageData))
reqOverride =  Numeric(GetInput("Override", reqPageData))
reqNote =  GetInput("Note", reqPageData)
reqMember2FA =  Numeric(GetInput("Member2FA", reqPageData))
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

'-----Log Audit Information
DoAudit "0832", "?/?"

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

Sub NewPayment()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqOwnerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqMemberName = .NameFirst + " " + .NameLast
         If (reqMemberID <> reqOwnerID) Then
            .Load reqMemberID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.CompanyID = reqCompanyID) Then
               reqMemberName = .NameFirst + " " + .NameLast
               reqNote = reqMemberName
            End If
            If (.CompanyID <> reqCompanyID) Then
               reqMemberID = reqOwnerID
            End If
         End If
      End With
   End If
   Set oMember = Nothing

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
         tmpSalesOrders = 1
         If (InStr(.Options,"j") > 0) Then
            tmpSalesOrders = 2
         End If
      End With
   End If
   Set oCoption = Nothing

   Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
   If oPayout Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
   Else
      With oPayout
         .SysCurrentLanguage = reqSysLanguage
         Result = .WalletTotal(04, CLng(reqOwnerID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            a = Split(Result, ";")
            reqAvailable = a(0)
          
      End With
   End If
   Set oPayout = Nothing

   Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
   If oPayments Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
   Else
      With oPayments
         .SysCurrentLanguage = reqSysLanguage
         .ListOwnerStatus 04, reqMemberID, tmpSalesOrders
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
              For Each oItem in oPayments
                With oItem
                  If CCUR(reqAvailable) >= CCUR(.Amount) Then
                    reqCount = reqCount + 1
                  Else
                    If reqOverride = 0 Then
                      .Status = 99
                    Else
                      .Status = 98
                      reqCount = reqCount + 1
                    End If
                  End If
                End With
              Next
              reqAvailable = FormatCurrency(reqAvailable,2)
            
         xmlPayments = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPayments = Nothing
End Sub

If (reqSysUserGroup = 41) Then
   reqMember2FA = Is2FA(reqSysUserID)
End If
If (reqMemberID = 0) Then
   reqMemberID = reqOwnerID
End If
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
   reqOverride = 1
End If
If (reqSysUserGroup = 41) And (reqOwnerID <> reqSysMemberID) Then
   AbortUser()
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewPayment

   Case CLng(cActionAdd):

      Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
      If oPayout Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
      Else
         With oPayout
            .SysCurrentLanguage = reqSysLanguage
            Result = .WalletTotal(04, CLng(reqOwnerID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            a = Split(Result, ";")
            reqAvailable = a(0)
          
         End With
      End If
      Set oPayout = Nothing
      If (reqPaymentID = 0) Then
         reqTxn = 1
         NewPayment
      End If
      If (reqPaymentID <> 0) Then

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
               tmpSalesOrders = 1
               If (InStr(.Options,"j") > 0) Then
                  tmpSalesOrders = 2
               End If
            End With
         End If
         Set oCoption = Nothing

         Set oPayments = server.CreateObject("ptsPaymentUser.CPayments")
         If oPayments Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayments"
         Else
            With oPayments
               .SysCurrentLanguage = reqSysLanguage
               .ListOwnerStatus 04, reqMemberID, tmpSalesOrders
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
              tmpAmount = 0.00
              For Each oItem in oPayments
                With oItem
                  If reqPaymentID = CLng(.PaymentID) Then
                    tmpAmount = CCUR(.Amount)
                    Exit For
                  End If
                End With
              Next
            
               xmlPayments = .XML(13)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayments = Nothing
         If (reqOverride = 0) Then
            If (CCUR(tmpAmount) > CCUR(reqAvailable)) Or (CCUR(tmpAmount) <= 0) Then
               reqTxn = 2
               NewPayment
            End If
         End If
         If (reqTxn = 0) Then

            Set oPayout = server.CreateObject("ptsPayoutUser.CPayout")
            If oPayout Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPayoutUser.CPayout"
            Else
               With oPayout
                  .SysCurrentLanguage = reqSysLanguage
                  .Load 0, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .CompanyID = reqCompanyID
                  .OwnerType = 04
                  .OwnerID = reqOwnerID
                  .PayDate = reqSysDate
                  .PaidDate = reqSysDate
                  .Status = 1
                  .PayType = 90
                  .Amount = CCUR(tmpAmount) * -1
                  .Reference = reqPaymentID
                  
                IP = Request.ServerVariables("REMOTE_ADDR")
                tmpLocation = GetIPCity( IP )
              
                  .Notes = Left(reqNote + " " + IP + " " + tmpLocation, 500) 
                  PayoutID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oPayout = Nothing

            Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
            If oPayment Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
            Else
               With oPayment
                  .SysCurrentLanguage = reqSysLanguage
                  .Load reqPaymentID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .Status = 3
                  .PaidDate = reqSysDate
                  .PayType = 10
                  .Reference = PayoutID
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oPayment = Nothing

            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  Count = CLng(.Custom(CLng(reqCompanyID), 99, 0, reqPaymentID, 0))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oCompany = Nothing
         End If
      End If

      If (xmlError = "") And (reqTxn = 0) And (reqPaymentID <> 0) Then
         reqReturnURL = GetCache("0832URL")
         reqReturnData = GetCache("0832DATA")
         SetCache "0832URL", ""
         SetCache "0832DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("0832URL")
      reqReturnData = GetCache("0832DATA")
      SetCache "0832URL", ""
      SetCache "0832DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
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
xmlParam = xmlParam + " ownerid=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " paymentid=" + Chr(34) + CStr(reqPaymentID) + Chr(34)
xmlParam = xmlParam + " available=" + Chr(34) + CStr(reqAvailable) + Chr(34)
xmlParam = xmlParam + " membername=" + Chr(34) + CleanXML(reqMemberName) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " txn=" + Chr(34) + CStr(reqTxn) + Chr(34)
xmlParam = xmlParam + " override=" + Chr(34) + CStr(reqOverride) + Chr(34)
xmlParam = xmlParam + " note=" + Chr(34) + CleanXML(reqNote) + Chr(34)
xmlParam = xmlParam + " member2fa=" + Chr(34) + CStr(reqMember2FA) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlPayout
xmlTransaction = xmlTransaction +  xmlPayments
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
   Response.Write "0832 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0832 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0832 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0832.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0832 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0832 Load file (oData) failed with error code " + CStr(oData.parseError)
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