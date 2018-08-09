<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\Products.asp"-->
<!--#include file="Include\Billing.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\AuthorizeNet.asp"-->
<!--#include file="Include\AuthorizeToken.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 2
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
Dim reqSysBrdUserID, reqSysBrdUserGroup
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGAA, reqSysCGAA
Dim reqLangDialect, reqLangCountry, reqLangDefault
Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm
Dim xmlTransaction, xmlData
'-----language variables
Dim oLanguage, xmlLanguage
Dim xslPage
Dim fileLanguage
'-----object variables
Dim oBilling, xmlBilling
Dim oMember, xmlMember
Dim oMachines, xmlMachines
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
Dim oPayment, xmlPayment
Dim oCloudZow, xmlCloudZow
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqBillingID
Dim reqComputers
Dim reqZowMoney
Dim reqZowUniversity
Dim reqFastTrack
Dim reqIsAgree2
Dim reqPayType
Dim reqAmount
Dim reqActiveComputers
Dim reqNoBill
Dim reqResult
Dim reqStreet1b
Dim reqStreet2b
Dim reqCityb
Dim reqStateb
Dim reqZipb
Dim reqCountryIDb
Dim reqProcessor
Dim reqMemberToken
Dim reqToken
Dim reqPayDesc
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
   SetCache "changeURL", reqReturnURL
   SetCache "changeDATA", reqReturnData
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
reqSysBrdUserID = Numeric(GetCache("BRDUSERID"))
reqSysBrdUserGroup = Numeric(GetCache("BRDUSERGROUP"))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "change")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGAA = GetCache("GAA")
reqSysCGAA = GetCache("CGAA")

'-----fetch page parameters
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqBillingID =  Numeric(GetInput("BillingID", reqPageData))
reqComputers =  Numeric(GetInput("Computers", reqPageData))
reqZowMoney =  Numeric(GetInput("ZowMoney", reqPageData))
reqZowUniversity =  Numeric(GetInput("ZowUniversity", reqPageData))
reqFastTrack =  Numeric(GetInput("FastTrack", reqPageData))
reqIsAgree2 =  Numeric(GetInput("IsAgree2", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqAmount =  Numeric(GetInput("Amount", reqPageData))
reqActiveComputers =  Numeric(GetInput("ActiveComputers", reqPageData))
reqNoBill =  Numeric(GetInput("NoBill", reqPageData))
reqResult =  Numeric(GetInput("Result", reqPageData))
reqStreet1b =  GetInput("Street1b", reqPageData)
reqStreet2b =  GetInput("Street2b", reqPageData)
reqCityb =  GetInput("Cityb", reqPageData)
reqStateb =  GetInput("Stateb", reqPageData)
reqZipb =  GetInput("Zipb", reqPageData)
reqCountryIDb =  GetInput("CountryIDb", reqPageData)
reqProcessor =  Numeric(GetInput("Processor", reqPageData))
reqMemberToken =  Numeric(GetInput("MemberToken", reqPageData))
reqToken =  Numeric(GetInput("Token", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
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

Sub NewBilling()
   On Error Resume Next
   reqPayType = 1
   LoadLists

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CheckAcctType = 1
         reqCountryIDb = 224
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

Sub LoadBilling()
   On Error Resume Next
   LoadLists

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .CheckAcctType = 1

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

Sub LoadLists()
   On Error Resume Next

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load reqMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqBillingID = .BillingID
         .CompanyName = ""
         reqFastTrack = GetFastTrack( oMember)
         reqComputers = GetProduct( oMember, cZowBackups)
         reqZowMoney = GetProduct( oMember, cZowMoney)
         reqZowUniversity = GetProduct( oMember, cZowUniversity)
         
      aReference = Split(.Reference,"-")
      if(UBOUND(aReference) = 1) Then reqMemberToken = aReference(1) Else reqMemberToken = 0 

         xmlMember = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oMachines = server.CreateObject("ptsMachineUser.CMachines")
   If oMachines Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachines"
   Else
      With oMachines
         .SysCurrentLanguage = reqSysLanguage
         .List reqMemberID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            reqActiveComputers = 0
            For Each oMachine in oMachines
               With oMachine
                  If .Status <= 2 Then
                     reqActiveComputers = reqActiveComputers + 1
                  End If
               End With
            Next

      End With
   End If
   Set oMachines = Nothing

   If (reqBillingID <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load reqBillingID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPayType = .PayType
            reqProcessor = .TokenType
            reqToken = .Token
            reqPayDesc = BillingPayment( oBilling )
         End With
      End If
      Set oBilling = Nothing
   End If

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

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Change.htm"
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
            tmpNameFirst = Request.Form.Item("NameFirst")
            tmpNameLast = Request.Form.Item("NameLast")
            .BillingName = tmpNameFirst + " " + tmpNameLast
            .Street1 = Request.Form.Item("Street1b")
            .Street2 = Request.Form.Item("Street2b")
            .City = Request.Form.Item("Cityb")
            .State = Request.Form.Item("Stateb")
            .Zip = Request.Form.Item("Zipb")
            .CountryID = Request.Form.Item("CountryIDb")
            If (xmlError = "") Then
               .Validate 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError = "") Then
               reqBillingID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oBilling = Nothing
   End If
End Sub

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then

   Response.Redirect "0101.asp" & "?ActionCode=" & 9
End If
reqCompanyID = 5
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewBilling

   Case CLng(cActionUpdate):
      If (reqBillingID = 0) Then
         If (xmlError = "") And (reqIsAgree2 = 0) Then
            DoError 10128, "", "Oops, You must agree to be billed monthly."
         End If
         If (xmlError = "") Then
            ValidBilling
         End If
      End If

      If (xmlError = "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpSponsorID = .SponsorID
               tmpName = .NameFirst + " " + .NameLast + " (#" + .MemberID + ")"
               If (reqBillingID <> 0) Then
                  .BillingID = reqBillingID
               End If
               If (.Process = 0) And (reqComputers <> 0) Then
                  .PaidDate = reqSysDate
               End If
               oldFastTrack = .IsMaster
               oldPrice = .Price
               oldComputers = .Process
               oldZowMoney = GetProduct( oMember, cZowMoney)
               oldZowUniversity = GetProduct( oMember, cZowUniversity)
               tmpFastTrack = Request.Form.Item("FastTrack")
               tmpComputers = Request.Form.Item("Computers")
               tmpZowMoney = Request.Form.Item("ZowMoney")
               tmpZowUniversity = Request.Form.Item("ZowUniversity")
               tmpZowMoney = CLng(tmpZowMoney)
               tmpZowUniversity = CLng(tmpZowUniversity)
               tmpNote = ""
               BillingPrice = 0
               If (oldFastTrack = 0) And (tmpFastTrack <> 0) Then
                  SetFastTrack oMember
                  SetProduct oMember, cZowBackups, 8
                  SetProduct oMember, cZowMoney, 1
                  SetProduct oMember, cZowUniversity, 1
                  BillingPrice = 299
                  tmpNote = "Fast Track"
               End If
               If (oldFastTrack <> 0) Or (tmpFastTrack = 0) Then
                  SetProduct oMember, cZowBackups, tmpComputers
                  SetProduct oMember, cZowMoney, tmpZowMoney
                  SetProduct oMember, cZowUniversity, tmpZowUniversity
                  If (tmpComputers <> oldComputers) Then
                     tmpNote = tmpNote + "Computers: " + CStr(oldComputers) + " to " + CStr(tmpComputers) + " "
                  End If
                  If (tmpZowMoney <> oldZowMoney) Then
                     If (tmpZowMoney <> 0) Then
                        tmpNote = tmpNote + "Added ZowMoney "
                     End If
                     If (tmpZowMoney = 0) Then
                        tmpNote = tmpNote + "Removed ZowMoney "
                     End If
                  End If
                  If (tmpZowUniversity <> oldZowUniversity) Then
                     If (tmpZowUniversity <> 0) Then
                        tmpNote = tmpNote + "Added ZowUniversity "
                     End If
                     If (tmpZowUniversity = 0) Then
                        tmpNote = tmpNote + "Removed ZowUniversity "
                     End If
                  End If
               End If
               GetPrice oMember
               If (xmlError = "") And (BillingPrice <> 0) Then
                  If (reqNoBill = 0) And (reqProcessor <> 0) Then
                     GetPayment reqMemberID, BillingPrice, reqPayType, reqPayDesc, reqProcessor, reqMemberToken, reqToken
                     If (xmlError = "") Then
                        .PaidDate = DATEADD("m", 1, .PaidDate)
                        .Save CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End If
                  End If
                  If (reqProcessor = 0) Then
                     LogMemberNote reqMemberID, "FAST TRACK PAYMENT ERROR: Missing Token"
                  End If
               End If
               reqAmount = CLng(.Price) - CLng(oldPrice)
               .BV = CLng(.BV) + reqAmount
               .BV2 = CLng(.BV2) + reqAmount
               oldTitle = .Title
               If (oldTitle = 2) And (CLng(.BV) < 40) Then
                  .Title = 1
                  .Title2 = 1
                  .MaxMembers = 1
               End If
               If (CLng(.BV) >= 40) Then
                  If (.Title < 2) Then
                     .Title = 2
                  End If
                  If (.Title2 < 2) Then
                     .Title2 = 2
                  End If
                  If (.MaxMembers < 2) Then
                     .MaxMembers = 2
                  End If
               End If
               newTitle = .Title
               If (xmlError = "") Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oMember = Nothing
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
               .IsEarned = 1
               .Add CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMemberTitle = Nothing

         If (tmpSponsorID <> 0) Then
            Set oMember = server.CreateObject("ptsMemberUser.CMember")
            If oMember Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
            Else
               With oMember
                  .SysCurrentLanguage = reqSysLanguage
                  .Load tmpSponsorID, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpTo = .Email
                  
                  tmpSender = "support@CloudZow.com"
                  tmpFrom = "support@CloudZow.com"
                  If newTitle = 1 Then
                     tmpSubject = tmpName + " has downgraded to a Reseller"
                  Else
                     tmpSubject = tmpName + " has upgraded to an Affiliate"
                  End If   
                  tmpBody = tmpSubject
                  SendEmail tmpSender, tmpFrom, tmpTo, tmpSubject, tmpBody

               End With
            End If
            Set oMember = Nothing
         End If
      End If

      If (xmlError = "") And (reqAmount <> 0) Then
         Set oCloudZow = server.CreateObject("ptsCloudZowUser.CCloudZow")
         If oCloudZow Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCloudZowUser.CCloudZow"
         Else
            With oCloudZow
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(101, 0, reqMemberID, CLng(reqAmount)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCloudZow = Nothing
      End If

      If (xmlError = "") And (BillingPrice = 299) Then
         Set oCloudZow = server.CreateObject("ptsCloudZowUser.CCloudZow")
         If oCloudZow Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCloudZowUser.CCloudZow"
         Else
            With oCloudZow
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(15, 0, reqMemberID, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCloudZow = Nothing
      End If
      If (xmlError = "") And (tmpNote <> "") Then
         LogMemberNote reqMemberID, "PURCHASE CHANGE: " + tmpNote
      End If
      LoadBilling
      If (xmlError = "") Then
         If (BillingPrice = 0) Then
            reqResult = 1
         End If
         If (BillingPrice <> 0) Then
            reqResult = 2
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("changeURL")
      reqReturnData = GetCache("changeDATA")
      SetCache "changeURL", ""
      SetCache "changeDATA", ""
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
xmlSystem = xmlSystem + " brduserid=" + Chr(34) + CStr(reqSysBrdUserID) + Chr(34)
xmlSystem = xmlSystem + " brdusergroup=" + Chr(34) + CStr(reqSysBrdUserGroup) + Chr(34)
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
xmlSystem = xmlSystem + " gaa=" + Chr(34) + reqSysGAA + Chr(34)
xmlSystem = xmlSystem + " cgaa=" + Chr(34) + reqSysCGAA + Chr(34)
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
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " computers=" + Chr(34) + CStr(reqComputers) + Chr(34)
xmlParam = xmlParam + " zowmoney=" + Chr(34) + CStr(reqZowMoney) + Chr(34)
xmlParam = xmlParam + " zowuniversity=" + Chr(34) + CStr(reqZowUniversity) + Chr(34)
xmlParam = xmlParam + " fasttrack=" + Chr(34) + CStr(reqFastTrack) + Chr(34)
xmlParam = xmlParam + " isagree2=" + Chr(34) + CStr(reqIsAgree2) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " amount=" + Chr(34) + CStr(reqAmount) + Chr(34)
xmlParam = xmlParam + " activecomputers=" + Chr(34) + CStr(reqActiveComputers) + Chr(34)
xmlParam = xmlParam + " nobill=" + Chr(34) + CStr(reqNoBill) + Chr(34)
xmlParam = xmlParam + " result=" + Chr(34) + CStr(reqResult) + Chr(34)
xmlParam = xmlParam + " street1b=" + Chr(34) + CleanXML(reqStreet1b) + Chr(34)
xmlParam = xmlParam + " street2b=" + Chr(34) + CleanXML(reqStreet2b) + Chr(34)
xmlParam = xmlParam + " cityb=" + Chr(34) + CleanXML(reqCityb) + Chr(34)
xmlParam = xmlParam + " stateb=" + Chr(34) + CleanXML(reqStateb) + Chr(34)
xmlParam = xmlParam + " zipb=" + Chr(34) + CleanXML(reqZipb) + Chr(34)
xmlParam = xmlParam + " countryidb=" + Chr(34) + CleanXML(reqCountryIDb) + Chr(34)
xmlParam = xmlParam + " processor=" + Chr(34) + CStr(reqProcessor) + Chr(34)
xmlParam = xmlParam + " membertoken=" + Chr(34) + CStr(reqMemberToken) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CStr(reqToken) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlMachines
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlCloudZow
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language\change[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\change[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "change Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "change Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "change Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "change.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "change Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "change Load file (oData) failed with error code " + CStr(oData.parseError)
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