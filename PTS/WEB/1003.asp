<!--#include file="Include\System.asp"-->
<!--#include file="Include\Audit.asp"-->
<!--#include file="Include\Billing.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionUpdateMethod = 5
Const cActionReclaim = 6
Const cActionClearMethod = 7
Const cActionRequestBitcoin = 8
Const cActionProductOrder = 9
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
Dim oCompany, xmlCompany
Dim oBusiness, xmlBusiness
Dim oCoption, xmlCoption
Dim oPayment, xmlPayment
Dim oSalesOrder, xmlSalesOrder
Dim oMember, xmlMember
Dim oBilling, xmlBilling
'-----declare page parameters
Dim reqPaymentID
Dim reqPaymentOptions
Dim reqMiscPay1
Dim reqMiscPay2
Dim reqMiscPay3
Dim reqCompanyID
Dim reqPreview
Dim reqPopup
Dim reqTxn
Dim reqOwnerType
Dim reqMemberID
Dim reqSalesOrderID
Dim reqHidePayment
Dim reqMessage
Dim reqProductOrder
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
   SetCache "1003URL", reqReturnURL
   SetCache "1003DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "1003")
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
reqPaymentID =  Numeric(GetInput("PaymentID", reqPageData))
reqPaymentOptions =  GetInput("PaymentOptions", reqPageData)
reqMiscPay1 =  GetInput("MiscPay1", reqPageData)
reqMiscPay2 =  GetInput("MiscPay2", reqPageData)
reqMiscPay3 =  GetInput("MiscPay3", reqPageData)
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqPreview =  Numeric(GetInput("Preview", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqTxn =  Numeric(GetInput("Txn", reqPageData))
reqOwnerType =  Numeric(GetInput("OwnerType", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqSalesOrderID =  Numeric(GetInput("SalesOrderID", reqPageData))
reqHidePayment =  Numeric(GetInput("HidePayment", reqPageData))
reqMessage =  GetInput("Message", reqPageData)
reqProductOrder =  Numeric(GetInput("ProductOrder", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 125
reqSysUserStatus = GetCache("USERSTATUS")
reqSysUserName = GetCache("USERNAME")

'-----Log Audit Information
DoAudit "1003", "?/2,21/0,51/0"

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

Sub ProcessPayment()
   On Error Resume Next

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         Count = CLng(.Custom(CLng(reqCompanyID), 99, 0, CLng(reqPaymentID), 0))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCompany = Nothing
End Sub

Sub LoadPayTypes()
   On Error Resume Next

   If (reqCompanyID = 0) Then
      Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
      If oBusiness Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
      Else
         With oBusiness
            .Load 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPaymentOptions = .PaymentOptions
            reqMiscPay1 = .MiscPay1
            reqMiscPay2 = .MiscPay2
            reqMiscPay3 = .MiscPay3
         End With
      End If
      Set oBusiness = Nothing
   End If

   If (reqCompanyID <> 0) Then
      Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
      If oCoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
      Else
         With oCoption
            .FetchCompany CLng(reqCompanyID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPaymentOptions = .PaymentOptions
            If (reqPaymentOptions = "") Then
               reqPaymentOptions = "ABCDEFGHIJK"
            End If
            reqMiscPay1 = .MiscPay1
            reqMiscPay2 = .MiscPay2
            reqMiscPay3 = .MiscPay3
         End With
      End If
      Set oCoption = Nothing
   End If
End Sub

Sub LoadPayment()
   On Error Resume Next

   Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
   If oPayment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
   Else
      With oPayment
         .Load CLng(reqPaymentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (reqSysUserGroup > 23) And (.CompanyID <> CSTR(reqSysCompanyID)) Then
            AbortUser()
         End If
         reqCompanyID = .CompanyID
         reqOwnerType = .OwnerType
         If (.CommStatus = 0) Then
            .CommStatus = 1
         End If
         If (InStr(.Description, "Charged") <> 0) Then
            reqPreview = 1
            reqHidePayment = 1
         End If
         If (.OwnerType = 04) Then
            reqMemberID = .OwnerID
         End If
         If (.OwnerType = 52) Then
            reqSalesOrderID = .OwnerID
         End If
         xmlPayment = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.CompanyID = 17) Then
            If (.Status = 3) Then
               
                        tmpCode = Replace( .Purpose, "u", "" )
                        If TRIM(tmpCode) <> "" Then
                        If InStr("103,203,104,204,105,205,106,206,107,207,108,208,111,112,113,114,115,116", tmpCode) > 0 Then
                        If InStr(.Notes, "GCRORDER:") = 0 Then reqProductOrder = 1
                        End If
                        End If
                     
            End If
         End If
      End With
   End If
   Set oPayment = Nothing
   LoadPayTypes
End Sub

Sub ReloadPayment()
   On Error Resume Next

   Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
   If oPayment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
   Else
      With oPayment
         .Load CLng(reqPaymentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (InStr(.Description, "Charged") <> 0) Then
            reqPreview = 1
            reqHidePayment = 1
         End If

         .PayDate = Request.Form.Item("PayDate")
         .PaidDate = Request.Form.Item("PaidDate")
         .Status = Request.Form.Item("Status")
         .Amount = Request.Form.Item("Amount")
         .Total = Request.Form.Item("Total")
         .Credit = Request.Form.Item("Credit")
         .Purpose = Request.Form.Item("Purpose")
         .PayType = Request.Form.Item("PayType")
         .PayType = Request.Form.Item("PayType")
         .Reference = Request.Form.Item("Reference")
         .CommStatus = Request.Form.Item("CommStatus")
         .CommDate = Request.Form.Item("CommDate")
         .OwnerType = Request.Form.Item("OwnerType")
         .OwnerID = Request.Form.Item("OwnerID")
         .ProductID = Request.Form.Item("ProductID")
         .PaidID = Request.Form.Item("PaidID")
         .Token = Request.Form.Item("Token")
         .TokenOwner = Request.Form.Item("TokenOwner")
         .Retail = Request.Form.Item("Retail")
         .Description = Request.Form.Item("Description")
         .Notes = Request.Form.Item("Notes")
         If (.OwnerType = 04) Then
            reqMemberID = .OwnerID
         End If
         If (.OwnerType <> 0) Then
            If (.OwnerType = 38) Then
               reqCompanyID = .OwnerID
            End If
            If (.OwnerType <> 38) Then
               reqCompanyID = CLng(.GetCompany(CLng(.OwnerType), CLng(.OwnerID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
         xmlPayment = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPayment = Nothing
   LoadPayTypes
End Sub

Sub SavePayment()
   On Error Resume Next

   Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
   If oPayment Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
   Else
      With oPayment
         .Load CLng(reqPaymentID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         oldStatus = .Status

         .PayDate = Request.Form.Item("PayDate")
         .PaidDate = Request.Form.Item("PaidDate")
         .Status = Request.Form.Item("Status")
         .Amount = Request.Form.Item("Amount")
         .Total = Request.Form.Item("Total")
         .Credit = Request.Form.Item("Credit")
         .Purpose = Request.Form.Item("Purpose")
         .PayType = Request.Form.Item("PayType")
         .PayType = Request.Form.Item("PayType")
         .Reference = Request.Form.Item("Reference")
         .CommStatus = Request.Form.Item("CommStatus")
         .CommDate = Request.Form.Item("CommDate")
         .OwnerType = Request.Form.Item("OwnerType")
         .OwnerID = Request.Form.Item("OwnerID")
         .ProductID = Request.Form.Item("ProductID")
         .PaidID = Request.Form.Item("PaidID")
         .Token = Request.Form.Item("Token")
         .TokenOwner = Request.Form.Item("TokenOwner")
         .Retail = Request.Form.Item("Retail")
         .Description = Request.Form.Item("Description")
         .Notes = Request.Form.Item("Notes")
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (oldStatus = 3) Then
            If (.Status = 5) Or (.Status = 6) Then
               ProcessPayment
            End If
         End If
         If (xmlError = "") And (oldStatus <> 3) Then
            If (.Status = 3) Then
               ProcessPayment
            End If
         End If
      End With
   End If
   Set oPayment = Nothing
   If (xmlError <> "") Then
      ReloadPayment
   End If
   If (xmlError = "") Then
      reqTxn = 1
      If (reqPopup <> 0) Then
         LoadPayment
      End If

      If (reqPopup = 0) Then
         reqReturnURL = GetCache("SavePaymentURL")
         reqReturnData = GetCache("SavePaymentDATA")
         SetCache "SavePaymentURL", ""
         SetCache "SavePaymentDATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadPayment

   Case CLng(cActionUpdate):
      SavePayment
      LoadPayment

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("1003URL")
      reqReturnData = GetCache("1003DATA")
      SetCache "1003URL", ""
      SetCache "1003DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .Delete CLng(reqPaymentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayment = Nothing
      If (xmlError = "") Then
         reqTxn = 4
      End If
      If (xmlError <> "") Or (reqPopup <> 0) Then
         ReloadPayment
      End If

      If (xmlError = "") And (reqPopup = 0) Then
         reqReturnURL = GetCache("1003URL")
         reqReturnData = GetCache("1003DATA")
         SetCache "1003URL", ""
         SetCache "1003DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUpdateMethod):
      SavePayment
      tmpBillingID = 0
      tmpPayType = 0
      tmpPayment = ""

      If (reqOwnerType = 52) And (reqMemberID = 0) And (reqSalesOrderID <> 0) Then
         Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
         If oSalesOrder Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
         Else
            With oSalesOrder
               .Load reqSalesOrderID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqMemberID = .MemberID
            End With
         End If
         Set oSalesOrder = Nothing
      End If

      If (reqMemberID <> 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpBillingID = .BillingID
            End With
         End If
         Set oMember = Nothing
      End If

      If (tmpBillingID <> 0) Then
         Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
         If oBilling Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
         Else
            With oBilling
               .Load tmpBillingID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpTokenType = .TokenType
               tmpToken = .Token
               tmpPayment = BillingPayment( oBilling )
               If (.PayType = 1) Then
                  tmpPayType = .CardType
               End If
               If (.PayType = 2) Then
                  tmpPayType = 5
               End If
               If (.PayType = 3) Then
                  tmpPayType = 7
               End If
            End With
         End If
         Set oBilling = Nothing
      End If

      If (tmpPayType <> 0) Then
         Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
         If oPayment Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
         Else
            With oPayment
               .Load CLng(reqPaymentID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .TokenType = tmpTokenType
               .Token = tmpToken
               .PayType = tmpPayType
               .Description = tmpPayment
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayment = Nothing
      End If
      If (reqPopup <> 0) Then
         LoadPayment
      End If

      If (reqPopup = 0) Then
         reqReturnURL = GetCache("1003URL")
         reqReturnData = GetCache("1003DATA")
         SetCache "1003URL", ""
         SetCache "1003DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionReclaim):
      SavePayment

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            Count = CLng(.Custom(CLng(reqCompanyID), 8, 0, CLng(reqPaymentID), 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing
      LoadPayment

   Case CLng(cActionClearMethod):
      SavePayment

      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .Load CLng(reqPaymentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .TokenType = 0
            .Token = 0
            .Description = ""
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayment = Nothing
      LoadPayment

   Case CLng(cActionRequestBitcoin):
      SavePayment

      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .Load CLng(reqPaymentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            ToEmail = .GetOwnerEmail(CLng(.OwnerType), CLng(.OwnerID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            If InStr( ToEmail, "@" ) > 0 Then
               result = SendBitCoinRequest( .CompanyID, ToEmail, .Purpose, .Amount, reqPaymentID )
               If result = 1 Then
                  reqMessage = "Bitcoin Request Sent"
                  If .Status <> 2 Then
                     .Status = 2
                     .Save 1
                  End If
               Else
                  reqMessage = "Bitcoin Request Failed"
               End If
            End If
               
         End With
      End If
      Set oPayment = Nothing
      LoadPayment

   Case CLng(cActionProductOrder):
      SavePayment

      Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
      Else
         With oPayment
            .Load CLng(reqPaymentID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.CompanyID = 17) Then
               
                     tmpMemberID = .OwnerID
                     tmpPurpose = .Purpose
                     tmpCredit = .Credit
                     'Check if this is an update to an existing order rather than a new order 
                     If tmpCredit > 0 Then tmpPurpose = "u" + tmpPurpose

                     Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                     If oHTTP Is Nothing Then
                        Response.Write "Error #" & Err.number & " - " + Err.description
                     Else
                        tmpURL = "http://www.GCRMarketing.com/GlobalCoinOrder.asp?MemberID=" + CStr(tmpMemberID) + "&Product=" + tmpPurpose
                     With oHTTP
                     .open "GET", tmpURL
                     .send
                     OrderID = .responseText
                     End With
                     End If
                     Set oHTTP = Nothing
              If Len(OrderID) = 0 Then
                tmp = "ERROR GCR-ORDER"
              Else  
                       tmp = .Notes + " GCRORDER:" + CStr(OrderID) + " " + CStr(Now())
              End If
                     .Notes = Left(tmp,500)
                  
               reqTxn = 9
            End If
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPayment = Nothing
      LoadPayment
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
xmlParam = xmlParam + " paymentid=" + Chr(34) + CStr(reqPaymentID) + Chr(34)
xmlParam = xmlParam + " paymentoptions=" + Chr(34) + CleanXML(reqPaymentOptions) + Chr(34)
xmlParam = xmlParam + " miscpay1=" + Chr(34) + CleanXML(reqMiscPay1) + Chr(34)
xmlParam = xmlParam + " miscpay2=" + Chr(34) + CleanXML(reqMiscPay2) + Chr(34)
xmlParam = xmlParam + " miscpay3=" + Chr(34) + CleanXML(reqMiscPay3) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " preview=" + Chr(34) + CStr(reqPreview) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " txn=" + Chr(34) + CStr(reqTxn) + Chr(34)
xmlParam = xmlParam + " ownertype=" + Chr(34) + CStr(reqOwnerType) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " salesorderid=" + Chr(34) + CStr(reqSalesOrderID) + Chr(34)
xmlParam = xmlParam + " hidepayment=" + Chr(34) + CStr(reqHidePayment) + Chr(34)
xmlParam = xmlParam + " message=" + Chr(34) + CleanXML(reqMessage) + Chr(34)
xmlParam = xmlParam + " productorder=" + Chr(34) + CStr(reqProductOrder) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlBusiness
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlSalesOrder
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language\Payment.xml"
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "1003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "1003 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "1003 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "1003.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "1003 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "1003 Load file (oData) failed with error code " + CStr(oData.parseError)
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