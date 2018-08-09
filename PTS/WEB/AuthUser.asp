<!--#include file="Include\System.asp"-->
<!--#include file="Include\MemberOptions.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----system variables
Dim reqActionCode
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqSysBrdUserID, reqSysBrdUserGroup
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGAA, reqSysCGAA
'-----object variables
Dim oAuthUser, xmlAuthUser
Dim oMember, xmlMember
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqLgn
Dim reqPwd
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
   SetCache "AuthUserURL", reqReturnURL
   SetCache "AuthUserDATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
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
pos = InStr(reqSysServerPath, "AuthUser")
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
reqLgn =  GetInput("Lgn", reqPageData)
reqPwd =  GetInput("Pwd", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


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
         End With
      End If
      Set oAuthUser = Nothing

      If (xmlError = "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .Load tmpMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpCompanyID = .CompanyID
               tmpName = .NameFirst + " " + .NameLast
               MemberOptions = .Options
               tmpStatus = .Status
               If (.Status = 3) Then
                  .Level = 0
               End If
               tmpLevel = .Level
            End With
         End If
         Set oMember = Nothing
      End If

      If (xmlError = "") Then
         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .Load tmpCompanyID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (tmpStatus = 1) Or (tmpStatus = 2) Then
                  If (tmpLevel = 1) Then
                     reqSysUserOptions = .Options
                  End If
                  If (tmpLevel = 2) Then
                     reqSysUserOptions = .Options2
                  End If
                  If (tmpLevel = 3) Then
                     reqSysUserOptions = .Options3
                  End If
               End If
               If (tmpStatus = 3) Then
                  reqSysUserOptions = .FreeOptions
               End If
               tmpOptions = GetUserOptions(reqSysUserOptions, MemberOptions)
            End With
         End If
         Set oCompany = Nothing
      End If
      
      If xmlError = "" Then
         Response.Write "<USER name=""" + CleanXML(tmpName) + """ memberid=""" & tmpMemberID & """ companyid=""" & tmpCompanyID & """ authuserid=""" & tmpAuthUserID & """ code=""" + tmpOptions + """/>"
      Else
         Response.Write xmlError
      End If
      Response.End

End Select

%>