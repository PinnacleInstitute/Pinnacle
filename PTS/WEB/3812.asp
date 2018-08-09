<!--#include file="Include\System.asp"-->
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
Dim oOrg, xmlOrg
Dim oHTMLFile, xmlHTMLFile
Dim oPageSection, xmlPageSection
'-----declare page parameters
Dim reqName
Dim reqLast
Dim reqFirst
Dim reqStreet
Dim reqUnit
Dim reqCity
Dim reqState
Dim reqZip
Dim reqCountry
Dim reqEmail
Dim reqPhone1
Dim reqPhone2
Dim reqMemberID
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
   SetCache "3812URL", reqReturnURL
   SetCache "3812DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "3812")
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
reqName =  GetInput("Name", reqPageData)
reqLast =  GetInput("Last", reqPageData)
reqFirst =  GetInput("First", reqPageData)
reqStreet =  GetInput("Street", reqPageData)
reqUnit =  GetInput("Unit", reqPageData)
reqCity =  GetInput("City", reqPageData)
reqState =  GetInput("State", reqPageData)
reqZip =  GetInput("Zip", reqPageData)
reqCountry =  GetInput("Country", reqPageData)
reqEmail =  GetInput("Email", reqPageData)
reqPhone1 =  GetInput("Phone1", reqPageData)
reqPhone2 =  GetInput("Phone2", reqPageData)
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqCountry = "") Then
               reqCountry = "USA"
            End If
            .Status = 1
            .EnrollDate = reqSysDate
            .CompanyID = 1
            .MemberID = reqMemberID
            .CompanyName = reqName
            .NameLast = reqLast
            .NameFirst = reqFirst
            .Street = reqStreet
            .Unit = reqUnit
            .City = reqCity
            .State = reqState
            .Zip = reqZip
            .Country = reqCountry
            .Email = reqEmail
            .Phone1 = reqPhone1
            .Phone2 = reqPhone2
            
               If .CompanyName = "" Then .CompanyName = .NameLast + ", " + .NameFirst

            If (xmlError = "") Then
               tmpCompanyID = CLng(.Add(CLng(reqSysUserID)))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oCompany = Nothing

      If (xmlError = "") Then
         Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
         If oCoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
         Else
            With oCoption
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .CompanyID = tmpCompanyID
               .Price = 30
               .Retail = 0
               .Billing = 3
               .CommRate = .25
               .IsSignIn = 1
               .IsJoinNow = 1
               .BusPrice = 90
               .BusRetail = 0
               .BusAcctPrice = 30
               .BusAcctRetail = 0
               .BusAccts = 3
               .IsBusAcct = 0
               .IsFree = 0
               If (xmlError = "") Then
                  tmpCoptionID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oCoption = Nothing
      End If

      If (xmlError = "") Then
         Set oOrg = server.CreateObject("ptsOrgUser.COrg")
         If oOrg Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsOrgUser.COrg"
         Else
            With oOrg
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .ParentID = 0
               .OrgName = reqName
               .MemberID = 0
               .CompanyID = tmpCompanyID
               .Status = 2
               .NameLast = reqLast
               .NameFirst = reqFirst
               .Email = reqEmail
               .IsPublic = 1
               .IsChat = 1
               .IsForum = 1
               .IsSuggestion = 1
               .IsFavorite = 0
               .IsCatalog = 1
               .UserGroup = 51
               .UserStatus = 1
               If (xmlError = "") Then
                  tmpOrgID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               tmpAuthUser = .AuthUserID
               .Load tmpOrgID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Level = 1
               .Hierarchy = tmpOrgID & "/"
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oOrg = Nothing
      End If
      
        If (xmlError = "") Then
         Set oFileSys = server.CreateObject("Scripting.FileSystemObject")
         oFileSys.CreateFolder reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID)
         oFileSys.CreateFolder reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID)
         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\header[en].gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\header[en].gif"
         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\certificateheader.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\certificateheader.gif"
         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\navbarimage.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\navbarimage.gif"
         oFileSys.CopyFile reqSysWebDirectory + "Images\Company\tbimage.gif", reqSysWebDirectory + "Images\Company\" + CStr(tmpCompanyID) + "\tbimage.gif"
         Set oFileSys = Nothing
        End If


      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = "member.htm"
            .Path = reqSysWebDirectory + "Sections\Company\"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
            .Save 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Filename = "home.htm"
            .Path = reqSysWebDirectory + "Sections\Company\"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
            .Save 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Filename = "newmember.htm"
            .Path = reqSysWebDirectory + "Sections\Company\"
            .Language = reqSysLanguage
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
            .Save 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing

      Set oPageSection = server.CreateObject("ptsPageSectionUser.CPageSection")
      If oPageSection Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageSectionUser.CPageSection"
      Else
         With oPageSection
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CompanyID = tmpCompanyID
            .Language = reqSysLanguage
            .Path = reqSysWebDirectory + "Sections\Company\" + CStr(tmpCompanyID) + "\"
            .PageSectionName = "Home"
            .Filename = "home.htm"
            .Width = 750
            PageSectionID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .PageSectionName = "Member"
            .Filename = "member.htm"
            .Width = 600
            PageSectionID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .PageSectionName = "New Member Email"
            .Filename = "newmember.htm"
            .Width = 750
            PageSectionID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPageSection = Nothing

      If (tmpAuthUser > 0) Then
         Response.Redirect "0105.asp" & "?AuthUserID=" & tmpAuthUser
      End If
End Select

%>