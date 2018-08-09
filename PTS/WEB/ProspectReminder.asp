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
Dim oBusiness, xmlBusiness
Dim oCompany, xmlCompany
Dim oProspects, xmlProspects
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
   SetCache "ProspectReminderURL", reqReturnURL
   SetCache "ProspectReminderDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "prospectreminder")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

reqSysCompanyID = Numeric(GetCache("COMPANYID"))
reqSysTrainerID = Numeric(GetCache("TRAINERID"))
reqSysMemberID = Numeric(GetCache("MEMBERID"))
reqSysOrgID = Numeric(GetCache("ORGID"))
reqSysUserMode = Numeric(GetCache("USERMODE"))
reqSysUserOptions = GetCache("USEROPTIONS")
reqSysGA_ACCTID = GetCache("GA_ACCTID")
reqSysGA_DOMAIN = GetCache("GA_DOMAIN")

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      If (reqSysCompanyID = 0) Then
         Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
         If oBusiness Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
         Else
            With oBusiness
               .Load 1, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpSender = .SystemEmail
               tmpFrom = .CustomerEmail
               
            'check for valid from email address
            If InStr(tmpFrom, "@") = 0 Then
               Response.write "ERROR: Missing Business.CustomerEmail"
               Response.end
            End If

            End With
         End If
         Set oBusiness = Nothing
      End If

      If (reqSysCompanyID <> 0) Then
         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .Load CLng(reqSysCompanyID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpSender = .Email
               tmpFrom = .Email
            End With
         End If
         Set oCompany = Nothing
      End If

      Set oProspects = server.CreateObject("ptsProspectUser.CProspects")
      If oProspects Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspects"
      Else
         With oProspects
            .ListReminder CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")

   For Each oItem in oProspects
      tmpMsgTo = ""
      With oItem
         tmpTo = .Email2
         If .IsMsg <> "0" Then tmpMsgTo = .MemberID
         tmpSubject = "PROSPECT REMINDER: " + .ProspectName
         Select Case .NextEvent
         Case 1: tmpBody = "Call"
         Case 2: tmpBody = "Meeting"
         Case 3: tmpBody = "Email"
         Case 4: tmpBody = "Mail"
         Case 5: tmpBody = "Drop By"
         Case 6: tmpBody = "Other"
         End Select
         tmpBody = tmpBody + " " + .NextDate + " " + .NextTime
      End With
      'check for valid to email address
      If InStr(tmpTo, "@") > 0 Then
         SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
      End If

      oProspect.ClearReminder oItem.ProspectID
      If tmpMsgTo <> "" Then
         SendMsg 1, tmpMsgTo, tmpSubject, tmpBody
      End If
   Next
   
   Set oProspect = Nothing

         End With
      End If
      Set oProspects = Nothing
      
      Response.end

End Select

%>