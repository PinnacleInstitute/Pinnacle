<!--#include file="Include\System.asp"-->
<!--#include file="Include\LimitedAccess.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<!--#include file="Include\CompanyHeader.asp"-->
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
'-----declare page parameters
Dim reqLgn
Dim reqPwd
Dim reqAID
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
   SetCache "AuthorizeURL", reqReturnURL
   SetCache "AuthorizeDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "authorize")
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
reqLgn =  GetInput("Lgn", reqPageData)
reqPwd =  GetInput("Pwd", reqPageData)
reqAID =  Numeric(GetInput("AID", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0



          If reqAID > 0 Then
          Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "LiveDesktop\Users\"
          File = CStr(reqAID) + ".xml"
          Set oFileSys = CreateObject("Scripting.FileSystemObject")
          If oFileSys Is Nothing Then
          Response.Write "Scripting.FileSystemObject failed to load"
          Response.End
          End If
          oFileSys.DeleteFile Path + File
          Set oFileSys = Nothing
          Response.End
          End If
        
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
      If oAuthUser Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
      Else
         With oAuthUser
            .Logon = reqLgn
            .Password = reqPwd
            .SignIn 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError = "") Then
               tmpAuthUserID = .AuthUserID
               tmpMemberID = .MemberID
               If (.AuthUserID = 0) Then
                  DoError -2147220504, "", "Oops, Either your logon ID or password is incorrect."
               End If
               If (.UserStatus = 2) Then
                  DoError -2147220505, "", "Oops, The logon ID you entered has been disabled."
               End If
            End If
            If (xmlError = "") Then
               reqSysUserID = .AuthUserID
               reqSysUserGroup = .UserGroup
               reqSysUserStatus = .UserStatus
               reqSysUserName = .AuthUserName
               reqSysTrainerID = .TrainerID
               reqSysEmployeeID = .EmployeeID
               reqSysMemberID = .MemberID
               reqSysOrgID = .OrgID
               reqSysAffiliateID = .AffiliateID
               If (reqSysUserGroup <> 41) Then
                  DoError -2147220517, "", "Oops, Please contact Customer Support to access the system."
               End If
               If (xmlError = "") Then
                  tmpAccess = 1
                  tmpCompanyStatus = 0

                  Set oMember = server.CreateObject("ptsMemberUser.CMember")
                  If oMember Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
                  Else
                     With oMember
                        .Load CLng(reqSysMemberID), CLng(reqSysUserID)
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        tmpImage = .Image
                        MemberOptions = .Options
                        tmpGroupID = .GroupID
                        tmpBilling = .Billing
                        tmpStatus = .Status
                        If (.Status = 3) Then
                           .Level = 0
                        End If
                        tmpLevel = .Level
                        tmpSECURITYLEVEL = .Secure
                        tmpVISITDATE = .VisitDate
                        reqSysUserMode = .Status
                        tmpAccessLimit = .AccessLimit
                        If (tmpStatus = 4) Or (tmpStatus = 0) Then
                           DoError -2147220517, "", "Oops, Please contact Customer Support to access the system."
                        End If
                        If (xmlError = "") Then
                           reqSysCompanyID = .CompanyID
                        End If
                     End With
                  End If
                  Set oMember = Nothing
                  If (tmpGroupID = 0) Then
                     SetCompanyHeader reqSysCompanyID, reqSysLanguage
                  End If
                  If (tmpGroupID <> 0) Then
                     SetCompanyGrpHeader reqSysCompanyID, tmpGroupID, reqSysLanguage
                  End If

                  If (xmlError = "") Then
                     Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
                     If oCompany Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
                     Else
                        With oCompany
                           .Load CLng(reqSysCompanyID), CLng(reqSysUserID)
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           tmpCompanyStatus = .Status
                           If (.Status <> 2) And (.Status <> 3) Then
                              DoError 10106, "", "Oops, Your System is not available."
                           End If
                        End With
                     End If
                     Set oCompany = Nothing
                  End If

                  If (xmlError = "") Then
                     Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
                     If oCoption Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
                     Else
                        With oCoption
                           .FetchCompany CLng(reqSysCompanyID)
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           .Load .CoptionID, CLng(reqSysUserID)
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           tmpIDENTIFY = .Identify
                           tmpIPLimit = .IPLimit
                           If (tmpIPLimit = 0) Then
                              tmpIPLimit = 6
                           End If
                           If (tmpLevel = 0) Then
                              reqSysUserOptions = .FreeOptions
                           End If
                           If (tmpLevel = 1) Then
                              reqSysUserOptions = .Options
                           End If
                           If (tmpLevel = 2) Then
                              reqSysUserOptions = .Options2
                           End If
                           If (tmpLevel = 3) Then
                              reqSysUserOptions = .Options3
                           End If
                           reqSysUserOptions = GetUserOptions(reqSysUserOptions, MemberOptions)
                           If (tmpBilling <> 3) Then
                              reqSysUserOptions = Replace(reqSysUserOptions, "V", "")
                           End If
                        End With
                     End If
                     Set oCoption = Nothing
                  End If
                  If (xmlError = "") Then
                     
                  IPLevel = 3
                  If Left(tmpAccessLimit, 4) = "IPL:" Then
                  If IsNumeric(Mid(tmpAccessLimit, 5, 1)) Then
                  x = Mid(tmpAccessLimit, 5, 1)
                  If x >= 1 And x <= 4 Then IPLevel = x
                  End If
                  End If
                  UserIP = Request.ServerVariables("REMOTE_ADDR")
                  If IPLevel = 4 Then
                  tmpIP = UserIP
                  Else
                  x = 0
                  For z = 1 To IPLevel
                  x = InStr(x + 1, UserIP, ".")
                  Next
                  If x > 0 Then tmpIP = Left(UserIP, x)
                  End If
                

                     If (tmpAccessLimit <> "NONE") And (tmpCompanyStatus <> 3) Then
                        Set oAuthLog = server.CreateObject("ptsAuthLogUser.CAuthLog")
                        If oAuthLog Is Nothing Then
                           DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthLogUser.CAuthLog"
                        Else
                           With oAuthLog
                              result = CLng(.LogAuthUser(CLng(reqSysUserID), tmpIP, tmpIPLimit))
                              If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                              If (result = -1) Then
                                 DoError -2147220515, "", "Oops, Your access to the system has been disallowed - IP Address Denied.{" + UserIP + "}"
                              End If
                              If (result > 1) Then
                                 DoError -2147220516, "", "Oops, Your access to the system has been disallowed - Too Many IP Addresses.{" + UserIP + "}[" + CStr(result) + "]"
                              End If
                           End With
                        End If
                        Set oAuthLog = Nothing
                     End If
                     If (xmlError = "") And (tmpAccessLimit <> "NONE") And (tmpCompanyStatus <> 3) Then
                        tmpAccess = LimitedAccess( tmpAccessLimit )
                        If (tmpAccess <> 1) Then
                           DoError -2147220514, "", "Oops, Your access to the system has been limited - Access Denied."
                        End If
                     End If
                     If (xmlError = "") Then

                        If (tmpStatus = 1) Or (tmpStatus = 2) Or (tmpStatus = 3) Or (tmpStatus = 5) Then
                           Set oMember = server.CreateObject("ptsMemberUser.CMember")
                           If oMember Is Nothing Then
                              DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
                           Else
                              With oMember
                                 .Load CLng(reqSysMemberID), CLng(reqSysUserID)
                                 If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                                 .VisitDate = Now
                                 .Save CLng(reqSysUserID)
                                 If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                              End With
                           End If
                           Set oMember = Nothing
                        End If
                        SetMemberOptions reqSysMemberID, reqSysCompanyID, reqSysLanguage
                     End If
                  End If
               End If
            End If
         End With
      End If
      Set oAuthUser = Nothing
      If (xmlError = "") Then
         
            xmlSystem = "<SYSTEM"
            xmlSystem = xmlSystem + " headerimage=" + Chr(34) + reqSysHeaderImage + Chr(34)
            xmlSystem = xmlSystem + " footerimage=" + Chr(34) + reqSysFooterImage + Chr(34)
            xmlSystem = xmlSystem + " returnimage=" + Chr(34) + reqSysReturnImage + Chr(34)
            xmlSystem = xmlSystem + " navbarimage=" + Chr(34) + reqSysNavBarImage + Chr(34)
            xmlSystem = xmlSystem + " headerurl=" + Chr(34) + reqSysHeaderURL + Chr(34)
            xmlSystem = xmlSystem + " language=" + Chr(34) + reqSysLanguage + Chr(34)
            xmlSystem = xmlSystem + " langdialect=" + Chr(34) + reqLangDialect + Chr(34)
            xmlSystem = xmlSystem + " langcountry=" + Chr(34) + reqLangCountry + Chr(34)
            xmlSystem = xmlSystem + " langdefault=" + Chr(34) + reqLangDefault + Chr(34)
            xmlSystem = xmlSystem + " userid=" + Chr(34) + CStr(reqSysUserID) + Chr(34)
            xmlSystem = xmlSystem + " usergroup=" + Chr(34) + CStr(reqSysUserGroup) + Chr(34)
            xmlSystem = xmlSystem + " userstatus=" + Chr(34) + CStr(reqSysUserStatus) + Chr(34)
            xmlSystem = xmlSystem + " username=" + Chr(34) + CleanXML(reqSysUserName) + Chr(34)
            xmlSystem = xmlSystem + " companyid=" + Chr(34) + CStr(reqSysCompanyID) + Chr(34)
            xmlSystem = xmlSystem + " memberid=" + Chr(34) + CStr(reqSysMemberID) + Chr(34)
            xmlSystem = xmlSystem + " usermode=" + Chr(34) + CStr(reqSysUserMode) + Chr(34)
            xmlSystem = xmlSystem + " useroptions=" + Chr(34) + reqSysUserOptions + Chr(34)
            xmlSystem = xmlSystem + " gaa=" + Chr(34) + reqSysGAA + Chr(34)
            xmlSystem = xmlSystem + " cgaa=" + Chr(34) + reqSysCGAA + Chr(34)
            xmlSystem = xmlSystem + " menubarstate=" + Chr(34) + tmpMenuBarState + Chr(34)
            xmlSystem = xmlSystem + " securitylevel=" + Chr(34) + tmpSECURITYLEVEL + Chr(34)
            xmlSystem = xmlSystem + " visitdate=" + Chr(34) + tmpVISITDATE + Chr(34)
            xmlSystem = xmlSystem + " identify=" + Chr(34) + tmpIDENTIFY + Chr(34)
            tmpMEMBEROPTIONS = GetCache("MEMBEROPTIONS")
            xmlSystem = xmlSystem + " memberoptions=" + Chr(34) + tmpMEMBEROPTIONS + Chr(34)
            xmlSystem = xmlSystem + " />"

            Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "LiveDesktop\Users\"
            File = CStr(reqSysUserID) + ".xml"

            Set oFileSys = CreateObject("Scripting.FileSystemObject")
            If oFileSys Is Nothing Then
            Response.Write "Scripting.FileSystemObject failed to load"
            Response.End
            End If
            Set oFile = oFileSys.CreateTextFile(Path + File, True)
            If oFile Is Nothing Then
            Response.Write "Couldn't open file: " + Path + File
            Response.End
            End If

            oFile.WriteLine xmlSystem

            Set oFile = Nothing
            Set oFileSys = Nothing
          
      End If
      
          If xmlError = "" Then
          str = "<USER name=""" + CleanXML(reqSysUserName) + """ memberid=""" + CStr(reqSysMemberID) + """ companyid=""" + CStr(reqSysCompanyID) + """ authuserid=""" + CStr(reqSysUserID) + """ code=""" + reqSysUserOptions + """"
          If tmpGroupID <> 0 Then str = str + " GroupID=""" + CSTR(tmpGroupID) + """"
          If tmpImage <> "" Then str = str + " image=""" + tmpImage + """"
          str = str + "/>"
          Response.Write str
          Else
          str = "<ERROR>" + xmlError +  "</ERROR>"
          Response.Write str
          End If
          Response.End

        
End Select

%>