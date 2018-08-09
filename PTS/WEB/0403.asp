<!--#include file="Include\System.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Products.asp"-->
<!--#include file="Include\Binary.asp"-->
<!--#include file="Include\Languages.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\BillingPayout.asp"-->
<!--#include file="Include\GCRWallet.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionUpdateExit = 9
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionUploadImage = 6
Const cActionChangeStatus = 8
Const cActionCreditBilling = 12
Const cActionMoveDownline = 13
Const cActionEditGovid = 14
Const cActionPayPalPayment = 15
Const cActionEdit16 = 16
Const cActionCoinWallet = 17
Const cActionDisableWallet = 18
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
Dim oConsumer, xmlConsumer
Dim oBilling, xmlBilling
Dim oGovid, xmlGovid
Dim oCoption, xmlCoption
Dim oTitles, xmlTitles
Dim oDownline, xmlDownline
Dim oCompany, xmlCompany
Dim oCloudZow, xmlCloudZow
'-----other transaction data variables
Dim xmlLanguages
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqParentID
Dim reqBillingID
Dim reqPayID
Dim reqOrgID
Dim reqcontentpage
Dim reqPopup
Dim reqRefName
Dim reqOptions
Dim reqMemberOptions
Dim reqIdentify
Dim reqUploadImageFile
Dim reqStatus
Dim reqVisitDate
Dim reqAuthUserID
Dim reqExtra
Dim reqIsMsg
Dim reqFaceBook
Dim reqTwitter
Dim reqGoogle
Dim reqPinterest
Dim reqTumblr
Dim reqLinkedIn
Dim reqMySpace
Dim reqSkype
Dim reqGroupID
Dim reqSponsorID
Dim reqBinary
Dim reqShowQualify
Dim reqWallet
Dim reqFastTrack
Dim reqBackups
Dim reqMoney
Dim reqUniversity
Dim reqPV
Dim reqBV
Dim reqProducts
Dim reqSponsorName
Dim reqToken
Dim reqBillingMethod
Dim reqPayoutMethod
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
   SetCache "0403URL", reqReturnURL
   SetCache "0403DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0403")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqPayID =  Numeric(GetInput("PayID", reqPageData))
reqOrgID =  Numeric(GetInput("OrgID", reqPageData))
reqcontentpage =  Numeric(GetInput("contentpage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqRefName =  GetInput("RefName", reqPageData)
reqOptions =  GetInput("Options", reqPageData)
reqMemberOptions =  GetInput("MemberOptions", reqPageData)
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqUploadImageFile =  GetInput("UploadImageFile", reqPageData)
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqVisitDate =  GetInput("VisitDate", reqPageData)
reqAuthUserID =  Numeric(GetInput("AuthUserID", reqPageData))
reqExtra =  Numeric(GetInput("Extra", reqPageData))
reqIsMsg =  Numeric(GetInput("IsMsg", reqPageData))
reqFaceBook =  GetInput("FaceBook", reqPageData)
reqTwitter =  GetInput("Twitter", reqPageData)
reqGoogle =  GetInput("Google", reqPageData)
reqPinterest =  GetInput("Pinterest", reqPageData)
reqTumblr =  GetInput("Tumblr", reqPageData)
reqLinkedIn =  GetInput("LinkedIn", reqPageData)
reqMySpace =  GetInput("MySpace", reqPageData)
reqSkype =  GetInput("Skype", reqPageData)
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqSponsorID =  Numeric(GetInput("SponsorID", reqPageData))
reqBinary =  Numeric(GetInput("Binary", reqPageData))
reqShowQualify =  Numeric(GetInput("ShowQualify", reqPageData))
reqWallet =  Numeric(GetInput("Wallet", reqPageData))
reqFastTrack =  Numeric(GetInput("FastTrack", reqPageData))
reqBackups =  Numeric(GetInput("Backups", reqPageData))
reqMoney =  Numeric(GetInput("Money", reqPageData))
reqUniversity =  Numeric(GetInput("University", reqPageData))
reqPV =  GetInput("PV", reqPageData)
reqBV =  GetInput("BV", reqPageData)
reqProducts =  GetInput("Products", reqPageData)
reqSponsorName =  GetInput("SponsorName", reqPageData)
reqToken =  GetInput("Token", reqPageData)
reqBillingMethod =  GetInput("BillingMethod", reqPageData)
reqPayoutMethod =  GetInput("PayoutMethod", reqPageData)
reqMember2FA =  Numeric(GetInput("Member2FA", reqPageData))
tmpUserGroup = 0
tmpIsDiscount = 0
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

Function ActiveMembers(prmCompanyID, prmMasterID)
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         tmpActiveCount = CLng(.ActiveCount(prmCompanyID, prmMasterID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (CLng(tmpActiveCount) < 0) Then
            DoError 10111, "", "Oops, You have exceeded the maximum number of allowed active members."
         End If
      End With
   End If
   Set oMember = Nothing
End Function

Sub UpdateMember()
   On Error Resume Next
   ConsumerID = 0

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCompanyID = .CompanyID
         reqParentID = .ReferralID
         reqBillingID = .BillingID
         reqStatus = .Status
         reqVisitDate = .VisitDate
         reqAuthUserID = .AuthUserID
         tmpUserGroup = .UserGroup
         tmpIsDiscount = .IsDiscount
         oldStatus = .Status
         oldTitle = .Title
         oldReferralID = .ReferralID
         oldIsRemoved = .IsRemoved
         oldSponsorID = .SponsorID
         oldPromoID = .PromoID
         oldEmail = .Email
         oldSponsorID = .SponsorID

         .CompanyID = Request.Form.Item("CompanyID")
         .Role = Request.Form.Item("Role")
         .Process = Request.Form.Item("Process")
         .Role = Request.Form.Item("Role")
         .ReferralID = Request.Form.Item("ReferralID")
         .MentorID = Request.Form.Item("MentorID")
         .SponsorID = Request.Form.Item("SponsorID")
         .Process = Request.Form.Item("Process")
         .Sponsor2ID = Request.Form.Item("Sponsor2ID")
         .Sponsor3ID = Request.Form.Item("Sponsor3ID")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .IsCompany = Request.Form.Item("IsCompany")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Email2 = Request.Form.Item("Email2")
         .EnrollDate = Request.Form.Item("EnrollDate")
         .EndDate = Request.Form.Item("EndDate")
         .Status = Request.Form.Item("Status")
         .IsRemoved = Request.Form.Item("IsRemoved")
         .Level = Request.Form.Item("Level")
         .IsMaster = Request.Form.Item("IsMaster")
         .TrialDays = Request.Form.Item("TrialDays")
         .StatusDate = Request.Form.Item("StatusDate")
         .StatusChange = Request.Form.Item("StatusChange")
         .LevelChange = Request.Form.Item("LevelChange")
         .Title = Request.Form.Item("Title")
         .Title2 = Request.Form.Item("Title2")
         .MinTitle = Request.Form.Item("MinTitle")
         .TitleDate = Request.Form.Item("TitleDate")
         .Qualify = Request.Form.Item("Qualify")
         .QualifyDate = Request.Form.Item("QualifyDate")
         .IsIncluded = Request.Form.Item("IsIncluded")
         .IsMsg = Request.Form.Item("IsMsg")
         .Billing = Request.Form.Item("Billing")
         .PaidDate = Request.Form.Item("PaidDate")
         .Price = Request.Form.Item("Price")
         .InitPrice = Request.Form.Item("InitPrice")
         .Options2 = Request.Form.Item("Options2")
         .GroupID = Request.Form.Item("GroupID")
         .Reference = Request.Form.Item("Reference")
         .Referral = Request.Form.Item("Referral")
         .ConfLine = Request.Form.Item("ConfLine")
         .Options = Request.Form.Item("Options")
         .Pos = Request.Form.Item("Pos")
         .Secure = Request.Form.Item("Secure")
         .AccessLimit = Request.Form.Item("AccessLimit")
         .QuizLimit = Request.Form.Item("QuizLimit")
         .Identification = Request.Form.Item("Identification")
         .UserGroup = Request.Form.Item("UserGroup")
         .UserStatus = Request.Form.Item("UserStatus")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Fax = Request.Form.Item("Fax")
         .Icons = Request.Form.Item("Icons")
         .AutoShipDate = Request.Form.Item("AutoShipDate")
         .Timezone = Request.Form.Item("Timezone")
         .Signature = Request.Form.Item("Signature")
         If (.CompanyID = 21) And (.SponsorID <> oldSponsorID) Then
            ConsumerID = .SponsorID
         End If
         If (.CompanyID = 17) And (oldEmail <> .Email) Then
            
              result = GCRWallet_UpdateEmail( oldEmail, .Email )
              If result <> "ok" Then
                .Email = oldEmail
                Response.write result
              End If
            
         End If
         newStatus = .Status
         newTitle = .Title
         newReferralID = .ReferralID
         newIsRemoved = .IsRemoved
         newSponsorID = .SponsorID
         reqSponsorID = .SponsorID
         If (newSponsorID <> 0) And (newSponsorID <> oldSponsorID) Then
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0437.asp?MemberID=" & reqMemberID
               oHTTP.send
            End If
            Set oHTTP = Nothing

         End If
         If (.Status = 1) And (reqStatus <> 1) Then
            ActiveMembers .CompanyID, .MasterID
         End If
         If (.CompanyName = "") Then
            .CompanyName = .NameLast + ", " + .NameFirst
         End If
         If (.EndDate = "0") And (.Status = 5) Then
            .EndDate = Now
         End If
         If (Len(.Signature) < 8) Then
            .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
         End If
         If (reqBinary <> 0) Then
            .Options2 = SetBinary( .Options2, reqBinary )
         End If
         If (InStr(reqSysUserOptions,"(") <> 0) Then
            
   .SocNet = "FB;" + reqFaceBook + ":" + "TW;" + reqTwitter + ":" + "GO;" + reqGoogle + ":" + "PI;" + reqPinterest + ":" + "TU;" + reqTumblr + ":" + "LI;" + reqLinkedIn + ":" + "MS;" + reqMySpace + ":" + "SK;" + reqSkype

         End If
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (newTitle <> oldTitle) Then

            Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
            If oMemberTitle Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
            Else
               With oMemberTitle
                  .SysCurrentLanguage = reqSysLanguage
                  .MemberID = reqMemberID
                  .TitleDate = Now
                  .Title = newTitle
                  .Add CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oMemberTitle = Nothing
         End If
         If (xmlError = "") And (.PromoID <> oldPromoID) Then
            
                  LogMemberNote reqMemberID, "OVERDRAFT PROTECTION CHANGE: (" + .PromoID + ") " 

         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   If (xmlError = "") And (ConsumerID <> 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load ConsumerID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .AffiliateID = reqMemberID
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oConsumer = Nothing
   End If
End Sub

Sub LoadBilling()
   On Error Resume Next

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBillingID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.CardNumber <> "") Then
            .CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)
         End If
         If (.CardCode <> "") Then
            .CardCode = "xxx"
         End If
         If (.CheckAccount <> "") Then
            .CheckAccount = "xxxx" + Right(.CheckAccount,4)
         End If
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMember2FA = 1
         If (reqSysUserGroup = 41) Then
            reqMember2FA = Is2FA(reqSysUserID)
         End If
         If (reqSysUserGroup > 23) And (.CompanyID <> CSTR(reqSysCompanyID)) Then
            AbortUser()
         End If
         If (.CompanyID = 21) And (.Level = 0) Then
            reqBinary = -1
         End If
         reqCompanyID = .CompanyID
         tmpOptions2 = .Options2
         reqPV = .BV
         reqBV = .QV
         If (reqCompanyID = 8) Then
            reqShowQualify = 1
         End If
         If (reqCompanyID = 14) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            If (InStr(.Options2, "104") <> 0) Then
               reqProducts = reqProducts + "Silver Pack"
            End If
            If (InStr(.Options2, "105") <> 0) Then
               reqProducts = reqProducts + "Gold Pack"
            End If
            If (InStr(.Options2, "106") <> 0) Then
               reqProducts = reqProducts + "Diamond Pack #1"
            End If
            If (InStr(.Options2, "107") <> 0) Then
               reqProducts = reqProducts + "Diamond Pack #2"
            End If
            If (InStr(.Options2, "108") <> 0) Then
               reqProducts = reqProducts + "Diamond Pack #3"
            End If
            If (InStr(.Options2, "113") <> 0) Then
               reqProducts = reqProducts + " Monthly Autoship"
            End If
            If (InStr(.Options2, "114") <> 0) Then
               reqProducts = reqProducts + " Quartlerly Autoship"
            End If
            If (InStr(.Options2, "115") <> 0) Then
               reqProducts = reqProducts + " Monthly Triple Diamond Autoship"
            End If
            If (InStr(.Options2, "116") <> 0) Then
               reqProducts = reqProducts + " Quartlerly Triple Diamond Autoship"
            End If
            If (InStr(.Options2, "117") <> 0) Then
               reqProducts = reqProducts + " Monthly Blue Diamond Autoship"
            End If
            If (InStr(.Options2, "118") <> 0) Then
               reqProducts = reqProducts + " Quartlerly Blue Diamond Autoship"
            End If
            If (InStr(.Options2, "119") <> 0) Then
               reqProducts = reqProducts + " Monthly Presidential Autoship"
            End If
            If (InStr(.Options2, "120") <> 0) Then
               reqProducts = reqProducts + " Quartlerly Presidential Autoship"
            End If
            If (InStr(.Options2, "121") <> 0) Then
               reqProducts = reqProducts + " Quartlerly Trucker Autoship"
            End If
         End If
         If (reqCompanyID = 17) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            If (reqSysUserGroup <= 23) And (.Referral <> "") Then
               reqProducts = " Coins: " + .Referral
            End If
         End If
         If (reqCompanyID = 18) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
         End If
         If (reqCompanyID = 19) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            If (InStr(.Options2, "111") <> 0) Then
               reqProducts = reqProducts + "1GB"
            End If
            If (InStr(.Options2, "112") <> 0) Then
               reqProducts = reqProducts + "3GB"
            End If
            If (InStr(.Options2, "113") <> 0) Then
               reqProducts = reqProducts + "5GB"
            End If
            If (InStr(.Options2, "114") <> 0) Then
               reqProducts = reqProducts + "Unlimited GB"
            End If
         End If
         If (reqCompanyID = 20) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            If (InStr(.Options2, "101") <> 0) Then
               reqProducts = reqProducts + "Donation"
            End If
            If (InStr(.Options2, "201") <> 0) Then
               reqProducts = reqProducts + "Personal"
            End If
            If (InStr(.Options2, "202") <> 0) Then
               reqProducts = reqProducts + "Personal2"
            End If
         End If
         If (reqCompanyID = 21) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            If (InStr(.Options2, "101") <> 0) Then
               reqProducts = reqProducts + "Beginner"
            End If
            If (InStr(.Options2, "102") <> 0) Then
               reqProducts = reqProducts + "Basic"
            End If
            If (InStr(.Options2, "103") <> 0) Then
               reqProducts = reqProducts + "Pro"
            End If
         End If
         reqBillingID = .BillingID
         reqPayID = .PayID
         reqStatus = .Status
         reqMemberOptions = .Options
         tmpLevel = .Level
         reqVisitDate = .VisitDate
         reqAuthUserID = .AuthUserID
         tmpUserGroup = .UserGroup
         tmpIsDiscount = .IsDiscount
         reqSponsorID = .SponsorID
         reqIsMsg = .IsMsg
         If (.MemberID = .GroupID) Then
            reqGroupID = .GroupID
         End If
         If (InStr(reqSysUserOptions,"(") <> 0) Then
            
   aSocNets = split(.SocNet, ":")
   total = UBOUND(aSocNets)
   For x = 0 to total
   aSocNet = split(aSocNets(x), ";")
   Select Case aSocNet(0)
   Case "FB": reqFaceBook = aSocNet(1)
   Case "TW": reqTwitter = aSocNet(1)
   Case "GO": reqGoogle = aSocNet(1)
   Case "PI": reqPinterest = aSocNet(1)
   Case "TU": reqTumblr = aSocNet(1)
   Case "LI": reqLinkedIn = aSocNet(1)
   Case "MS": reqMySpace = aSocNet(1)
   Case "SK": reqSkype = aSocNet(1)
   End Select
   Next

         End If
         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.ReferralID <> 0) Then
            .Load CLng(.ReferralID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqSponsorName = .NameFirst + " " + .NameLast
         End If
      End With
   End If
   Set oMember = Nothing

   If (reqBillingID <> 0) Or (reqPayID <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            If (reqBillingID <> 0) Then
               .Load CLng(reqBillingID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.CardNumber <> "") Then
                  .CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)
               End If
               If (.CardCode <> "") Then
                  .CardCode = "xxx"
               End If
               If (.CheckAccount <> "") Then
                  .CheckAccount = "xxxx" + Right(.CheckAccount,4)
               End If
               
              reqBillingMethod = BillingPayment(oBilling)
              reqBillingMethod = Replace( reqBillingMethod, "Charged:[", "")
              reqBillingMethod = Replace( reqBillingMethod, "]", "")
            
            End If
            If (reqPayID <> 0) Then
               .Load CLng(reqPayID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.CardNumber <> "") Then
                  .CardNumber = "xxxxxxxxxxxx" + Right(.CardNumber,4)
               End If
               If (.CardCode <> "") Then
                  .CardCode = "xxx"
               End If
               If (.CheckAccount <> "") Then
                  .CheckAccount = "xxxx" + Right(.CheckAccount,4)
               End If
               
              reqPayoutMethod = BillingPayout(oBilling)
              reqPayoutMethod = Replace( reqPayoutMethod, "Pay:[", "")
              reqPayoutMethod = Replace( reqPayoutMethod, "]", "")
            
            End If
         End With
      End If
      Set oBilling = Nothing
   End If

   Set oGovid = server.CreateObject("ptsGovidUser.CGovid")
   If oGovid Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsGovidUser.CGovid"
   Else
      With oGovid
         .SysCurrentLanguage = reqSysLanguage
         .FetchMember CLng(reqMemberID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.GNumber <> "") Then
            .GNumber = "xxxxxx" + Right(.GNumber, 4)
         End If
         xmlGovid = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oGovid = Nothing

   If (reqCompanyID > 0) Then
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
            reqRefName = .RefName
            reqIdentify = .Identify
            If (.Languages <> "") Then
               xmlLanguages = LanguagesXML(.Languages, 1)
            End If
            tmpInputOptions = .InputOptions
            If (reqBinary = 0) Then
               
                     Downlines = .TBPage
                     If InStr(Downlines, "B" ) > 0 Then reqBinary = 1
                  
            End If
            If (tmpInputOptions <> "") Then
               
   Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
   With oInputOptions
   .Load tmpInputOptions
   If reqSysUserGroup <= 23 Then
               tmpDisplayRows = .DisplayRows(0)
            Else
               tmpDisplayRows = .DisplayRows(1)
            End If
         End With   
         Set oInputOptions = Nothing
         reqExtra = 100 + (tmpDisplayRows * 25 )
         If reqExtra > 550 Then reqExtra = 550

            End If
            If (tmpLevel = 0) Then
               reqOptions = .FreeOptions
            End If
            If (tmpLevel <= 1) Then
               reqOptions = .Options
            End If
            If (tmpLevel = 2) Then
               reqOptions = .Options2
            End If
            If (tmpLevel = 3) Then
               reqOptions = .Options3
            End If
            SetCache "MENUBARSTATE", reqMenuBarState
            reqMemberOptions = reqMemberOptions + reqOptions
         End With
      End If
      Set oCoption = Nothing
   End If

   If (InStr(reqSysUserOptions,"v") <> 0) Or (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
      Set oTitles = server.CreateObject("ptsTitleUser.CTitles")
      If oTitles Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTitleUser.CTitles"
      Else
         With oTitles
            .SysCurrentLanguage = reqSysLanguage
            xmlTitles = xmlTitles + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oTitles = Nothing
   End If
   If (reqBinary > 0) Then
      reqBinary = GetBinary( tmpOptions2 )
   End If
End Sub

If (reqUploadImageFile <> "") Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Image = reqUploadImageFile
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

         Response.Redirect "0101.asp" & "?ActionCode=" & 9
      End If
      LoadMember

   Case CLng(cActionUpdate):
      UpdateMember
      LoadMember

   Case CLng(cActionUpdateExit):
      UpdateMember
      If (xmlError <> "") Or (reqPopup <> 0) Then
         LoadMember
      End If

      If (xmlError = "") And (reqPopup = 0) Then
         reqReturnURL = GetCache("0403URL")
         reqReturnData = GetCache("0403DATA")
         SetCache "0403URL", ""
         SetCache "0403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      If (reqPopup = 0) Then
         reqReturnURL = GetCache("0403URL")
         reqReturnData = GetCache("0403DATA")
         SetCache "0403URL", ""
         SetCache "0403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionDelete):

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing

      If (xmlError <> "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlMember = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMember = Nothing
      End If

      If (xmlError = "") And (reqParentID <> 0) And (InStr(reqMemberOptions,"o") <> 0) Then
         Set oDownline = server.CreateObject("ptsDownlineUser.CDownline")
         If oDownline Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsDownlineUser.CDownline"
         Else
            With oDownline
               .SysCurrentLanguage = reqSysLanguage
               result = CLng(.UpdateStatus(CLng(reqCompanyID), reqParentID, CLng(reqMemberID), 0, 99))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oDownline = Nothing
      End If

      If (xmlError = "") And (reqBillingID > 0) Then
         Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
         If oBilling Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
         Else
            With oBilling
               .SysCurrentLanguage = reqSysLanguage
               .Delete CLng(reqBillingID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oBilling = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("0403URL")
         reqReturnData = GetCache("0403DATA")
         SetCache "0403URL", ""
         SetCache "0403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUploadImage):
      UpdateMember
      If (xmlError = "") Then
         SetCache "MEMBERID", reqMemberID
         SetCache "CONTENTPAGE", reqcontentpage
         SetCache "POPUP", reqPopup

         Response.Redirect "0425.asp" & "?contentpage=" & reqcontentpage
      End If

   Case CLng(cActionChangeStatus):
      UpdateMember
      If (xmlError <> "") Then
         LoadBilling
      End If

      If (xmlError = "") Then
         Response.Redirect "0414.asp" & "?MemberID=" & reqMemberID & "&contentpage=" & reqcontentpage & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionCreditBilling):
      UpdateMember

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(CLng(reqCompanyID), 5, 0, CLng(reqMemberID), 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing
      LoadMember

   Case CLng(cActionMoveDownline):
      UpdateMember

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(CLng(reqCompanyID), 204, 0, CLng(reqMemberID), CLng(reqSponsorID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCompany = Nothing
      LoadMember

   Case CLng(cActionEditGovid):
      UpdateMember
      If (xmlError <> "") Then
         LoadBilling
      End If

      If (xmlError = "") Then
         Response.Redirect "10903.asp" & "?MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionPayPalPayment):
      UpdateMember

      Set oCloudZow = server.CreateObject("ptsCloudZowUser.CCloudZow")
      If oCloudZow Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCloudZowUser.CCloudZow"
      Else
         With oCloudZow
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(17, 0, CLng(reqMemberID), 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCloudZow = Nothing
      LoadMember

   Case CLng(cActionEdit16):
      UpdateMember

      Response.Redirect "4910.asp" & "?MemberID=" & reqMemberID & "&Opt=" & 4 & "&ReturnURL=" & reqPageURL

   Case CLng(cActionCoinWallet):
      UpdateMember
      
          Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
          tmpURL = "http://www.gcrmarketing.com/GCRWalletCreate.asp?M=" + CStr(reqMemberID)
          oHTTP.open "GET", tmpURL
          oHTTP.send
          Set oHTTP = Nothing
        
      LoadMember

   Case CLng(cActionDisableWallet):
      UpdateMember
      
          Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
          tmpURL = "http://www.gcrmarketing.com/GCRWalletDisable.asp?M=" + CStr(reqMemberID)
          oHTTP.open "GET", tmpURL
          oHTTP.send
          Set oHTTP = Nothing
        
      LoadMember
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " payid=" + Chr(34) + CStr(reqPayID) + Chr(34)
xmlParam = xmlParam + " orgid=" + Chr(34) + CStr(reqOrgID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqcontentpage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " refname=" + Chr(34) + CleanXML(reqRefName) + Chr(34)
xmlParam = xmlParam + " options=" + Chr(34) + CleanXML(reqOptions) + Chr(34)
xmlParam = xmlParam + " memberoptions=" + Chr(34) + CleanXML(reqMemberOptions) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " uploadimagefile=" + Chr(34) + CleanXML(reqUploadImageFile) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " visitdate=" + Chr(34) + CStr(reqVisitDate) + Chr(34)
xmlParam = xmlParam + " authuserid=" + Chr(34) + CStr(reqAuthUserID) + Chr(34)
xmlParam = xmlParam + " extra=" + Chr(34) + CStr(reqExtra) + Chr(34)
xmlParam = xmlParam + " ismsg=" + Chr(34) + CStr(reqIsMsg) + Chr(34)
xmlParam = xmlParam + " facebook=" + Chr(34) + CleanXML(reqFaceBook) + Chr(34)
xmlParam = xmlParam + " twitter=" + Chr(34) + CleanXML(reqTwitter) + Chr(34)
xmlParam = xmlParam + " google=" + Chr(34) + CleanXML(reqGoogle) + Chr(34)
xmlParam = xmlParam + " pinterest=" + Chr(34) + CleanXML(reqPinterest) + Chr(34)
xmlParam = xmlParam + " tumblr=" + Chr(34) + CleanXML(reqTumblr) + Chr(34)
xmlParam = xmlParam + " linkedin=" + Chr(34) + CleanXML(reqLinkedIn) + Chr(34)
xmlParam = xmlParam + " myspace=" + Chr(34) + CleanXML(reqMySpace) + Chr(34)
xmlParam = xmlParam + " skype=" + Chr(34) + CleanXML(reqSkype) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " sponsorid=" + Chr(34) + CStr(reqSponsorID) + Chr(34)
xmlParam = xmlParam + " binary=" + Chr(34) + CStr(reqBinary) + Chr(34)
xmlParam = xmlParam + " showqualify=" + Chr(34) + CStr(reqShowQualify) + Chr(34)
xmlParam = xmlParam + " wallet=" + Chr(34) + CStr(reqWallet) + Chr(34)
xmlParam = xmlParam + " fasttrack=" + Chr(34) + CStr(reqFastTrack) + Chr(34)
xmlParam = xmlParam + " backups=" + Chr(34) + CStr(reqBackups) + Chr(34)
xmlParam = xmlParam + " money=" + Chr(34) + CStr(reqMoney) + Chr(34)
xmlParam = xmlParam + " university=" + Chr(34) + CStr(reqUniversity) + Chr(34)
xmlParam = xmlParam + " pv=" + Chr(34) + CleanXML(reqPV) + Chr(34)
xmlParam = xmlParam + " bv=" + Chr(34) + CleanXML(reqBV) + Chr(34)
xmlParam = xmlParam + " products=" + Chr(34) + CleanXML(reqProducts) + Chr(34)
xmlParam = xmlParam + " sponsorname=" + Chr(34) + CleanXML(reqSponsorName) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CleanXML(reqToken) + Chr(34)
xmlParam = xmlParam + " billingmethod=" + Chr(34) + CleanXML(reqBillingMethod) + Chr(34)
xmlParam = xmlParam + " payoutmethod=" + Chr(34) + CleanXML(reqPayoutMethod) + Chr(34)
xmlParam = xmlParam + " member2fa=" + Chr(34) + CStr(reqMember2FA) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlGovid
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlTitles
xmlTransaction = xmlTransaction +  xmlDownline
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlCloudZow
xmlTransaction = xmlTransaction +  xmlLanguages
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Member[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Member[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0403 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the menu Definitions
If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Then
s = "<MENU name=""MemberMenu"" type=""bar"" menuwidth=""120"">"
s=s+   "<ITEM label=""Personal"">"
s=s+      "<IMAGE name=""MyInfo.gif""/>"
         If (reqcontentpage = 0) Then
s=s+      "<ITEM label=""Home"">"
s=s+         "<LINK name=""0404"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""Icons"">"
s=s+         "<LINK name=""0431"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Resources"">"
s=s+         "<LINK name=""9304"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""GroupID"" value=""" & reqGroupID & """/>"
s=s+            "<PARAM name=""GrpCompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""CustomReports"">"
s=s+         "<LINK name=""Reports"" target=""Reports"" nodata=""true"">"
s=s+            "<PARAM name=""M"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""C"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""ExpenseManager"">"
s=s+         "<LINK name=""6401"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Performance"">"
s=s+         "<LINK name=""0445"" nodata=""true"" target=""Performance"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Mentoring"">"
s=s+         "<LINK name=""0410"" nodata=""true"" target=""Mentoring"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Genealogy"">"
s=s+         "<LINK name=""0470"" nodata=""true"" target=""Genealogy"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Goals"">"
s=s+         "<LINK name=""7001"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Calendar"">"
s=s+         "<LINK name=""Calendar"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Projects"">"
s=s+         "<LINK name=""7501"" nodata=""true"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""SupportTickets"">"
s=s+         "<LINK name=""9506"" nodata=""true"" target=""SupportTickets"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""T"" value=""" & 04 & """/>"
s=s+            "<PARAM name=""I"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         If (reqIdentify <> 0) Then
s=s+      "<ITEM label=""Identification"">"
s=s+         "<LINK name=""0426"" nodata=""true"" target=""Identify"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<ITEM label=""Referrals"">"
s=s+         "<LINK name=""0408"" nodata=""true"">"
s=s+            "<PARAM name=""ReferralID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Ads"">"
s=s+         "<LINK name=""14311"" nodata=""true"" target=""Ads"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Broadcasts"">"
s=s+         "<LINK name=""14401"" nodata=""true"" target=""Broadcasts"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Finance"">"
s=s+      "<IMAGE name=""Finance.gif""/>"
s=s+      "<ITEM label=""SalesOrders"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""1""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Payments"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""2""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Bonuses"">"
s=s+         "<LINK name=""0475"" nodata=""true"" target=""Finances"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""Code"" value=""3""/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+            "<PARAM name=""Popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Customers"">"
s=s+         "<LINK name=""0448"" nodata=""true"" target=""Customers"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Billing"">"
s=s+         "<LINK name=""1011"" nodata=""true"">"
s=s+            "<PARAM name=""OwnerType"" value=""" & 04 & """/>"
s=s+            "<PARAM name=""OwnerID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""AutoShip"">"
s=s+         "<LINK name=""0433"" nodata=""true"" target=""AutoShip"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""DebtManager"">"
s=s+         "<LINK name=""10201"" nodata=""true"" target=""DebtMgr"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Sales"">"
s=s+      "<IMAGE name=""Prospect.gif""/>"
s=s+      "<ITEM label=""LeadManager"">"
s=s+         "<LINK name=""8161"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""3""/>"
s=s+            "<PARAM name=""popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""SalesSystem"">"
s=s+         "<LINK name=""8101"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""3""/>"
s=s+            "<PARAM name=""popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""Service"">"
s=s+         "<LINK name=""8151"" nodata=""true"" target=""blank"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""3""/>"
s=s+            "<PARAM name=""popup"" value=""1""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""PartyPlans"">"
s=s+         "<LINK name=""2511"" nodata=""true"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Training"">"
s=s+      "<IMAGE name=""Catalog.gif""/>"
s=s+      "<ITEM label=""Classes"">"
s=s+         "<LINK name=""1311"" nodata=""true"" target=""Classes"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""CertReport"">"
s=s+         "<LINK name=""3411"" nodata=""true"" target=""CertReport"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""TrainingBuddy"">"
s=s+         "<LINK name=""0440"" nodata=""true"" target=""Buddy"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+            "<PARAM name=""VisitDate"" value=""" & reqVisitDate & """/>"
s=s+            "<PARAM name=""ContentPage"" value=""3""/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Tools"">"
s=s+      "<IMAGE name=""Tools.gif""/>"
         If (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""ResetLogon"">"
s=s+         "<LINK name=""0104"" nodata=""true"">"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (reqSysUserGroup <= 23) And (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""ViewLogon"">"
s=s+         "<LINK name=""0113"" nodata=""true"">"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
         If (tmpUserGroup <> 0) Then
s=s+      "<ITEM label=""IPs"">"
s=s+         "<LINK name=""7111"" nodata=""true"">"
s=s+            "<PARAM name=""AuthUserID"" value=""" & reqAuthUserID & """/>"
s=s+            "<PARAM name=""contentpage"" value=""" & reqcontentpage & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
         End If
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""Assign"">"
s=s+         "<LINK name=""8101"" nodata=""true"" target=""Assign"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""AssignID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""ImportCustomers"">"
s=s+         "<LINK name=""8116"" nodata=""true"" target=""Import"">"
s=s+            "<PARAM name=""CompanyID"" value=""" & reqCompanyID & """/>"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<ITEM label=""ExportCustomers"">"
s=s+         "<LINK name=""8117"" nodata=""true"" target=""Export"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+      "<DIVIDER/>"
s=s+      "<ITEM label=""EnrollAgree"">"
s=s+         "<LINK name=""joinr"" nodata=""true"" target=""Confirm"">"
s=s+            "<PARAM name=""MemberID"" value=""" & reqMemberID & """/>"
s=s+         "</LINK>"
s=s+      "</ITEM>"
s=s+   "</ITEM>"
s=s+"</MENU>"
xmlMemberMenu = s

End If
s = "<TAB name=""MemberTab"">"
s=s+   "<ITEM label=""ViewContact"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabContact',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""ViewStatus"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabStatus',1))""/>"
s=s+   "</ITEM>"
      If (InStr(reqSysUserOptions,"V") <> 0) Or (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
s=s+   "<ITEM label=""ViewBilling"" width=""65"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabBilling',1))""/>"
s=s+   "</ITEM>"
      End If
s=s+   "<ITEM label=""Notes"" width=""65"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabNotes',1))""/>"
s=s+   "</ITEM>"
      If (reqIsMsg = 1) Then
s=s+   "<ITEM label=""Msgs"" width=""80"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabMsgs',1))""/>"
s=s+   "</ITEM>"
      End If
      If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
s=s+   "<ITEM label=""ViewAccess"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabAccess',1))""/>"
s=s+   "</ITEM>"
      End If
s=s+   "<ITEM label=""ViewGroup"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabGroup',1))""/>"
s=s+   "</ITEM>"
      If (reqSysUserGroup <= 23) Or (reqSysUserGroup = 51) Or (reqSysUserGroup = 52) Then
s=s+   "<ITEM label=""ViewFolders"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabFolders',1))""/>"
s=s+   "</ITEM>"
      End If
s=s+"</TAB>"
xmlMemberTab = s

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
xmlData = xmlData +  xmlMemberMenu
xmlData = xmlData +  xmlMemberTab
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "0403.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0403 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0403 Load file (oData) failed with error code " + CStr(oData.parseError)
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