<!--#include file="Include\System.asp"-->
<!--#include file="Include\LimitedAccess.asp"-->
<!--#include file="Include\Coins.asp"-->
<!--#include file="Include\2FA.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\RewardOrder.asp"-->
<!--#include file="Include\IP.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCancelOrder = 13
Const cActionOrder_Cash = 1
Const cActionOrder_Redeem = 12
Const cActionPayment_RedeemPswd = 44
Const cActionPayment_Redeem = 4
Const cActionPayment_Add = 5
Const cActionCancel = 9
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
'-----other transaction data variables
Dim xmlAwards
'-----declare page parameters
Dim reqMerchantID
Dim reqConsumerID
Dim reqCompanyID
Dim reqConsumerName
Dim reqLogonConsumer
Dim reqAwardID
Dim reqRewardName
Dim reqTotalAmount
Dim reqNetAmount
Dim reqPayDate
Dim reqPayType
Dim reqCoinType
Dim reqDescription
Dim reqNotes
Dim reqOrderType
Dim reqOrderProcess
Dim reqPayment2ID
Dim reqPopup
Dim reqUser2FA
Dim reqReward
Dim reqAward
Dim reqRedeem
Dim reqTotalReward
Dim reqTotalAward
Dim reqIsAwards
Dim reqIsPin
Dim reqIsTicket
Dim reqIsApprove
Dim reqIsShopperOrder
Dim reqPinNumber
Dim reqTicketNumber
Dim reqMerchantName
Dim reqStaffID
Dim reqStaffName
Dim reqAcceptedCoins
Dim reqTerms
Dim reqCurrencyCode
Dim reqPendingOrders
Dim reqCoinPrice
Dim reqBTC
Dim reqNXC
Dim reqRewardPoints
Dim reqRewardValue
Dim reqRewardValueRaw
Dim reqRedeemPswd
Dim reqQR_Name
Dim reqQR_URL
Dim reqQR_Address
Dim reqQR_Amount
Dim reqQR_Label
Dim reqQR_Msg
Dim reqCoinToken
Dim reqReplaceURL
Dim reqCryptoStatus
Dim reqIsDemo
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
   SetCache "m_15212sURL", reqReturnURL
   SetCache "m_15212sDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "m_15212s")
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
reqConsumerID =  Numeric(GetInput("ConsumerID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqConsumerName =  GetInput("ConsumerName", reqPageData)
reqLogonConsumer =  GetInput("LogonConsumer", reqPageData)
reqAwardID =  Numeric(GetInput("AwardID", reqPageData))
reqRewardName =  GetInput("RewardName", reqPageData)
reqTotalAmount =  GetInput("TotalAmount", reqPageData)
reqNetAmount =  GetInput("NetAmount", reqPageData)
reqPayDate =  GetInput("PayDate", reqPageData)
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqCoinType =  Numeric(GetInput("CoinType", reqPageData))
reqDescription =  GetInput("Description", reqPageData)
reqNotes =  GetInput("Notes", reqPageData)
reqOrderType =  Numeric(GetInput("OrderType", reqPageData))
reqOrderProcess =  Numeric(GetInput("OrderProcess", reqPageData))
reqPayment2ID =  Numeric(GetInput("Payment2ID", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqUser2FA =  Numeric(GetInput("User2FA", reqPageData))
reqReward =  GetInput("Reward", reqPageData)
reqAward =  GetInput("Award", reqPageData)
reqRedeem =  GetInput("Redeem", reqPageData)
reqTotalReward =  GetInput("TotalReward", reqPageData)
reqTotalAward =  GetInput("TotalAward", reqPageData)
reqIsAwards =  Numeric(GetInput("IsAwards", reqPageData))
reqIsPin =  Numeric(GetInput("IsPin", reqPageData))
reqIsTicket =  Numeric(GetInput("IsTicket", reqPageData))
reqIsApprove =  Numeric(GetInput("IsApprove", reqPageData))
reqIsShopperOrder =  Numeric(GetInput("IsShopperOrder", reqPageData))
reqPinNumber =  GetInput("PinNumber", reqPageData)
reqTicketNumber =  GetInput("TicketNumber", reqPageData)
reqMerchantName =  GetInput("MerchantName", reqPageData)
reqStaffID =  Numeric(GetInput("StaffID", reqPageData))
reqStaffName =  GetInput("StaffName", reqPageData)
reqAcceptedCoins =  GetInput("AcceptedCoins", reqPageData)
reqTerms =  GetInput("Terms", reqPageData)
reqCurrencyCode =  GetInput("CurrencyCode", reqPageData)
reqPendingOrders =  Numeric(GetInput("PendingOrders", reqPageData))
reqCoinPrice =  GetInput("CoinPrice", reqPageData)
reqBTC =  GetInput("BTC", reqPageData)
reqNXC =  GetInput("NXC", reqPageData)
reqRewardPoints =  GetInput("RewardPoints", reqPageData)
reqRewardValue =  GetInput("RewardValue", reqPageData)
reqRewardValueRaw =  GetInput("RewardValueRaw", reqPageData)
reqRedeemPswd =  GetInput("RedeemPswd", reqPageData)
reqQR_Name =  GetInput("QR_Name", reqPageData)
reqQR_URL =  GetInput("QR_URL", reqPageData)
reqQR_Address =  GetInput("QR_Address", reqPageData)
reqQR_Amount =  GetInput("QR_Amount", reqPageData)
reqQR_Label =  GetInput("QR_Label", reqPageData)
reqQR_Msg =  GetInput("QR_Msg", reqPageData)
reqCoinToken =  GetInput("CoinToken", reqPageData)
reqReplaceURL =  GetInput("ReplaceURL", reqPageData)
reqCryptoStatus =  GetInput("CryptoStatus", reqPageData)
reqIsDemo =  Numeric(GetInput("IsDemo", reqPageData))
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

Function NewShopper(opt)
   On Error Resume Next
   GetMerchant reqMerchantID, reqOrderType, reqMerchantName, reqTerms, reqCurrencyCode, reqIsAwards, reqIsPin, reqIsTicket, reqIsApprove, reqIsShopperOrder, reqAcceptedCoins, reqPendingOrders, reqIsDemo
   reqOrderType = 0
   reqOrderProcess = 0
   reqConsumerName = ""
   reqConsumerID = 0
   reqPayment2ID = 0
   reqRedeemPswd = ""
   If (reqIsTicket <> 0) Then
      reqTicketNumber = "xxxx"
   End If
   If (reqIsShopperOrder = 0) Then
      
            response.write "Merchant Doesn't Support - Shopper Initiated Orders"
            response.end
          
   End If
   reqLogonConsumer = GetCookie("CONSUMERLOGON")
End Function

Sub SetupOrder()
   On Error Resume Next
   If (reqLogonConsumer = "") Then
      DoError 10149, "", "Oops, Please enter a shopper phone number or email."
   End If
   If (xmlError = "") Then
      GetShopper reqMerchantID, reqLogonConsumer, reqOrderType, reqCurrencyCode, reqConsumerID, reqConsumerName, reqBTC, reqCoinPrice, reqRewardPoints, reqNXC, reqRewardValueRaw, reqRewardValue, reqPayType, reqIsDemo
   End If
   If (xmlError = "") Then
      reqOrderProcess = 1
      NewOrder reqMerchantID, reqOrderType, reqPayDate, reqPayType, xmlAwards
      
            pos = InStr(xmlAwards, "id=")
            If pos > 0 Then
              pos = pos + 4
              pos2 = InStr(pos, xmlAwards, """")
              reqAwardID = Mid( xmlAwards, pos, pos2-pos)
            End If
            pos = InStr(xmlAwards, "name=")
            If pos > 0 Then
              pos = pos + 6
              pos2 = InStr(pos, xmlAwards, """")
              reqRewardName = Mid( xmlAwards, pos, pos2-pos)
            End If
          
   End If
   If (xmlError = "") Then
      SetCookie "CONSUMERLOGON", reqLogonConsumer
   End If
End Sub

Sub ValidStaff()
   On Error Resume Next
   If (reqPinNumber = "") Then
      DoError 10150, "", "Oops, Please enter your numeric PIN Code."
   End If
   If (IsNumeric(reqPinNumber) = 0) Then
      DoError 10151, "", "Oops, Please enter numbers only for your PIN Code."
      reqPinNumber = ""
   End If
   If (xmlError = "") Then
      ValidPin reqMerchantID, reqPinNumber, reqStaffID, reqStaffName
   End If
   If (xmlError = "") Then
      SetCookie "BADPIN", 0
   End If
   If (xmlError <> "") Then
      tmpBadPin = Numeric(GetCookie("BADPIN"))
      tmpBadPin = tmpBadPin + 1
      SetCookie "BADPIN", tmpBadPin
      If (tmpBadPin >= 3) Then

         Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
         If oConsumer Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
         Else
            With oConsumer
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqConsumerID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Status = 3
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oConsumer = Nothing
         
              response.write "Invalid Access - Membership Cancelled - Contact support@NexxusRewards.com"
              response.end
            
      End If
   End If
   reqPinNumber = ""
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
reqUser2FA = 1
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewShopper(0)

   Case CLng(cActionCancelOrder):
      NewShopper(1)

   Case CLng(cActionOrder_Cash):
      reqOrderType = 1
      SetupOrder

   Case CLng(cActionOrder_Redeem):
      reqOrderType = 2
      SetupOrder

   Case CLng(cActionPayment_RedeemPswd):
      ValidRedeem reqConsumerID, reqRedeemPswd, 1, 1, 1
      If (xmlError <> "") Then
         reqRedeemPswd = ""
      End If

   Case CLng(cActionPayment_Redeem):
      ValidStaff
      If (xmlError = "") Then
         ValidOrder reqOrderType, reqIsTicket, reqTicketNumber, reqTotalAmount, reqNetAmount
      End If
      If (xmlError = "") Then
         ValidRedeem reqConsumerID, reqRedeemPswd, reqRewardValueRaw, reqTotalAmount, reqNetAmount
      End If
      If (xmlError = "") Then
         reqPayment2ID = -1
         AddOrder reqOrderType, reqMerchantID, reqConsumerID, reqAwardID, reqPayDate, reqStaffID, reqDescription, reqTotalAmount, reqNetAmount, reqTicketNumber, reqPayType, reqCurrencyCode, reqCoinType, reqQR_Address, reqPayment2ID, reqCoinToken, reqIsDemo
         If (xmlError = "") Then
            ProcessOrder reqCompanyID, reqPayment2ID, reqReward, reqAward, reqRedeem, reqTotalReward, reqTotalAward
         End If
      End If
      If (xmlError = "") Then
         reqOrderProcess = 3
      End If
      If (xmlError <> "") Then
         NewOrder reqMerchantID, reqOrderType, reqPayDate, reqPayType, xmlAwards
      End If

   Case CLng(cActionPayment_Add):
      ValidStaff
      If (xmlError = "") Then
         If (reqTotalAmount = "") Then
            reqTotalAmount = reqNetAmount
         End If
         ValidOrder reqOrderType, reqIsTicket, reqTicketNumber, reqTotalAmount, reqNetAmount
         If (xmlError = "") Then
            reqPayment2ID = -1
            AddOrder reqOrderType, reqMerchantID, reqConsumerID, reqAwardID, reqPayDate, reqStaffID, reqDescription, reqTotalAmount, reqNetAmount, reqTicketNumber, reqPayType, reqCurrencyCode, reqCoinType, reqQR_Address, reqPayment2ID, reqCoinToken, reqIsDemo
         End If
      End If
      If (xmlError = "") Then
         If (reqOrderType = 1) Then
            If (xmlError = "") Then
               ProcessOrder reqCompanyID, reqPayment2ID, reqReward, reqAward, reqRedeem, reqTotalReward, reqTotalAward
            End If
            If (xmlError = "") Then
               reqOrderProcess = 3
               If (reqIsApprove = 1) Then
                  ApproveOrder reqPayment2ID
               End If
            End If
         End If
      End If
      If (xmlError <> "") Then
         NewOrder reqMerchantID, reqOrderType, reqPayDate, reqPayType, xmlAwards
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("m_15212sURL")
      reqReturnData = GetCache("m_15212sDATA")
      SetCache "m_15212sURL", ""
      SetCache "m_15212sDATA", ""
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
xmlParam = xmlParam + " merchantid=" + Chr(34) + CStr(reqMerchantID) + Chr(34)
xmlParam = xmlParam + " consumerid=" + Chr(34) + CStr(reqConsumerID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " consumername=" + Chr(34) + CleanXML(reqConsumerName) + Chr(34)
xmlParam = xmlParam + " logonconsumer=" + Chr(34) + CleanXML(reqLogonConsumer) + Chr(34)
xmlParam = xmlParam + " awardid=" + Chr(34) + CStr(reqAwardID) + Chr(34)
xmlParam = xmlParam + " rewardname=" + Chr(34) + CleanXML(reqRewardName) + Chr(34)
xmlParam = xmlParam + " totalamount=" + Chr(34) + CleanXML(reqTotalAmount) + Chr(34)
xmlParam = xmlParam + " netamount=" + Chr(34) + CleanXML(reqNetAmount) + Chr(34)
xmlParam = xmlParam + " paydate=" + Chr(34) + CStr(reqPayDate) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " cointype=" + Chr(34) + CStr(reqCoinType) + Chr(34)
xmlParam = xmlParam + " description=" + Chr(34) + CleanXML(reqDescription) + Chr(34)
xmlParam = xmlParam + " notes=" + Chr(34) + CleanXML(reqNotes) + Chr(34)
xmlParam = xmlParam + " ordertype=" + Chr(34) + CStr(reqOrderType) + Chr(34)
xmlParam = xmlParam + " orderprocess=" + Chr(34) + CStr(reqOrderProcess) + Chr(34)
xmlParam = xmlParam + " payment2id=" + Chr(34) + CStr(reqPayment2ID) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " user2fa=" + Chr(34) + CStr(reqUser2FA) + Chr(34)
xmlParam = xmlParam + " reward=" + Chr(34) + CStr(reqReward) + Chr(34)
xmlParam = xmlParam + " award=" + Chr(34) + CStr(reqAward) + Chr(34)
xmlParam = xmlParam + " redeem=" + Chr(34) + CStr(reqRedeem) + Chr(34)
xmlParam = xmlParam + " totalreward=" + Chr(34) + CStr(reqTotalReward) + Chr(34)
xmlParam = xmlParam + " totalaward=" + Chr(34) + CStr(reqTotalAward) + Chr(34)
xmlParam = xmlParam + " isawards=" + Chr(34) + CStr(reqIsAwards) + Chr(34)
xmlParam = xmlParam + " ispin=" + Chr(34) + CStr(reqIsPin) + Chr(34)
xmlParam = xmlParam + " isticket=" + Chr(34) + CStr(reqIsTicket) + Chr(34)
xmlParam = xmlParam + " isapprove=" + Chr(34) + CStr(reqIsApprove) + Chr(34)
xmlParam = xmlParam + " isshopperorder=" + Chr(34) + CStr(reqIsShopperOrder) + Chr(34)
xmlParam = xmlParam + " pinnumber=" + Chr(34) + CleanXML(reqPinNumber) + Chr(34)
xmlParam = xmlParam + " ticketnumber=" + Chr(34) + CleanXML(reqTicketNumber) + Chr(34)
xmlParam = xmlParam + " merchantname=" + Chr(34) + CleanXML(reqMerchantName) + Chr(34)
xmlParam = xmlParam + " staffid=" + Chr(34) + CStr(reqStaffID) + Chr(34)
xmlParam = xmlParam + " staffname=" + Chr(34) + CleanXML(reqStaffName) + Chr(34)
xmlParam = xmlParam + " acceptedcoins=" + Chr(34) + CleanXML(reqAcceptedCoins) + Chr(34)
xmlParam = xmlParam + " terms=" + Chr(34) + CleanXML(reqTerms) + Chr(34)
xmlParam = xmlParam + " currencycode=" + Chr(34) + CleanXML(reqCurrencyCode) + Chr(34)
xmlParam = xmlParam + " pendingorders=" + Chr(34) + CStr(reqPendingOrders) + Chr(34)
xmlParam = xmlParam + " coinprice=" + Chr(34) + CleanXML(reqCoinPrice) + Chr(34)
xmlParam = xmlParam + " btc=" + Chr(34) + CStr(reqBTC) + Chr(34)
xmlParam = xmlParam + " nxc=" + Chr(34) + CStr(reqNXC) + Chr(34)
xmlParam = xmlParam + " rewardpoints=" + Chr(34) + CStr(reqRewardPoints) + Chr(34)
xmlParam = xmlParam + " rewardvalue=" + Chr(34) + CStr(reqRewardValue) + Chr(34)
xmlParam = xmlParam + " rewardvalueraw=" + Chr(34) + CStr(reqRewardValueRaw) + Chr(34)
xmlParam = xmlParam + " redeempswd=" + Chr(34) + CleanXML(reqRedeemPswd) + Chr(34)
xmlParam = xmlParam + " qr_name=" + Chr(34) + CleanXML(reqQR_Name) + Chr(34)
xmlParam = xmlParam + " qr_url=" + Chr(34) + CleanXML(reqQR_URL) + Chr(34)
xmlParam = xmlParam + " qr_address=" + Chr(34) + CleanXML(reqQR_Address) + Chr(34)
xmlParam = xmlParam + " qr_amount=" + Chr(34) + CStr(reqQR_Amount) + Chr(34)
xmlParam = xmlParam + " qr_label=" + Chr(34) + CleanXML(reqQR_Label) + Chr(34)
xmlParam = xmlParam + " qr_msg=" + Chr(34) + CleanXML(reqQR_Msg) + Chr(34)
xmlParam = xmlParam + " cointoken=" + Chr(34) + CleanXML(reqCoinToken) + Chr(34)
xmlParam = xmlParam + " replaceurl=" + Chr(34) + CleanXML(reqReplaceURL) + Chr(34)
xmlParam = xmlParam + " cryptostatus=" + Chr(34) + CleanXML(reqCryptoStatus) + Chr(34)
xmlParam = xmlParam + " isdemo=" + Chr(34) + CStr(reqIsDemo) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlAwards
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Reward[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Reward[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "m_15212s Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "m_15212s Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "m_15212s Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "m_15212s.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "m_15212s Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "m_15212s Load file (oData) failed with error code " + CStr(oData.parseError)
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