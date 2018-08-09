<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
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
Dim oAuthUser, xmlAuthUser
Dim oProspect, xmlProspect
Dim oMember, xmlMember
Dim oCompany, xmlCompany
Dim oMail, xmlMail
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqOwnerType
Dim reqOwnerID
Dim reqMemberID
Dim reqCompanyID
Dim reqTemplateID
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
   SetCache "0502aURL", reqReturnURL
   SetCache "0502aDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0502a")
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
reqOwnerType =  Numeric(GetInput("OwnerType", reqPageData))
reqOwnerID =  Numeric(GetInput("OwnerID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqTemplateID =  Numeric(GetInput("TemplateID", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      If (reqSysUserID <> 0) Then
         Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
         If oAuthUser Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
         Else
            With oAuthUser
               .AuthUserID = reqSysUserID
               .Load CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpFrom = .Email
            End With
         End If
         Set oAuthUser = Nothing
      End If

      If (reqOwnerType = 22) Or (reqOwnerType = 81) Or (reqOwnerType = -81) Then
         Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
         If oProspect Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
         Else
            With oProspect
               .Load CLng(reqOwnerID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpCompanyID = .CompanyID
               tmpTo = .Email
               tmpID = .ProspectID
               tmpName = .ProspectName
               tmpStreet = .Street + " " + .Unit
               tmpCity = .City
               tmpState = .State
               tmpZip = .Zip
               tmpCountry = .Country
               tmpFirstName = .NameFirst
               tmpLastName = .NameLast
               tmpEmail = .Email
               tmpPhone = .Phone1
               tmpSource = .Source
               If (.NextEvent <> 0) Then
                  tmpEvent = .NextDate + " " + .NextTime
               End If
            End With
         End If
         Set oProspect = Nothing
      End If

      If (reqMemberID <> 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .Load CLng(reqMemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpSignature = .Signature
               tmpMID = .MemberID
               tmpMFirstName = .NameFirst
               tmpMLastName = .NameLast
               tmpMEmail = .Email
               tmpMPhone = .Phone1
               If (reqOwnerType = 22) Then
                  tmpUseType = 4
               End If
               If (reqOwnerType = 81) Then
                  tmpUseType = 5
               End If
               If (reqOwnerType = -81) Then
                  tmpUseType = 6
               End If
               Signature = .GetSignature(CLng(reqMemberID), tmpUseType, 0, reqSysLanguage)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (Signature <> "") Then
                  tmpSignature = Signature
               End If
            End With
         End If
         Set oMember = Nothing
      End If
      tmpSubject = ""

      Set oPage = server.CreateObject("ptsPageUser.CPage")
      If oPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPage"
      Else
         With oPage
            .Load reqTemplateID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSubject = .PageName
         End With
      End If
      Set oPage = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = reqTemplateID & ".htm"
            .Path = reqSysWebDirectory + "Pages\"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpBody = .Data
            
                     tmpSubject = Replace( tmpSubject, "{firstname}", tmpFirstName )
                     tmpSubject = Replace( tmpSubject, "{lastname}", tmpLastName )

                     tmpBody = Replace( tmpBody, "{signature}", tmpSignature )
                     tmpBody = Replace( tmpBody, "{companyname}", tmpName )
                     tmpBody = Replace( tmpBody, "{street}", tmpStreet )
                     tmpBody = Replace( tmpBody, "{city}", tmpCity )
                     tmpBody = Replace( tmpBody, "{state}", tmpState )
                     tmpBody = Replace( tmpBody, "{zip}", tmpZip )
                     tmpBody = Replace( tmpBody, "{country}", tmpCountry )
                     tmpBody = Replace( tmpBody, "{firstname}", tmpFirstName )
                     tmpBody = Replace( tmpBody, "{lastname}", tmpLastName )
                     tmpBody = Replace( tmpBody, "{email}", tmpEmail )
                     tmpBody = Replace( tmpBody, "{phone}", tmpPhone )
                     tmpBody = Replace( tmpBody, "{source}", tmpSource )
                     tmpBody = Replace( tmpBody, "{id}", tmpID )
                     tmpBody = Replace( tmpBody, "{event}", tmpEvent )
                     tmpBody = Replace( tmpBody, "{m-firstname}", tmpMFirstName )
                     tmpBody = Replace( tmpBody, "{m-lastname}", tmpMLastName )
                     tmpBody = Replace( tmpBody, "{m-email}", tmpMEmail )
                     tmpBody = Replace( tmpBody, "{m-phone}", tmpMPhone )
                     tmpBody = Replace( tmpBody, "{m-id}", tmpMID )
                  
         End With
      End If
      Set oHTMLFile = Nothing

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .Load reqCompanyID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .Email
         End With
      End If
      Set oCompany = Nothing
      SendEmail reqCompanyid, tmpSender, tmpFrom, tmpTo, tmpCC, tmpBCC, tmpSubject, tmpBody

      Set oMail = server.CreateObject("ptsMailUser.CMail")
      If oMail Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMailUser.CMail"
      Else
         With oMail
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = reqOwnerType
            .OwnerID = reqOwnerID
            .MemberID = reqMemberID
            .MailDate = Now
            .MailFrom = tmpFrom
            .MailTo = tmpTo
            .Subject = tmpSubject
            MailID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMail = Nothing

      If (xmlError = "") Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .FileName = "Mail" & MailID & ".htm"
               .Path = reqSysWebDirectory + "Sections\Company\" & reqCompanyID & "\Mail\"
               .Language = "en"
               .Project = SysProject
               .Data = tmpBody
               .Save 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If
End Select

%>