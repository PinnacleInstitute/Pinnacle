<!--#include file="Include\System.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\LD_API.asp"-->
<!--#include file="Include\Comm.asp"-->
<!--#include file="Include\BillingProcess.asp"-->
<!--#include file="Include\Note.asp"-->
<!--#include file="Include\AuthorizeToken.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 2
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
Dim oBilling, xmlBilling
Dim oCountrys, xmlCountrys
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oPayment, xmlPayment
Dim oMachine, xmlMachine
Dim oCloudZow, xmlCloudZow
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqNewMemberID
Dim reqBillingID
Dim reqReferID
Dim reqPayType
Dim reqReferredBy
Dim reqIsAgree
Dim reqIsAgree2
Dim reqComputers
Dim reqM
Dim reqP
Dim reqPay
Dim reqProcessor
Dim reqMemberToken
Dim reqToken
Dim reqPayDesc
Dim reqFirst1
Dim reqLast1
Dim reqEmail1
Dim reqPassword1
Dim reqFirst2
Dim reqLast2
Dim reqEmail2
Dim reqPassword2
Dim reqFirst3
Dim reqLast3
Dim reqEmail3
Dim reqPassword3
Dim reqFirst4
Dim reqLast4
Dim reqEmail4
Dim reqPassword4
Dim reqFirst5
Dim reqLast5
Dim reqEmail5
Dim reqPassword5
Dim reqFirst6
Dim reqLast6
Dim reqEmail6
Dim reqPassword6
Dim reqFirst7
Dim reqLast7
Dim reqEmail7
Dim reqPassword7
Dim reqFirst8
Dim reqLast8
Dim reqEmail8
Dim reqPassword8
Dim reqFirst9
Dim reqLast9
Dim reqEmail9
Dim reqPassword9
Dim reqFirst10
Dim reqLast10
Dim reqEmail10
Dim reqPassword10
Dim reqFirst11
Dim reqLast11
Dim reqEmail11
Dim reqPassword11
Dim reqFirst12
Dim reqLast12
Dim reqEmail12
Dim reqPassword12
Dim reqFirst13
Dim reqLast13
Dim reqEmail13
Dim reqPassword13
Dim reqFirst14
Dim reqLast14
Dim reqEmail14
Dim reqPassword14
Dim reqFirst15
Dim reqLast15
Dim reqEmail15
Dim reqPassword15
Dim reqFirst16
Dim reqLast16
Dim reqEmail16
Dim reqPassword16
Dim reqFirst17
Dim reqLast17
Dim reqEmail17
Dim reqPassword17
Dim reqFirst18
Dim reqLast18
Dim reqEmail18
Dim reqPassword18
Dim reqFirst19
Dim reqLast19
Dim reqEmail19
Dim reqPassword19
Dim reqFirst20
Dim reqLast20
Dim reqEmail20
Dim reqPassword20
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
   SetCache "trialURL", reqReturnURL
   SetCache "trialDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "trial")
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
reqReferID =  Numeric(GetInput("ReferID", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqReferredBy =  GetInput("ReferredBy", reqPageData)
reqIsAgree =  Numeric(GetInput("IsAgree", reqPageData))
reqIsAgree2 =  Numeric(GetInput("IsAgree2", reqPageData))
reqComputers =  Numeric(GetInput("Computers", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqP =  Numeric(GetInput("P", reqPageData))
reqPay =  Numeric(GetInput("Pay", reqPageData))
reqProcessor =  Numeric(GetInput("Processor", reqPageData))
reqMemberToken =  Numeric(GetInput("MemberToken", reqPageData))
reqToken =  Numeric(GetInput("Token", reqPageData))
reqPayDesc =  GetInput("PayDesc", reqPageData)
reqFirst1 =  GetInput("First1", reqPageData)
reqLast1 =  GetInput("Last1", reqPageData)
reqEmail1 =  GetInput("Email1", reqPageData)
reqPassword1 =  GetInput("Password1", reqPageData)
reqFirst2 =  GetInput("First2", reqPageData)
reqLast2 =  GetInput("Last2", reqPageData)
reqEmail2 =  GetInput("Email2", reqPageData)
reqPassword2 =  GetInput("Password2", reqPageData)
reqFirst3 =  GetInput("First3", reqPageData)
reqLast3 =  GetInput("Last3", reqPageData)
reqEmail3 =  GetInput("Email3", reqPageData)
reqPassword3 =  GetInput("Password3", reqPageData)
reqFirst4 =  GetInput("First4", reqPageData)
reqLast4 =  GetInput("Last4", reqPageData)
reqEmail4 =  GetInput("Email4", reqPageData)
reqPassword4 =  GetInput("Password4", reqPageData)
reqFirst5 =  GetInput("First5", reqPageData)
reqLast5 =  GetInput("Last5", reqPageData)
reqEmail5 =  GetInput("Email5", reqPageData)
reqPassword5 =  GetInput("Password5", reqPageData)
reqFirst6 =  GetInput("First6", reqPageData)
reqLast6 =  GetInput("Last6", reqPageData)
reqEmail6 =  GetInput("Email6", reqPageData)
reqPassword6 =  GetInput("Password6", reqPageData)
reqFirst7 =  GetInput("First7", reqPageData)
reqLast7 =  GetInput("Last7", reqPageData)
reqEmail7 =  GetInput("Email7", reqPageData)
reqPassword7 =  GetInput("Password7", reqPageData)
reqFirst8 =  GetInput("First8", reqPageData)
reqLast8 =  GetInput("Last8", reqPageData)
reqEmail8 =  GetInput("Email8", reqPageData)
reqPassword8 =  GetInput("Password8", reqPageData)
reqFirst9 =  GetInput("First9", reqPageData)
reqLast9 =  GetInput("Last9", reqPageData)
reqEmail9 =  GetInput("Email9", reqPageData)
reqPassword9 =  GetInput("Password9", reqPageData)
reqFirst10 =  GetInput("First10", reqPageData)
reqLast10 =  GetInput("Last10", reqPageData)
reqEmail10 =  GetInput("Email10", reqPageData)
reqPassword10 =  GetInput("Password10", reqPageData)
reqFirst11 =  GetInput("First11", reqPageData)
reqLast11 =  GetInput("Last11", reqPageData)
reqEmail11 =  GetInput("Email11", reqPageData)
reqPassword11 =  GetInput("Password11", reqPageData)
reqFirst12 =  GetInput("First12", reqPageData)
reqLast12 =  GetInput("Last12", reqPageData)
reqEmail12 =  GetInput("Email12", reqPageData)
reqPassword12 =  GetInput("Password12", reqPageData)
reqFirst13 =  GetInput("First13", reqPageData)
reqLast13 =  GetInput("Last13", reqPageData)
reqEmail13 =  GetInput("Email13", reqPageData)
reqPassword13 =  GetInput("Password13", reqPageData)
reqFirst14 =  GetInput("First14", reqPageData)
reqLast14 =  GetInput("Last14", reqPageData)
reqEmail14 =  GetInput("Email14", reqPageData)
reqPassword14 =  GetInput("Password14", reqPageData)
reqFirst15 =  GetInput("First15", reqPageData)
reqLast15 =  GetInput("Last15", reqPageData)
reqEmail15 =  GetInput("Email15", reqPageData)
reqPassword15 =  GetInput("Password15", reqPageData)
reqFirst16 =  GetInput("First16", reqPageData)
reqLast16 =  GetInput("Last16", reqPageData)
reqEmail16 =  GetInput("Email16", reqPageData)
reqPassword16 =  GetInput("Password16", reqPageData)
reqFirst17 =  GetInput("First17", reqPageData)
reqLast17 =  GetInput("Last17", reqPageData)
reqEmail17 =  GetInput("Email17", reqPageData)
reqPassword17 =  GetInput("Password17", reqPageData)
reqFirst18 =  GetInput("First18", reqPageData)
reqLast18 =  GetInput("Last18", reqPageData)
reqEmail18 =  GetInput("Email18", reqPageData)
reqPassword18 =  GetInput("Password18", reqPageData)
reqFirst19 =  GetInput("First19", reqPageData)
reqLast19 =  GetInput("Last19", reqPageData)
reqEmail19 =  GetInput("Email19", reqPageData)
reqPassword19 =  GetInput("Password19", reqPageData)
reqFirst20 =  GetInput("First20", reqPageData)
reqLast20 =  GetInput("Last20", reqPageData)
reqEmail20 =  GetInput("Email20", reqPageData)
reqPassword20 =  GetInput("Password20", reqPageData)
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

Sub NewMember()
   On Error Resume Next
   reqPayType = 1
   reqComputers = 1

   If (reqPay <> 0) Then
      Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
      If oBilling Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
      Else
         With oBilling
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CheckAcctType = 1
            .CountryID = 224
            xmlBilling = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBilling = Nothing
   End If
   LoadLists
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

Sub LoadLists()
   On Error Resume Next
   If (reqPay <> 0) Then
      LoadCountrys
   End If

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         If (reqReferID = 5188) Then
            .Filename = "enroll5188.htm"
         End If
         If (reqReferID <> 5188) Then
            If (reqPay = 0) Then
               .Filename = "enroll2.htm"
            End If
            If (reqPay <> 0) Then
               .Filename = "enroll3.htm"
            End If
         End If
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

Sub ValidBilling()
   On Error Resume Next
   tmpPayType = Request.Form.Item("PayType")
   tmpCardNumber = Request.Form.Item("CardNumber")
   tmpCheckRoute = Request.Form.Item("CheckRoute")

   If (tmpPayType = 5) Then
      Set oPayment = server.CreateObject("wtPayment.CPayment")
      If oPayment Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtPayment.CPayment"
      Else
         With oPayment
            result = CLng(.ValidCheckRoute(tmpCheckRoute))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (result = 0) Then
               DoError 10007, "", "Oops, Invalid Check Routing Number."
            End If
         End With
      End If
      Set oPayment = Nothing
   End If

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
               .Street1 = Request.Form.Item("Street1")
               .Street2 = Request.Form.Item("Street2")
               .City = Request.Form.Item("City")
               .State = Request.Form.Item("State")
               .Zip = Request.Form.Item("Zip")
               .CountryID = Request.Form.Item("CountryID")
               If (xmlError = "") Then
                  If (reqBillingID <> 0) Then
                     .Save CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (reqBillingID = 0) Then
                     reqBillingID = CLng(.Add(CLng(reqSysUserID)))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
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
         .Load reqNewMemberID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .NameFirst = Request.Form.Item("NameFirst")
         tmpNameLast = Request.Form.Item("NameLast")
         .NameLast = Request.Form.Item("NameLast")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         If (reqNewMemberID <> 0) Then
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqNewMemberID = 0) Then
            .CompanyID = reqCompanyID
            .EnrollDate = Now
            .BillingID = reqBillingID
            .Billing = 3
            .AccessLimit = "NONE"
            .CompanyName = .NameLast + ", " + .NameFirst
            .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
            .NotifyMentor = "ABCDEF"
            .ReferralID = reqReferID
            .Level = 0
            .Title = 0
            .Process = reqComputers
            .Price = reqComputers * 5
            If (reqPay = 0) Then
               .Status = 2
               .TrialDays = 14
            End If
            If (reqPay <> 0) Then
               .TrialDays = 1
            End If
            If (reqReferID = 5188) Then
               .TrialDays = 30
               .Options2 = "MU"
               .Price = .Price + 30
            End If
            reqNewMemberID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqPay <> 0) Then
            If (xmlError = "") Then
               tmpName = .NameFirst + " " + .NameLast
               GetToken reqNewMemberID, reqBillingID, tmpName, .Email, reqProcessor, reqMemberToken, reqToken, reqPayDesc 
               If (xmlError = "") Then
                  .Reference = CSTR(reqProcessor) + "-" + CSTR(reqMemberToken)
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
            If (xmlError = "") And (reqComputers <> 0) Then
               GetPayment reqNewMemberID, .Price, reqPayType, reqPayDesc, reqProcessor, reqMemberToken, reqToken
               If (xmlError = "") Then
                  .Status = 1
                  .PaidDate = DATEADD("m", 1, reqSysDate)
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End If
         End If
      End With
   End If
   Set oMember = Nothing

   If (xmlError = "") Then
      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .MemberID = reqNewMemberID
            .Service = 1
            
         For x = 1 to reqComputers
            First = Request.Form.Item("First" + CSTR(x))
            If (Len(First) > 0) Then
               .Status = 1
               .NameFirst = First
               .NameLast = Request.Form.Item("Last" + CSTR(x))
               .Email = Request.Form.Item("Email" + CSTR(x))
               .Password = Request.Form.Item("Password" + CSTR(x))
               .WebName = "temp"
               If Len(.NameLast) = 0 Then .NameLast = tmpNameLast

               MachineID = CLng(.Add(CLng(reqSysUserID)))
               SetComputerWebName oMachine
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpStatus = .Status
               .Status = 2
               .Qty = 2

               Result = UpdateComputerStatus( oMachine, tmpStatus )
               If Result <> "OK" Then
                  DoError -1, CSTR(x), Result
                  LogMemberNote reqNewMemberID, "ENROLL COMPUTER ERROR: (" + CSTR(x) + ") " + Result 
               Else
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

   'Email Support for new computer limits
   SendEmail reqSysCompanyID, "support@CloudZow.com", "support@CloudZow.com", "limit@CloudZow.com", "", "", "NEW COMPUTER: " + .Email, .NameFirst + " " + .NameLast + " - " + .LiveDriveID + " (" + .Qty + ")"

   'Email Software Installation Instructions
   If (xmlError = "") Then
   Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
   If oHTTP Is Nothing Then
   Response.Write "Error #" & Err.number & " - " + Err.description
                     Else
                        url = "http://" + reqSysServerName + reqSysServerPath + "10708.asp?CompanyID=5&MachineID=" & MachineID
                        if reqPay > 0 Then url = url + "&pay=1"
                        oHTTP.open "GET", url
                        oHTTP.send
                     End If
                     Set oHTTP = Nothing
                  End If
               End If
            End If
         Next 

         End With
      End If
      Set oMachine = Nothing
   End If
   
         'Email Customer Welcome
         If (xmlError = "") Then
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               url = "http://" + reqSysServerName + reqSysServerPath + "10707.asp?CompanyID=5&MemberID=" & reqNewMemberID
               if reqPay > 0 Then url = url + "&pay=1"
               oHTTP.open "GET", url
               oHTTP.send
            End If
            Set oHTTP = Nothing
         End If

   If (xmlError = "") Then
      
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "0437.asp?Customer=1&MemberID=" & reqNewMemberID
               oHTTP.send
            End If
            Set oHTTP = Nothing

   End If

   If (xmlError = "") And (reqPay <> 0) Then
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
End Sub

Sub LoadMember()
   On Error Resume Next
   LoadLists

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
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         xmlMember = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oMember = Nothing

   Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
   If oBilling Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
   Else
      With oBilling
         .SysCurrentLanguage = reqSysLanguage
         .Load reqBillingID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .CardNumber = Request.Form.Item("CardNumber")
         .CardMo = Request.Form.Item("CardMo")
         .CardYr = Request.Form.Item("CardYr")
         .CardName = Request.Form.Item("CardName")
         .CardCode = Request.Form.Item("CardCode")
         .Street1 = Request.Form.Item("Street1")
         .Street2 = Request.Form.Item("Street2")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .CountryID = Request.Form.Item("CountryID")
         xmlBilling = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBilling = Nothing
End Sub

reqCompanyID = 5
reqSysCompanyID = 5
SetCache "COMPANYID", reqSysCompanyID
If (reqM = 0) Then
   reqM = GetCache("A")
End If
If (reqM = "") Then
   reqM = 0
End If
If (reqP <> 0) Then
   reqPay = reqP
End If
reqMemberID = reqM
reqReferID = reqM
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      NewMember

   Case CLng(cActionAdd):
      If (reqIsAgree = 0) Then
         DoError 10103, "", "Oops, You must agree to the terms and conditions."
      End If
      If (xmlError = "") Then
         LoadCompanyOptions
      End If
      tmpNameFirst = Request.Form.Item("NameFirst")
      tmpNameLast = Request.Form.Item("NameLast")
      tmpEmail = Request.Form.Item("Email")
      If (xmlError = "") And (tmpNameFirst = "") Then
         DoError 10125, "", "Oops, Please enter a First Name."
      End If
      If (xmlError = "") And (tmpNameLast = "") Then
         DoError 10126, "", "Oops, Please enter a Last Name."
      End If
      If (xmlError = "") And (Len(tmpEmail) < 6) Then
         DoError 10124, "", "Oops, Please enter at least 6 characters for the Password."
      End If
      If (xmlError = "") And (reqFirst1 = "") Then
         DoError 10131, "", "Oops, Please enter at least one personal computer."
      End If

      If (xmlError = "") Then
         Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
         If oMachine Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
         Else
            With oMachine
               .SysCurrentLanguage = reqSysLanguage
               
         For x = 1 to reqComputers
            First = Request.Form.Item("First" + CSTR(x))
            If (Len(First) > 0) Then
               Email = Request.Form.Item("Email" + CSTR(x))
               Password = Request.Form.Item("Password" + CSTR(x))

               If (xmlError = "") Then
                  .FetchEmail Email
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (CLng(.MachineID) <> 0) Then
                     DoError 10123, CSTR(x), "Oops, This email address is already assigned to another computer."
                  End If
               End If
               If (xmlError = "") Then
                  If (LEN(Password) < 6) Then
                     DoError 10124, CSTR(x), "Oops, Please enter at least 6 characters for the Password."
                  End If
               End If
               If (xmlError <> "") Then x = 21
            End If
         Next

            End With
         End If
         Set oMachine = Nothing
      End If
      If (xmlError = "") And (reqPay <> 0) And (reqIsAgree2 = 0) Then
         DoError 10128, "", "Oops, You must agree to be billed monthly."
      End If
      If (xmlError = "") And (reqPay <> 0) Then
         ValidBilling
      End If
      If (xmlError = "") Then
         Addmember
      End If
      If (xmlError <> "") Then
         LoadMember
      End If
      If (xmlError = "") Then
         SetCache "CUSTOMER", reqNewMemberID

         Response.Redirect "10711.asp" & "?MemberID=" & reqNewMemberID
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " newmemberid=" + Chr(34) + CStr(reqNewMemberID) + Chr(34)
xmlParam = xmlParam + " billingid=" + Chr(34) + CStr(reqBillingID) + Chr(34)
xmlParam = xmlParam + " referid=" + Chr(34) + CStr(reqReferID) + Chr(34)
xmlParam = xmlParam + " paytype=" + Chr(34) + CStr(reqPayType) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " isagree=" + Chr(34) + CStr(reqIsAgree) + Chr(34)
xmlParam = xmlParam + " isagree2=" + Chr(34) + CStr(reqIsAgree2) + Chr(34)
xmlParam = xmlParam + " computers=" + Chr(34) + CStr(reqComputers) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " p=" + Chr(34) + CStr(reqP) + Chr(34)
xmlParam = xmlParam + " pay=" + Chr(34) + CStr(reqPay) + Chr(34)
xmlParam = xmlParam + " processor=" + Chr(34) + CStr(reqProcessor) + Chr(34)
xmlParam = xmlParam + " membertoken=" + Chr(34) + CStr(reqMemberToken) + Chr(34)
xmlParam = xmlParam + " token=" + Chr(34) + CStr(reqToken) + Chr(34)
xmlParam = xmlParam + " paydesc=" + Chr(34) + CleanXML(reqPayDesc) + Chr(34)
xmlParam = xmlParam + " first1=" + Chr(34) + CleanXML(reqFirst1) + Chr(34)
xmlParam = xmlParam + " last1=" + Chr(34) + CleanXML(reqLast1) + Chr(34)
xmlParam = xmlParam + " email1=" + Chr(34) + CleanXML(reqEmail1) + Chr(34)
xmlParam = xmlParam + " password1=" + Chr(34) + CleanXML(reqPassword1) + Chr(34)
xmlParam = xmlParam + " first2=" + Chr(34) + CleanXML(reqFirst2) + Chr(34)
xmlParam = xmlParam + " last2=" + Chr(34) + CleanXML(reqLast2) + Chr(34)
xmlParam = xmlParam + " email2=" + Chr(34) + CleanXML(reqEmail2) + Chr(34)
xmlParam = xmlParam + " password2=" + Chr(34) + CleanXML(reqPassword2) + Chr(34)
xmlParam = xmlParam + " first3=" + Chr(34) + CleanXML(reqFirst3) + Chr(34)
xmlParam = xmlParam + " last3=" + Chr(34) + CleanXML(reqLast3) + Chr(34)
xmlParam = xmlParam + " email3=" + Chr(34) + CleanXML(reqEmail3) + Chr(34)
xmlParam = xmlParam + " password3=" + Chr(34) + CleanXML(reqPassword3) + Chr(34)
xmlParam = xmlParam + " first4=" + Chr(34) + CleanXML(reqFirst4) + Chr(34)
xmlParam = xmlParam + " last4=" + Chr(34) + CleanXML(reqLast4) + Chr(34)
xmlParam = xmlParam + " email4=" + Chr(34) + CleanXML(reqEmail4) + Chr(34)
xmlParam = xmlParam + " password4=" + Chr(34) + CleanXML(reqPassword4) + Chr(34)
xmlParam = xmlParam + " first5=" + Chr(34) + CleanXML(reqFirst5) + Chr(34)
xmlParam = xmlParam + " last5=" + Chr(34) + CleanXML(reqLast5) + Chr(34)
xmlParam = xmlParam + " email5=" + Chr(34) + CleanXML(reqEmail5) + Chr(34)
xmlParam = xmlParam + " password5=" + Chr(34) + CleanXML(reqPassword5) + Chr(34)
xmlParam = xmlParam + " first6=" + Chr(34) + CleanXML(reqFirst6) + Chr(34)
xmlParam = xmlParam + " last6=" + Chr(34) + CleanXML(reqLast6) + Chr(34)
xmlParam = xmlParam + " email6=" + Chr(34) + CleanXML(reqEmail6) + Chr(34)
xmlParam = xmlParam + " password6=" + Chr(34) + CleanXML(reqPassword6) + Chr(34)
xmlParam = xmlParam + " first7=" + Chr(34) + CleanXML(reqFirst7) + Chr(34)
xmlParam = xmlParam + " last7=" + Chr(34) + CleanXML(reqLast7) + Chr(34)
xmlParam = xmlParam + " email7=" + Chr(34) + CleanXML(reqEmail7) + Chr(34)
xmlParam = xmlParam + " password7=" + Chr(34) + CleanXML(reqPassword7) + Chr(34)
xmlParam = xmlParam + " first8=" + Chr(34) + CleanXML(reqFirst8) + Chr(34)
xmlParam = xmlParam + " last8=" + Chr(34) + CleanXML(reqLast8) + Chr(34)
xmlParam = xmlParam + " email8=" + Chr(34) + CleanXML(reqEmail8) + Chr(34)
xmlParam = xmlParam + " password8=" + Chr(34) + CleanXML(reqPassword8) + Chr(34)
xmlParam = xmlParam + " first9=" + Chr(34) + CleanXML(reqFirst9) + Chr(34)
xmlParam = xmlParam + " last9=" + Chr(34) + CleanXML(reqLast9) + Chr(34)
xmlParam = xmlParam + " email9=" + Chr(34) + CleanXML(reqEmail9) + Chr(34)
xmlParam = xmlParam + " password9=" + Chr(34) + CleanXML(reqPassword9) + Chr(34)
xmlParam = xmlParam + " first10=" + Chr(34) + CleanXML(reqFirst10) + Chr(34)
xmlParam = xmlParam + " last10=" + Chr(34) + CleanXML(reqLast10) + Chr(34)
xmlParam = xmlParam + " email10=" + Chr(34) + CleanXML(reqEmail10) + Chr(34)
xmlParam = xmlParam + " password10=" + Chr(34) + CleanXML(reqPassword10) + Chr(34)
xmlParam = xmlParam + " first11=" + Chr(34) + CleanXML(reqFirst11) + Chr(34)
xmlParam = xmlParam + " last11=" + Chr(34) + CleanXML(reqLast11) + Chr(34)
xmlParam = xmlParam + " email11=" + Chr(34) + CleanXML(reqEmail11) + Chr(34)
xmlParam = xmlParam + " password11=" + Chr(34) + CleanXML(reqPassword11) + Chr(34)
xmlParam = xmlParam + " first12=" + Chr(34) + CleanXML(reqFirst12) + Chr(34)
xmlParam = xmlParam + " last12=" + Chr(34) + CleanXML(reqLast12) + Chr(34)
xmlParam = xmlParam + " email12=" + Chr(34) + CleanXML(reqEmail12) + Chr(34)
xmlParam = xmlParam + " password12=" + Chr(34) + CleanXML(reqPassword12) + Chr(34)
xmlParam = xmlParam + " first13=" + Chr(34) + CleanXML(reqFirst13) + Chr(34)
xmlParam = xmlParam + " last13=" + Chr(34) + CleanXML(reqLast13) + Chr(34)
xmlParam = xmlParam + " email13=" + Chr(34) + CleanXML(reqEmail13) + Chr(34)
xmlParam = xmlParam + " password13=" + Chr(34) + CleanXML(reqPassword13) + Chr(34)
xmlParam = xmlParam + " first14=" + Chr(34) + CleanXML(reqFirst14) + Chr(34)
xmlParam = xmlParam + " last14=" + Chr(34) + CleanXML(reqLast14) + Chr(34)
xmlParam = xmlParam + " email14=" + Chr(34) + CleanXML(reqEmail14) + Chr(34)
xmlParam = xmlParam + " password14=" + Chr(34) + CleanXML(reqPassword14) + Chr(34)
xmlParam = xmlParam + " first15=" + Chr(34) + CleanXML(reqFirst15) + Chr(34)
xmlParam = xmlParam + " last15=" + Chr(34) + CleanXML(reqLast15) + Chr(34)
xmlParam = xmlParam + " email15=" + Chr(34) + CleanXML(reqEmail15) + Chr(34)
xmlParam = xmlParam + " password15=" + Chr(34) + CleanXML(reqPassword15) + Chr(34)
xmlParam = xmlParam + " first16=" + Chr(34) + CleanXML(reqFirst16) + Chr(34)
xmlParam = xmlParam + " last16=" + Chr(34) + CleanXML(reqLast16) + Chr(34)
xmlParam = xmlParam + " email16=" + Chr(34) + CleanXML(reqEmail16) + Chr(34)
xmlParam = xmlParam + " password16=" + Chr(34) + CleanXML(reqPassword16) + Chr(34)
xmlParam = xmlParam + " first17=" + Chr(34) + CleanXML(reqFirst17) + Chr(34)
xmlParam = xmlParam + " last17=" + Chr(34) + CleanXML(reqLast17) + Chr(34)
xmlParam = xmlParam + " email17=" + Chr(34) + CleanXML(reqEmail17) + Chr(34)
xmlParam = xmlParam + " password17=" + Chr(34) + CleanXML(reqPassword17) + Chr(34)
xmlParam = xmlParam + " first18=" + Chr(34) + CleanXML(reqFirst18) + Chr(34)
xmlParam = xmlParam + " last18=" + Chr(34) + CleanXML(reqLast18) + Chr(34)
xmlParam = xmlParam + " email18=" + Chr(34) + CleanXML(reqEmail18) + Chr(34)
xmlParam = xmlParam + " password18=" + Chr(34) + CleanXML(reqPassword18) + Chr(34)
xmlParam = xmlParam + " first19=" + Chr(34) + CleanXML(reqFirst19) + Chr(34)
xmlParam = xmlParam + " last19=" + Chr(34) + CleanXML(reqLast19) + Chr(34)
xmlParam = xmlParam + " email19=" + Chr(34) + CleanXML(reqEmail19) + Chr(34)
xmlParam = xmlParam + " password19=" + Chr(34) + CleanXML(reqPassword19) + Chr(34)
xmlParam = xmlParam + " first20=" + Chr(34) + CleanXML(reqFirst20) + Chr(34)
xmlParam = xmlParam + " last20=" + Chr(34) + CleanXML(reqLast20) + Chr(34)
xmlParam = xmlParam + " email20=" + Chr(34) + CleanXML(reqEmail20) + Chr(34)
xmlParam = xmlParam + " password20=" + Chr(34) + CleanXML(reqPassword20) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlBilling
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlPayment
xmlTransaction = xmlTransaction +  xmlMachine
xmlTransaction = xmlTransaction +  xmlCloudZow
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\trial[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\trial[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "trial Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "trial Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "trial Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "trial.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "trial Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "trial Load file (oData) failed with error code " + CStr(oData.parseError)
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