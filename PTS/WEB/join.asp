<!--#include file="Include\System.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\LD_API.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\BillingProcess.asp"-->
<!--#include file="Include\Products.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\AuthorizeToken.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionAgree = 0
Const cActionContact = 1
Const cActionMembership = 2
Const cActionPayment = 3
Const cActionConfirm = 4
Const cActionProcess = 5
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
Dim oCoption, xmlCoption
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oAddress, xmlAddress
Dim oPayment, xmlPayment
Dim oBilling, xmlBilling
Dim oCloudZow, xmlCloudZow
Dim oMachine, xmlMachine
Dim oCountry, xmlCountry
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqNewMemberID
Dim reqBillingID
Dim reqPayID
Dim reqGroupID
Dim reqReferID
Dim reqIsAgree
Dim reqIsAgree2
Dim reqPayType
Dim reqReferredBy
Dim reqTitle
Dim reqMembership
Dim reqNoBill
Dim reqM
Dim reqS
Dim reqStreet1b
Dim reqStreet2b
Dim reqCityb
Dim reqStateb
Dim reqZipb
Dim reqCountryIDb
Dim reqCountryID
Dim reqCountryName
Dim reqCountryNameb
Dim reqProcessor
Dim reqMemberToken
Dim reqToken
Dim reqPayDesc
Dim reqMode
Dim reqBadPayment
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
   SetCache "joinURL", reqReturnURL
   SetCache "joinDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "join")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqNewMemberID =  Numeric(GetInput("NewMemberID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqPayID =  Numeric(GetInput("PayID", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqReferID =  Numeric(GetInput("ReferID", reqPageData))
reqIsAgree =  Numeric(GetInput("IsAgree", reqPageData))
reqIsAgree2 =  Numeric(GetInput("IsAgree2", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqReferredBy =  GetInput("ReferredBy", reqPageData)
reqTitle =  Numeric(GetInput("Title", reqPageData))
reqMembership =  Numeric(GetInput("Membership", reqPageData))
reqNoBill =  Numeric(GetInput("NoBill", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqStreet1b =  GetInput("Street1b", reqPageData)
reqStreet2b =  GetInput("Street2b", reqPageData)
reqCityb =  GetInput("Cityb", reqPageData)
reqStateb =  GetInput("Stateb", reqPageData)
reqZipb =  GetInput("Zipb", reqPageData)
reqCountryIDb =  GetInput("CountryIDb", reqPageData)
reqCountryID =  GetInput("CountryID", reqPageData)
reqCountryName =  GetInput("CountryName", reqPageData)
reqCountryNameb =  GetInput("CountryNameb", reqPageData)
reqProcessor =  Numeric(GetInput("Processor", reqPageData))
reqMemberToken =  Numeric(GetInput("MemberToken", reqPageData))
reqToken =  Numeric(GetInput("Token", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
reqMode =  Numeric(GetInput("Mode", reqPageData))
reqBadPayment =  Numeric(GetInput("BadPayment", reqPageData))
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

Sub LoadCompanyOptions()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqSysUserOptions = .Options
      End With
   End If
   Set oCoption = Nothing
End Sub

Sub LoadCountrys()
   On Error Resume Next

   Set oCountrys = server.CreateObject("ptsCountryUser.CCountrys")
   If oCountrys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountrys"
   Else
      With oCountrys
         .SysCurrentLanguage = reqSysLanguage
         xmlCountrys = .EnumCompany(reqCompanyID, , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCountrys = Nothing
End Sub

Sub LoadAgree()
   On Error Resume Next

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "enroll1.htm"
         .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
         .Language = reqSysLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing

   If (reqReferID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqReferID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = TRIM(.NameFirst + " " + .NameLast)
            
If .Status <> "1" Then
   Response.Write "The Affiliate that referred you here is Inactive! (" + reqReferredBy + " #" + CStr(reqM) + ")"
   Response.End
End If

         End With
      End If
      Set oMember = Nothing
   End If
End Sub

Sub ValidLogon()
   On Error Resume Next
   tmpNewLogon = Request.Form.Item("NewLogon")
   tmpNewPassword = Request.Form.Item("NewPassword")
   If (xmlError = "") And (Len(tmpNewLogon) < 6) Then
      DoError 10101, "", "Oops, Your Logon Name must be at least six characters/numbers long."
   End If
   If (xmlError = "") And (Len(tmpNewPassword) < 6) Then
      DoError 10102, "", "Oops, Your Password must be at least six characters/numbers long."
   End If
   If (xmlError = "") And (Len(tmpNewLogon) > 0) Then

      Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
      If oAuthUser Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
      Else
         With oAuthUser
            .SysCurrentLanguage = reqSysLanguage
            IsAvailable = CLng(.IsLogon(tmpNewLogon))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAuthUser = Nothing
      If (IsAvailable = 0) Then
         DoError -2147220513, "", "Oops, The Logon/Website Name is not available.  Please select another or contact Member Support for assistance."
      End If
   End If
End Sub

Sub ValidAddress()
   On Error Resume Next

   If (xmlError = "") Then
      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .SysCurrentLanguage = reqSysLanguage
            .OwnerType = 04
            .OwnerID = -1
            .AddressType = 2

            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            .Validate 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAddress = Nothing
   End If
End Sub

Sub ValidPhone()
   On Error Resume Next
   tmpPhone = Request.Form.Item("Phone1")
   If (tmpPhone = "") Then
      DoError 10006, "", "Oops, Phone Number is Required."
   End If
End Sub

Sub ValidBilling()
   On Error Resume Next
   tmpPayType = Request.Form.Item("PayType")
   tmpCardNumber = Request.Form.Item("CardNumber")

   If (tmpPayType <= 4) Then
      Set oPayment = server.CreateObject("wtPayment.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
      Else
         With oPayment
            result = CLng(.ValidCardNumber(tmpCardNumber))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (result < 0) Then
               DoError 10008, "", "Oops, Invalid Length of Credit Card Number."
            End If
            If (result = 0) Then
               DoError 10009, "", "Oops, Invalid Credit Card Number."
            End If
            If (result >= 1) And (result <= 4) And (CLng(result) <> CLng(tmpPayType)) Then
               tmpPayType = CLng(result)
            End If
            If (result > 4) Then
               DoError 10012, "", "Oops, Invalid Credit Card Type."
            End If
         End With
      End If
      Set oPayment = Nothing
   End If
   If (xmlError = "") And (tmpPayType <= 4) Then
      tmpCardMo = Request.Form.Item("CardMo")
      tmpCardYr = Request.Form.Item("CardYr")
      tmpCardDate = tmpCardMo + "/1/" + tmpCardYr
      tmpCardDate = DATEADD("m", 1, tmpCardDate)
      If (CDate(tmpCardDate) < CDate(reqSysDate)) Then
         DoError 10013, "", "Oops, Credit Card date has expired."
      End If
   End If

   If (xmlError = "") And (tmpPayType <= 7) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load reqBillingID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (tmpPayType <= 4) Then
               .PayType = 1
               .CardType = tmpPayType
               .CardNumber = Request.Form.Item("CardNumber")
               .CardMo = Request.Form.Item("CardMo")
               .CardYr = Request.Form.Item("CardYr")
               .CardName = Request.Form.Item("CardName")
               .CardCode = Request.Form.Item("CardCode")
               .Zip = Request.Form.Item("CardZip")
            End If
            If (tmpPayType = 5) Then
               .PayType = 2
               .CheckBank = Request.Form.Item("CheckBank")
               .CheckRoute = Request.Form.Item("CheckRoute")
               .CheckAccount = Request.Form.Item("CheckAccount")
               .CheckAcctType = Request.Form.Item("CheckAcctType")
               .CheckName = Request.Form.Item("CheckName")
            End If
            If (tmpPayType = 7) Then
               .PayType = 3
            End If
            If (xmlError = "") Then
               .Validate 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError = "") Then
               tmpNameFirst = Request.Form.Item("NameFirst")
               tmpNameLast = Request.Form.Item("NameLast")
               .BillingName = tmpNameFirst + " " + tmpNameLast
               .Street1 = Request.Form.Item("Street1b")
               .Street2 = Request.Form.Item("Street2b")
               .City = Request.Form.Item("Cityb")
               .State = Request.Form.Item("Stateb")
               .Zip = Request.Form.Item("Zipb")
               .CountryID = Request.Form.Item("CountryIDb")
               If (xmlError = "") And (reqBillingID <> 0) Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (xmlError = "") And (reqBillingID = 0) Then
                  reqBillingID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End With
      End If
      Set oBilling = Nothing
   End If
End Sub

Sub AddMember()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load ReferID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqGroupID = .GroupID
      End With
   End If
   Set oMember = Nothing

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany reqCompanyID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqSysUserOptions = .Options
         tmpSendEmail = .IsNewEmail
      End With
   End If
   Set oCoption = Nothing

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqNewMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         .AutoShipDate = Request.Form.Item("AutoShipDate")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         ClearProducts oMember
         If (reqMembership = 1) Then
            .Title = 2
            SetFastTrack oMember
            SetProduct oMember, cZowBackups, 8
            SetProduct oMember, cZowMoney, 1
            SetProduct oMember, cZowUniversity, 1
            GetPrice oMember
            BillingPrice = 299
         End If
         If (reqMembership = 2) Then
            .Title = 2
            SetProduct oMember, cZowBackups, 2
            SetProduct oMember, cZowMoney, 1
            SetProduct oMember, cZowUniversity, 1
            GetPrice oMember
         End If
         If (reqMembership = 3) Then
            .Title = 2
            SetProduct oMember, cZowBackups, 8
            GetPrice oMember
         End If
         If (reqMembership = 4) Then
            .Title = 1
            SetProduct oMember, cZowBackups, 1
            GetPrice oMember
         End If
         If (reqMembership = 5) Then
            .Title = 1
         End If
         .Title2 = .Title
         .BV = .Price
         .BV2 = .Price
         If (reqMembership <> 1) Then
            BillingPrice = .Price
         End If
         If (reqNewMemberID <> 0) Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqNewMemberID = 0) Then
            .CompanyID = reqCompanyID
            .EnrollDate = Now
            .UserStatus = 1
            .UserGroup = 41
            If (reqNoBill <> 0) Then
               .Billing = 1
            End If
            If (reqNoBill = 0) Then
               .Billing = 3
            End If
            .BillingID = reqBillingID
            .PayID = reqPayID
            .GroupID = reqGroupID
            .Icons = tmpIcons
            .AccessLimit = "NONE"
            If (.CompanyName = "") Then
               .CompanyName = .NameLast + ", " + .NameFirst
            End If
            .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
            .NotifyMentor = "ABCDEF"
            .ReferralID = reqReferID
            .SponsorID = reqS
            .MentorID = reqReferID
            .PaidDate = reqSysDate
            .Level = 1
            reqNewMemberID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (reqBillingID = 0) Then
            LogMemberNote reqNewMemberID, "PAYPAL ENROLLMENT"
         End If
         If (xmlError = "") And (reqBillingID <> 0) Then
            tmpName = .NameFirst + " " + .NameLast
            GetToken reqNewMemberID, reqBillingID, tmpName, .Email, reqProcessor, reqMemberToken, reqToken, reqPayDesc 
            If (xmlError = "") Then
               .Reference = CSTR(reqProcessor) + "-" + CSTR(reqMemberToken)
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
         If (xmlError = "") And (reqBillingID <> 0) And (BillingPrice <> 0) Then
            If (reqNoBill = 0) Then
               GetPayment reqNewMemberID, BillingPrice, reqPayType, reqPayDesc, reqProcessor, reqMemberToken, reqToken
               If (xmlError = "") Then
                  .PaidDate = DATEADD("m", 1, .PaidDate)
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
         If (xmlError = "") Then
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0105.asp?AuthUserID=" & .AuthUserID
               oHTTP.send
            End If
            Set oHTTP = Nothing

         End If
         If (xmlError = "") Then
            
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0437.asp?Leaders=1&MemberID=" & reqNewMemberID
               oHTTP.send
            End If
            Set oHTTP = Nothing

         End If
      End With
   End If
   Set oMember = Nothing

   If (xmlError = "") Then
      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = 04
            .OwnerID = reqNewMemberID
            .AddressType = 2
            .IsActive = 1

            .Street1 = Request.Form.Item("Street1")
            .Street2 = Request.Form.Item("Street2")
            .City = Request.Form.Item("City")
            .State = Request.Form.Item("State")
            .Zip = Request.Form.Item("Zip")
            .CountryID = Request.Form.Item("CountryID")
            If (.Street1 <> "") Then
               tmpAddressID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oAddress = Nothing
   End If

   If (xmlError = "") Then
      Set oCloudZow = server.CreateObject("ptsCloudZowUser.CCloudZow")
      If oCloudZow Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCloudZowUser.CCloudZow"
      Else
         With oCloudZow
            .SysCurrentLanguage = reqSysLanguage
            Count = CLng(.Custom(100, 0, reqNewMemberID, 0))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oCloudZow = Nothing
   End If

   If (xmlError = "") And (reqMembership < 5) Then
      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .MemberID = reqNewMemberID
            .Status = 1
            .Service = 1
            .Qty = 2
            .NameFirst = Request.Form.Item("NameFirst")
            .NameLast = Request.Form.Item("NameLast")
            .Email = Request.Form.Item("Email")
            .Password = Request.Form.Item("NewPassword")
            .WebName = "temp"
            MachineID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            SetComputerWebName oMachine
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpStatus = .Status
            .Status = 2
            
            Result = UpdateComputerStatus( oMachine, tmpStatus )
            If Result <> "OK" Then
   DoError -1, "", Result
   LogMemberNote reqNewMemberID, "ENROLL COMPUTER ERROR: " + Result
   SendEmail reqSysCompanyID, "support@CloudZow.com", "support@CloudZow.com", "support@CloudZow.com", "", "", "ENROLL COMPUTER ERROR: " + .Email, .NameFirst + " " + .NameLast + " - " + .LiveDriveID + " - " + Result
   Else
   'Email Support for new computer limits
   SendEmail reqSysCompanyID, "support@CloudZow.com", "support@CloudZow.com", "limit@CloudZow.com", "", "", "NEW COMPUTER: " + .Email, .NameFirst + " " + .NameLast + " - " + .LiveDriveID + " (" + .Qty + ")"
   End If

            If (xmlError = "") Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMachine = Nothing
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
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .CompanyName = Request.Form.Item("CompanyName")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         .AutoShipDate = Request.Form.Item("AutoShipDate")
         .NewLogon = Request.Form.Item("NewLogon")
         .NewPassword = Request.Form.Item("NewPassword")
         xmlMember = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
   If oAddress Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
   Else
      With oAddress
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         If (Len(.CountryID) = 0) Then
            .CountryID = 224
         End If
         xmlAddress = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAddress = Nothing

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .CardNumber = Request.Form.Item("CardNumber")
         .CardMo = Request.Form.Item("CardMo")
         .CardYr = Request.Form.Item("CardYr")
         .CardName = Request.Form.Item("CardName")
         .CardCode = Request.Form.Item("CardCode")
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

reqCompanyID = 5
reqSysCompanyID = 5
SetCache "COMPANYID", reqSysCompanyID
If (reqTitle = 0) Then
   reqTitle = 1
End If
If (reqM = 0) Then
   reqM = GetCache("A")
End If
If (reqM = "") Then
   reqM = 0
End If
reqMemberID = reqM
reqReferID = reqM
If (reqS = 0) Then
   reqS = reqM
End If
If (reqCountryIDb = 0) Then
   reqCountryIDb = 224
End If
If (reqActionCode >= 1) And (reqActionCode <= 4) Then
   reqIsAgree = Request.Form.Item("IsAgree")
   reqMembership = Request.Form.Item("Membership")
   reqIsAgree2 = Request.Form.Item("IsAgree2")
   reqPayType = 1
   LoadMember
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionAgree):
      reqMode = 0
      reqPayType = 1
      reqMembership = 1

   Case CLng(cActionContact):
      If (reqIsAgree = 0) Then
         DoError 10103, "", "Oops, You must agree to the terms and conditions."
      End If
      If (xmlError = "") Then
         reqMode = 1
      End If

   Case CLng(cActionMembership):
      If (xmlError = "") Then
         LoadCompanyOptions
      End If
      tmpNameFirst = Request.Form.Item("NameFirst")
      tmpNameLast = Request.Form.Item("NameLast")
      tmpCountryID = Request.Form.Item("CountryID")
      tmpCompanyName = Request.Form.Item("CompanyName")
      If (xmlError = "") And (tmpNameFirst = "") Then
         DoError 10125, "", "Oops, Please enter a First Name."
      End If
      If (xmlError = "") And (tmpNameLast = "") Then
         DoError 10126, "", "Oops, Please enter a Last Name."
      End If
      If (xmlError = "") Then
         tmpEmail = Request.Form.Item("Email")
         
                  If ValidEmail( tmpEmail ) = 0 Then DoError 10122, "", "Oops, Invalid Email Address."
               
      End If
      If (xmlError = "") Then
         tmpPassword = Request.Form.Item("NewPassword")
         If (LEN(tmpPassword) < 6) Then
            DoError 10124, "", "Oops, Please enter at least 6 characters for the Password."
         End If
      End If
      If (xmlError = "") Then
         ValidAddress
      End If
      If (xmlError = "") Then
         ValidPhone
      End If
      If (xmlError = "") Then
         ValidLogon
      End If
      If (xmlError = "") Then
         reqMode = 2
      End If

   Case CLng(cActionPayment):

      If (reqMembership < 5) Then
         Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
         If oMachine Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
         Else
            With oMachine
               .SysCurrentLanguage = reqSysLanguage
               .Email = Request.Form.Item("Email")
               If (xmlError = "") Then
                  .FetchEmail .Email
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (CLng(.MachineID) <> 0) Then
                     DoError 10123, "", "Oops, This email address is already assigned to another computer."
                     reqMode = 1
                  End If
               End If
            End With
         End If
         Set oMachine = Nothing
      End If
      If (xmlError = "") Then
         reqMode = 3
      End If

   Case CLng(cActionConfirm):
      tmpCardNumber = Request.Form.Item("CardNumber")
      tmpCardNumber = lcase(tmpCardNumber)
      If (reqMembership <> 5) And (tmpCardNumber = "paypal") Then
         tmpCardNumber = ""
      End If
      If (xmlError = "") And (reqMembership < 5) And (reqIsAgree2 = 0) Then
         DoError 10128, "", "Oops, You must agree to be billed monthly."
      End If
      If (xmlError = "") And (tmpCardNumber <> "paypal") Then
         ValidBilling
      End If
      If (xmlError = "") Then
         reqMode = 4
      End If

   Case CLng(cActionProcess):
      If (xmlError = "") Then
         Addmember
      End If
      If (xmlError <> "") Then
         LoadMember
      End If
      If (xmlError = "") Then
         reqMode = 5

         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = "AffiliateWelcome.htm"
               .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If
End Select

If (reqMode = 0) Then
   LoadAgree
End If
If (reqMode = 1) Or (reqMode = 3) Then
   LoadCountrys
End If
If (reqMode = 4) Then

   If (reqCountryID <> 224) Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = "GlobalCashCard.htm"
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(reqCompanyID)
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If

   Set oCountry = server.CreateObject("ptsCountryUser.CCountry")
   If oCountry Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountry"
   Else
      With oCountry
         .SysCurrentLanguage = reqSysLanguage
         .Load reqCountryID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqCountryName = .CountryName
         reqCountryNameb = .CountryName
         If (reqCountryID <> reqCountryIDb) Then
            .Load reqCountryIDb, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCountryNameb = .CountryName
         End If
      End With
   End If
   Set oCountry = Nothing
End If
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " newmemberid=" + Chr(34) + CStr(reqNewMemberID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " payid=" + Chr(34) + CStr(reqPayID) + Chr(34)
xmlParam = xmlParam + " groupid=" + Chr(34) + CStr(reqGroupID) + Chr(34)
xmlParam = xmlParam + " referid=" + Chr(34) + CStr(reqReferID) + Chr(34)
xmlParam = xmlParam + " isagree=" + Chr(34) + CStr(reqIsAgree) + Chr(34)
xmlParam = xmlParam + " isagree2=" + Chr(34) + CStr(reqIsAgree2) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CStr(reqTitle) + Chr(34)
xmlParam = xmlParam + " membership=" + Chr(34) + CStr(reqMembership) + Chr(34)
xmlParam = xmlParam + " nobill=" + Chr(34) + CStr(reqNoBill) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " street1b=" + Chr(34) + CleanXML(reqStreet1b) + Chr(34)
xmlParam = xmlParam + " street2b=" + Chr(34) + CleanXML(reqStreet2b) + Chr(34)
xmlParam = xmlParam + " cityb=" + Chr(34) + CleanXML(reqCityb) + Chr(34)
xmlParam = xmlParam + " stateb=" + Chr(34) + CleanXML(reqStateb) + Chr(34)
xmlParam = xmlParam + " zipb=" + Chr(34) + CleanXML(reqZipb) + Chr(34)
xmlParam = xmlParam + " countryidb=" + Chr(34) + CleanXML(reqCountryIDb) + Chr(34)
xmlParam = xmlParam + " countryid=" + Chr(34) + CleanXML(reqCountryID) + Chr(34)
xmlParam = xmlParam + " countryname=" + Chr(34) + CleanXML(reqCountryName) + Chr(34)
xmlParam = xmlParam + " countrynameb=" + Chr(34) + CleanXML(reqCountryNameb) + Chr(34)
xmlParam = xmlParam + " processor=" + Chr(34) + CStr(reqProcessor) + Chr(34)
xmlParam = xmlParam + " membertoken=" + Chr(34) + CStr(reqMemberToken) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CStr(reqToken) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " mode=" + Chr(34) + CStr(reqMode) + Chr(34)
xmlParam = xmlParam + " badpayment=" + Chr(34) + CStr(reqBadPayment) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlAddress
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlCloudZow
xmlTransaction = xmlTransaction +  xmlMachine
xmlTransaction = xmlTransaction +  xmlCountry
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\join[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\join[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "join Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "join Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "join Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "join.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "join Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "join Load file (oData) failed with error code " + CStr(oData.parseError)
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