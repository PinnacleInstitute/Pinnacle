<!--#include file="Include\System.asp"-->
<!--#include file="Include\Wallet.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----system variables
Dim reqActionCode
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGA_ACCTID, reqSysGA_DOMAIN
'-----object variables
Dim oCompany, xmlCompany
Dim oCoption, xmlCoption
Dim oBilling, xmlBilling
Dim oMember, xmlMember
Dim oAddress, xmlAddress
'-----declare page parameters
Dim reqC
Dim reqR
Dim reqFirst
Dim reqLast
Dim reqEmail
Dim reqStatus
Dim reqLevel
Dim reqGroupID
Dim reqRole
Dim reqSecure
Dim reqBilling
Dim reqLogon
Dim reqTT
Dim reqTI
Dim reqCN
Dim reqP1
Dim reqP2
Dim reqP3
Dim reqLG
Dim reqPW
Dim reqSponsor
Dim reqRefer
Dim reqMentor
Dim reqSponsorID
Dim reqReferralID
Dim reqMentorID
Dim reqPayID
Dim reqPayType
Dim reqStreet1
Dim reqStreet2
Dim reqCity
Dim reqState
Dim reqZip
Dim reqCountryID
Dim reqPrice
Dim reqiPrice
Dim reqTitle
Dim reqOptions2
On Error Resume Next

'-----Call Common System Function
CommonSystem()

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   xmlError = bvErrorMsg
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "0422URL", reqReturnURL
   SetCache "0422DATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
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
pos = InStr(LCASE(reqSysServerPath), "0422")
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
reqC =  Numeric(GetInput("C", reqPageData))
reqR =  GetInput("R", reqPageData)
reqFirst =  GetInput("First", reqPageData)
reqLast =  GetInput("Last", reqPageData)
reqEmail =  GetInput("Email", reqPageData)
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqGroupID =  Numeric(GetInput("GroupID", reqPageData))
reqRole =  GetInput("Role", reqPageData)
reqSecure =  GetInput("Secure", reqPageData)
reqBilling =  GetInput("Billing", reqPageData)
reqLogon =  Numeric(GetInput("Logon", reqPageData))
reqTT =  Numeric(GetInput("TT", reqPageData))
reqTI =  GetInput("TI", reqPageData)
reqCN =  GetInput("CN", reqPageData)
reqP1 =  GetInput("P1", reqPageData)
reqP2 =  GetInput("P2", reqPageData)
reqP3 =  GetInput("P3", reqPageData)
reqLG =  GetInput("LG", reqPageData)
reqPW =  GetInput("PW", reqPageData)
reqSponsor =  GetInput("Sponsor", reqPageData)
reqRefer =  GetInput("Refer", reqPageData)
reqMentor =  GetInput("Mentor", reqPageData)
reqSponsorID =  Numeric(GetInput("SponsorID", reqPageData))
reqReferralID =  Numeric(GetInput("ReferralID", reqPageData))
reqMentorID =  Numeric(GetInput("MentorID", reqPageData))
reqPayID =  Numeric(GetInput("PayID", reqPageData))
reqPayType =  Numeric(GetInput("PayType", reqPageData))
reqStreet1 =  GetInput("Street1", reqPageData)
reqStreet2 =  GetInput("Street2", reqPageData)
reqCity =  GetInput("City", reqPageData)
reqState =  GetInput("State", reqPageData)
reqZip =  GetInput("Zip", reqPageData)
reqCountryID =  Numeric(GetInput("CountryID", reqPageData))
reqPrice =  GetInput("Price", reqPageData)
reqiPrice =  GetInput("iPrice", reqPageData)
reqTitle =  Numeric(GetInput("Title", reqPageData))
reqOptions2 =  GetInput("Options2", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LogFile "0422", Request.QueryString
      
   If reqStatus < 0 OR reqStatus > 5 Then reqStatus = 1
   If reqLevel < 0 OR reqLevel > 3 Then reqLevel = 1
   If reqC = 0 Then
      LogFile "0422", "Error - Missing Company"
      response.write "Error - Missing Company"
      response.end
   End If
   If Len(reqFirst) = 0 Then
      LogFile "0422", "Error - Missing First Name"
      response.write "Error - Missing First Name"
      response.end
   End If
   If Len(reqLast) = 0 Then
      LogFile "0422", "Error - Missing Last Name"
      response.write "Error - Missing Last Name"
      response.end
   End If
   If Len(reqEmail) = 0 Then
      LogFile "0422", "Error - Missing Email Address"
      response.write "Error - Missing Email Address"
      response.end
   End If
   If Len(reqEmail) > 80 Then
      LogFile "0422", "Error - Email Address Too Long (80 max.)"
      response.write "Error - Email Address Too Long (80 max.)"
      response.end
   End If
   If Len(reqR) > 15 Then
      LogFile "0422", "Error - Reference # Too Long (15 max.)"
      response.write "Error - Reference # Too Long (15 max.)"
      response.end
   End If

      MemberID = 0

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .Load reqC, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   If .Status <> "2" Then
      LogFile "0422", "Error - Inactive Company"
      response.write "Error - Inactive Company"
      response.end
   End If

         End With
      End If
      Set oCompany = Nothing

      Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
      If oCoption Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
      Else
         With oCoption
            .FetchCompany reqC
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Load .CoptionID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpWalletType = .WalletType
            tmpWalletAcct = .WalletAcct
            If (reqPrice = 0) Then
               If (reqLevel = 0) Or (reqLevel = 1) Then
                  tmpPrice = .Price
                  tmpRetail = .Retail
               End If
               If (reqLevel = 2) Then
                  tmpPrice = .Price2
                  tmpRetail = .Retail2
               End If
               If (reqLevel = 3) Then
                  tmpPrice = .Price3
                  tmpRetail = .Retail3
               End If
            End If
            If (reqPrice <> 0) Then
               If (reqCountryID = 0) Or (reqCountryID = 224) Then
                  tmpPrice = reqPrice
                  tmpRetail = 0
               End If
               If (reqCountryID <> 0) And (reqCountryID <> 224) Then
                  If (reqiPrice <> 0) Then
                     tmpPrice = reqiPrice
                  End If
                  If (reqiPrice = 0) Then
                     tmpPrice = reqPrice
                  End If
                  tmpRetail = 0
               End If
            End If
            tmpInitPrice = .InitPrice
            tmpBilling = .Billing
            tmpDiscount = .Discount
            tmpIsDiscount = .IsDiscount
            tmpPromoID = .PromoCode
            tmpAccessLimit = .AccessLimit
            tmpQuizLimit = .QuizLimit
            tmpMemberLimit = .MemberLimit
            tmpTrialDays = .TrialDays
            tmpIsNewEmail = .IsNewEmail
            If (reqLevel = 0) Then
               tmpOptions = .FreeOptions
            End If
            If (reqLevel = 1) Then
               tmpOptions = .Options
            End If
            If (reqLevel = 2) Then
               tmpOptions = .Options2
            End If
            If (reqLevel = 3) Then
               tmpOptions = .Options3
            End If
         End With
      End If
      Set oCoption = Nothing
      If (reqPayType = 0) And (reqCountryID <> 0) Then
         tmpPayQuicker = PayQuickerCountry( reqCountryID )
         If (tmpPayQuicker <> 0) Then
            reqPayType = 12
         End If
         If (tmpPayQuicker = 0) Then
            reqPayType = 11
         End If
      End If

      If (reqPayType <> 0) Then
         Set oBilling = server.CreateObject("ptsBillingUser.CBilling")
         If oBilling Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBillingUser.CBilling"
         Else
            With oBilling
               .Load CLng(reqPayID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (reqPayType = 3) Then
                  .CommType = 3
               End If
               If (reqPayType = 12) Then
                  .CommType = 4
                  .CardType = 12
                  .CardName = Request.Form.Item("Email")
               End If
               If (reqPayType = 11) Then
                  .CommType = 4
                  .CardType = 11
                  If (tmpWalletType = 11) And (reqLG <> "") And (reqFirst <> "") And (reqLast <> "") And (reqEmail <> "") Then
                     
                        result = iPayout_RegisterUser( tmpWalletAcct, reqLG, reqFirst, reqLast, reqEmail )
                        If result = "" Then .CardName = reqLG
                     
                  End If
               End If
               tmpNameFirst = reqFirst
               tmpNameLast = reqLast
               .BillingName = tmpNameFirst + " " + tmpNameLast
               .Street1 = reqStreet1
               .Street2 = reqStreet2
               .City = reqCity
               .State = reqState
               .Zip = reqZip
               .CountryID = reqCountryID
               reqPayID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oBilling = Nothing
      End If

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            If (reqRefer <> "") Then
               .FetchRef reqC, reqRefer
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then
                  reqReferralID = .MemberID
               End If
               If (.MemberID = 0) Then
                  
                        LogFile "0422", "Error - Invalid Refer Reference Number"
                        response.write "Error - Invalid Refer Reference Number"
                        response.end
                     
               End If
            End If
            If (reqMentor = reqRefer) Or (reqMentor = "") Then
               reqMentorID = reqReferralID
            End If
            If (reqSponsor = reqRefer) Or (reqSponsor = "") Then
               reqSponsorID = reqReferralID
            End If
            If (reqSponsor <> "") And (reqSponsorID = 0) Then
               .FetchRef reqC, reqSponsor
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then
                  reqSponsorID = .MemberID
               End If
               If (.MemberID = 0) Then
                  
   LogFile "0422", "Error - Invalid Sponsor Reference Number"
   response.write "Error - Invalid Sponsor Reference Number"
   response.end

               End If
            End If
            If (reqMentor <> "") And (reqMentorID = 0) Then
               .FetchRef reqC, reqMentor
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then
                  reqMentorID = .MemberID
               End If
               If (.MemberID = 0) Then
                  
   LogFile "0422", "Error - Invalid Mentor Reference Number"
   response.write "Error - Invalid Mentor Reference Number"
   response.end

               End If
            End If
            If (reqR <> "") Then
               .FetchRef reqC, reqR
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then

                  If (reqLogon <> 0) Then
                     Response.Redirect "0105.asp" & "?AuthUserID=" & .AuthUserID
                  End If
                  If (reqLogon = 0) Then
                     
   LogFile "0422", "Error - Existing Member Reference Number"
   response.write "Error - Existing Member Reference Number"
   response.end

                  End If
               End If
            End If
            If (InStr(tmpOptions,"k") = 0) Then
               MemberID = CLng(.ExistEmail(reqC, reqEmail))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (MemberID > 0) Then
                  If (reqLogon <> 0) Then
                     .Load MemberID, CLng(reqSysUserID)
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

                     Response.Redirect "0105.asp" & "?AuthUserID=" & .AuthUserID
                  End If
                  If (reqLogon = 0) Then
                     
   LogFile "0422", "Error - Existing Email Address"
   response.write "Error - Existing Email Address"
   response.end

                  End If
               End If
            End If
         End With
      End If
      Set oMember = Nothing

      If (MemberID = 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .EnrollDate = Now
               .UserStatus = 1
               .UserGroup = 41
               .Qualify = 2
               .PayID = reqPayID
               .CompanyID = reqC
               .Status = reqStatus
               .Level = reqLevel
               .NameFirst = reqFirst
               .NameLast = reqLast
               .Email = reqEmail
               .Reference = reqR
               .Referral = reqRefer
               .GroupID = reqGroupID
               .Role = reqRole
               .Secure = reqSecure
               .MentorID = reqMentorID
               .ReferralID = reqReferralID
               .SponsorID = reqSponsorID
               .TaxIDType = reqTT
               .TaxID = reqTI
               .Phone1 = reqP1
               .Phone2 = reqP2
               .Fax = reqP3
               .NewLogon = reqLG
               .NewPassword = reqPW
               .Title = reqTitle
               .Options2 = reqOptions2
               If (reqCN <> "") Then
                  .CompanyName = reqCN
                  .IsCompany = 1
               End If
               If (reqCN = "") Then
                  .CompanyName = .NameLast + ", " + .NameFirst
               End If
               
.CompanyName = Left(.CompanyName, 60)
.NameFirst = Left(.NameFirst, 30)
.NameLast = Left(.NameLast, 30)

               If (reqBilling = "") Then
                  .Billing = tmpBilling
               End If
               If (reqBilling <> "") Then
                  .Billing = reqBilling
               End If
               .Price = tmpPrice
               .InitPrice = tmpInitPrice
               .Retail = tmpRetail
               .Discount = tmpDiscount
               .IsDiscount = tmpIsDiscount
               .PromoID = tmpPromoID
               .AccessLimit = tmpAccessLimit
               .QuizLimit = tmpQuizLimit
               If (reqStatus = 2) Then
                  .TrialDays = tmpTrialDays
                  .PaidDate = DATEADD("d", tmpTrialDays, reqSysDate)
               End If
               .Signature = .NameFirst + " " + .NameLast + "<BR>" + .Email + "<BR>" + .Phone1
               .NotifyMentor = "ABCDEFG"
               NewMemberID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (xmlError = "") And (.Title <> 0) Then

                  Set oMemberTitle = server.CreateObject("ptsMemberTitleUser.CMemberTitle")
                  If oMemberTitle Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitle"
                  Else
                     With oMemberTitle
                        .MemberID = NewMemberID
                        .TitleDate = Now
                        .Title = oMember.Title
                        .Add CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     End With
                  End If
                  Set oMemberTitle = Nothing
               End If
               If (.AuthUserID <> 0) And (tmpIsNewEmail <> 0) Then
                  Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
                  If oHTTP Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
                  Else
                     tmpServer = "http://" + reqSysServerName + reqSysServerPath
                     oHTTP.open "GET", tmpServer + "0105.asp" & "?AuthUserID=" & .AuthUserID
                     oHTTP.send
                  End If
                  Set oHTTP = Nothing
               End If
            End With
         End If
         Set oMember = Nothing
      End If

      If (xmlError = "") And (NewMemberID <> 0) And (reqStreet1 <> "") Then
         Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
         If oAddress Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
         Else
            With oAddress
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .OwnerType = 04
               .OwnerID = NewMemberID
               .AddressType = 2
               .IsActive = 1
               .Street1 = reqStreet1
               .Street2 = reqStreet2
               .City = reqCity
               .State = reqState
               .Zip = reqZip
               .CountryID = reqCountryID
               tmpAddressID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAddress = Nothing
      End If
      If (xmlError = "") Then

         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               Count = CLng(.Custom(reqC, 100, 0, NewMemberID, 0))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
      End If
      
   If Len(xmlError) = 0 Then
      response.write NewMemberID
   Else
      LogFile "0422", "Error - " + xmlError
      response.write "Error - " + xmlError
   End If
   response.end

End Select

%>