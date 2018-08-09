<!--#include file="Include\System.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\Products.asp"-->
<!--#include file="Include\Binary.asp"-->
<!--#include file="Include\Languages.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionUploadImage = 6
Const cActionEditGovid = 14
Const cActionCreateShopper = 15
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
Dim oGovid, xmlGovid
Dim oCoption, xmlCoption
'-----other transaction data variables
Dim xmlLanguages
'-----declare page parameters
Dim reqMemberID
Dim reqCompanyID
Dim reqcontentpage
Dim reqPopup
Dim reqRefName
Dim reqIdentify
Dim reqUploadImageFile
Dim reqIsMsg
Dim reqFaceBook
Dim reqTwitter
Dim reqGoogle
Dim reqPinterest
Dim reqTumblr
Dim reqLinkedIn
Dim reqMySpace
Dim reqSkype
Dim reqBinary
Dim reqOrderOption
Dim reqShowQualify
Dim reqFastTrack
Dim reqBackups
Dim reqMoney
Dim reqUniversity
Dim reqPV
Dim reqBV
Dim reqAction
Dim reqMember2FA
Dim reqProducts
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
   SetCache "0463URL", reqReturnURL
   SetCache "0463DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0463")
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
reqcontentpage =  Numeric(GetInput("contentpage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqRefName =  GetInput("RefName", reqPageData)
reqIdentify =  Numeric(GetInput("Identify", reqPageData))
reqUploadImageFile =  GetInput("UploadImageFile", reqPageData)
reqIsMsg =  Numeric(GetInput("IsMsg", reqPageData))
reqFaceBook =  GetInput("FaceBook", reqPageData)
reqTwitter =  GetInput("Twitter", reqPageData)
reqGoogle =  GetInput("Google", reqPageData)
reqPinterest =  GetInput("Pinterest", reqPageData)
reqTumblr =  GetInput("Tumblr", reqPageData)
reqLinkedIn =  GetInput("LinkedIn", reqPageData)
reqMySpace =  GetInput("MySpace", reqPageData)
reqSkype =  GetInput("Skype", reqPageData)
reqBinary =  Numeric(GetInput("Binary", reqPageData))
reqOrderOption =  Numeric(GetInput("OrderOption", reqPageData))
reqShowQualify =  Numeric(GetInput("ShowQualify", reqPageData))
reqFastTrack =  Numeric(GetInput("FastTrack", reqPageData))
reqBackups =  Numeric(GetInput("Backups", reqPageData))
reqMoney =  Numeric(GetInput("Money", reqPageData))
reqUniversity =  Numeric(GetInput("University", reqPageData))
reqPV =  GetInput("PV", reqPageData)
reqBV =  GetInput("BV", reqPageData)
reqAction =  Numeric(GetInput("Action", reqPageData))
reqMember2FA =  Numeric(GetInput("Member2FA", reqPageData))
reqProducts =  GetInput("Products", reqPageData)
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
         oldPromoID = .PromoID
         oldSponsorID = .SponsorID

         .SponsorID = Request.Form.Item("SponsorID")
         .IsCompany = Request.Form.Item("IsCompany")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Email2 = Request.Form.Item("Email2")
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
         If (.CompanyName = "") Then
            .CompanyName = .NameLast + ", " + .NameFirst
         End If
         If (Len(.Signature) < 8) Then
            .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
         End If
         If (reqBinary > 0) Then
            .Options2 = SetBinary( .Options2, reqBinary )
         End If
         If (.CompanyID = 21) Then
            
              days = DateDiff( "d", .PaidDate, reqSysDate )
              If days > 10 Then .PaidDate = reqSysDate
            
            If (reqOrderOption = 0) Then
               tmpCode = ""
               .Price = 0
            End If
            If (reqOrderOption = 1) Then
               tmpCode = "101"
               .Price = 10
            End If
            If (reqOrderOption = 2) Then
               tmpCode = "102"
               .Price = 25
            End If
            If (reqOrderOption = 3) Then
               tmpCode = "103"
               .Price = 50
            End If
            If (reqOrderOption = 4) Then
               tmpCode = "106"
               .Price = 10
            End If
            If (reqOrderOption = 5) Then
               tmpCode = "107"
               .Price = 25
            End If
            If (reqOrderOption = 6) Then
               tmpCode = "108"
               .Price = 50
            End If
            oldOptions2 = .Options2
            .Options2 = "B" + CSTR(reqBinary) + "," + tmpCode
            If (oldOptions2 <> .Options2) Then
               If (xmlError = "") Then
                  LogMemberNote reqMemberID, "OPTIONS CHANGE: (" + oldOptions2 + ") to (" + .Options2 + ")"
               End If
            End If
         End If
         If (InStr(reqSysUserOptions,"(") <> 0) Then
            
   .SocNet = "FB;" + reqFaceBook + ":" + "TW;" + reqTwitter + ":" + "GO;" + reqGoogle + ":" + "PI;" + reqPinterest + ":" + "TU;" + reqTumblr + ":" + "LI;" + reqLinkedIn + ":" + "MS;" + reqMySpace + ":" + "SK;" + reqSkype

         End If
         If (xmlError = "") Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            reqAction = 1
            If (.PromoID <> oldPromoID) Then
               
                        LogMemberNote reqMemberID, "OVERDRAFT PROTECTION CHANGE: (" + .PromoID + ") "
                     
            End If
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
         If (reqSysUserGroup = 41) And (.Status > 3) Then
            AbortUser()
         End If
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
         reqIsMsg = .IsMsg
         reqPV = .BV
         reqBV = .QV
         If (.TaxID <> "") Then
            .TaxID = "xxx-xx-" + Right(.TaxID,4)
         End If
         If (reqCompanyID = 8) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
         End If
         If (reqCompanyID = 21) Then
            If (.Level = 1) Then
               reqShowQualify = 1
            End If
            reqOrderOption = 0
            If (InStr(.Options2, "101") <> 0) Then
               reqOrderOption = 1
            End If
            If (InStr(.Options2, "102") <> 0) Then
               reqOrderOption = 2
            End If
            If (InStr(.Options2, "103") <> 0) Then
               reqOrderOption = 3
            End If
            If (InStr(.Options2, "106") <> 0) Then
               reqOrderOption = 4
            End If
            If (InStr(.Options2, "107") <> 0) Then
               reqOrderOption = 5
            End If
            If (InStr(.Options2, "108") <> 0) Then
               reqOrderOption = 6
            End If
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
      End With
   End If
   Set oMember = Nothing

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
         End With
      End If
      Set oCoption = Nothing
   End If
   If (reqBinary > 0) Then
      reqBinary = GetBinary( tmpOptions2 )
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If

'tmpHTTPS = Request.ServerVariables("HTTPS")
''response.write "[" + tmpHTTPS + "]"
'If tmpHTTPS = "off" Then
'   Response.Redirect "https://" + reqSysServerName + reqSysServerPath + "0463.asp" + "?MemberID=" + CStr(reqMemberID) + "&ContentPage=3&Popup=1"
'End If

If (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"I") = 0) Then

   Response.Redirect "0419.asp" & "?Error=" & 1
End If
If (reqSysUserGroup = 41) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
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
      If (xmlError <> "") Or (reqPopup <> 0) Then
         LoadMember
      End If

      If (xmlError = "") And (reqPopup = 0) Then
         reqReturnURL = GetCache("0463URL")
         reqReturnData = GetCache("0463DATA")
         SetCache "0463URL", ""
         SetCache "0463DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      If (reqPopup = 0) Then
         reqReturnURL = GetCache("0463URL")
         reqReturnData = GetCache("0463DATA")
         SetCache "0463URL", ""
         SetCache "0463DATA", ""
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
         SetCache "PAGE", "0463"

         Response.Redirect "0425.asp" & "?contentpage=" & reqcontentpage
      End If

   Case CLng(cActionEditGovid):
      UpdateMember
      If (xmlError <> "") Then
         LoadBilling
      End If

      If (xmlError = "") Then
         Response.Redirect "10903.asp" & "?MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL
      End If

   Case CLng(cActionCreateShopper):
      UpdateMember
      If (xmlError <> "") Then
         LoadBilling
      End If

      If (xmlError = "") Then
         Response.Redirect "NewShopper.asp" & "?AffiliateID=" & reqMemberID & "&Ret=" & 1 & "&ReturnURL=" & reqPageURL
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
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqcontentpage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " refname=" + Chr(34) + CleanXML(reqRefName) + Chr(34)
xmlParam = xmlParam + " identify=" + Chr(34) + CStr(reqIdentify) + Chr(34)
xmlParam = xmlParam + " uploadimagefile=" + Chr(34) + CleanXML(reqUploadImageFile) + Chr(34)
xmlParam = xmlParam + " ismsg=" + Chr(34) + CStr(reqIsMsg) + Chr(34)
xmlParam = xmlParam + " facebook=" + Chr(34) + CleanXML(reqFaceBook) + Chr(34)
xmlParam = xmlParam + " twitter=" + Chr(34) + CleanXML(reqTwitter) + Chr(34)
xmlParam = xmlParam + " google=" + Chr(34) + CleanXML(reqGoogle) + Chr(34)
xmlParam = xmlParam + " pinterest=" + Chr(34) + CleanXML(reqPinterest) + Chr(34)
xmlParam = xmlParam + " tumblr=" + Chr(34) + CleanXML(reqTumblr) + Chr(34)
xmlParam = xmlParam + " linkedin=" + Chr(34) + CleanXML(reqLinkedIn) + Chr(34)
xmlParam = xmlParam + " myspace=" + Chr(34) + CleanXML(reqMySpace) + Chr(34)
xmlParam = xmlParam + " skype=" + Chr(34) + CleanXML(reqSkype) + Chr(34)
xmlParam = xmlParam + " binary=" + Chr(34) + CStr(reqBinary) + Chr(34)
xmlParam = xmlParam + " orderoption=" + Chr(34) + CStr(reqOrderOption) + Chr(34)
xmlParam = xmlParam + " showqualify=" + Chr(34) + CStr(reqShowQualify) + Chr(34)
xmlParam = xmlParam + " fasttrack=" + Chr(34) + CStr(reqFastTrack) + Chr(34)
xmlParam = xmlParam + " backups=" + Chr(34) + CStr(reqBackups) + Chr(34)
xmlParam = xmlParam + " money=" + Chr(34) + CStr(reqMoney) + Chr(34)
xmlParam = xmlParam + " university=" + Chr(34) + CStr(reqUniversity) + Chr(34)
xmlParam = xmlParam + " pv=" + Chr(34) + CleanXML(reqPV) + Chr(34)
xmlParam = xmlParam + " bv=" + Chr(34) + CleanXML(reqBV) + Chr(34)
xmlParam = xmlParam + " action=" + Chr(34) + CStr(reqAction) + Chr(34)
xmlParam = xmlParam + " member2fa=" + Chr(34) + CStr(reqMember2FA) + Chr(34)
xmlParam = xmlParam + " products=" + Chr(34) + CleanXML(reqProducts) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlGovid
xmlTransaction = xmlTransaction +  xmlCoption
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
   Response.Write "0463 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0463 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0463 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0463.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0463 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0463 Load file (oData) failed with error code " + CStr(oData.parseError)
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