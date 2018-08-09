<!--#include file="Include\System.asp"-->
<!--#include file="Include\MarketMerchants.asp"-->
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
Dim oMarket, xmlMarket
Dim oHTMLFile, xmlHTMLFile
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqMarketID
Dim reqCompanyID
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
   SetCache "18206URL", reqReturnURL
   SetCache "18206DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "18206")
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
reqMarketID =  Numeric(GetInput("MarketID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


If (reqMarketID = 0) Then
   Response.Write "Missing MarketID"
End If
If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      'Insure that the first test for a valid email passes
      tmpTo = "@"

      Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
      If oMarket Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
      Else
         With oMarket
            .Load CLng(reqMarketID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            tmpFrom = .FromEmail
            tmpSubject = .Subject
            tmpTarget = .Target
            tmpCountryID = .CountryID
            xmlMarket = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMarket = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .FileName = reqMarketID
            .Path = reqSysWebDirectory + "Sections/Company/" & reqCompanyID & "/Market/"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpBody = .Data
         End With
      End If
      Set oHTMLFile = Nothing

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .Load CLng(reqCompanyID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .Email3
         End With
      End If
      Set oCompany = Nothing
      
          GetMerchants tmpTarget, tmpCountryID, tmpFeatured, tmpNew, tmpMerchants, tmpOrgs
          tmpBody = Replace( tmpBody, "{featured-merchants}", tmpFeatured )
          tmpBody = Replace( tmpBody, "{new-merchants}", tmpNew )
          tmpBody = Replace( tmpBody, "{orgs}", tmpOrgs )
          tmpBody = Replace( tmpBody, "{merchants}", tmpMerchants )

          tmpMasterSubject = tmpSubject
          tmpMasterBody = tmpBody
          tmpCount = 0

          If InStr(tmpFrom, "@")=0 Then tmpFrom = ""
          If tmpFrom <> "" Then
          Set oMail = server.CreateObject("CDO.Message")
          If oMail Is Nothing Then Response.Write "Unable to Create Object - CDO.Message"
          With oMail
          .Sender = tmpSender
          .From = tmpFrom
          End With

          Set oConsumers = server.CreateObject("ptsConsumerUser.CConsumers")
          If oConsumers Is Nothing Then
          DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumers"
          Else
          With oConsumers
          .SysCurrentLanguage = reqSysLanguage
          .ListMarketEmail reqCompanyID, tmpTarget, tmpCountryID
          If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description

          For Each oConsumer in oConsumers
          With oConsumer
          tmpTo = .Email
          tmpSubject = Replace( tmpMasterSubject, "{firstname}", .NameFirst )
          tmpSubject = Replace( tmpSubject, "{lastname}", .NameLast )
          tmpBody = Replace( tmpMasterBody, "{firstname}", .NameFirst )
          tmpBody = Replace( tmpBody, "{lastname}", .NameLast )
          tmpBody = Replace( tmpBody, "{id}", .ConsumerID )
          tmpBody = Replace( tmpBody, "{email}", tmpTo )
          tmpBody = Replace( tmpBody, "{memberid}", .MemberID )
          End With
          If InStr(tmpTo, "@") > 0 Then
                              tmpCount = tmpCount + 1
                              With oMail
                                 .To = tmpTo
                                 .Subject = tmpSubject
                                 .HTMLBody = tmpBody
                                 .Send
                              End With
                           End If
                        Next
                     End With
                  End If   
                  Set oConsumers = Nothing
                  Set oMail = Nothing
               End If
            

      Set oMarket = server.CreateObject("ptsMarketUser.CMarket")
      If oMarket Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMarketUser.CMarket"
      Else
         With oMarket
            .Load CLng(reqMarketID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .SendDate = SendDays, .SendDate)
            .Save 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMarket = Nothing
End Select

%>