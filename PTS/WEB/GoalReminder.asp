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
Dim oGoals, xmlGoals
'-----declare page parameters
Dim reqRemindDate
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
   SetCache "GoalReminderURL", reqReturnURL
   SetCache "GoalReminderDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "goalreminder")
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
reqRemindDate =  GetInput("RemindDate", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqRemindDate = "") Then
         reqRemindDate = Date()
      End If

      Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
      If oBusiness Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
      Else
         With oBusiness
            .Load 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .SystemEmail
         End With
      End If
      Set oBusiness = Nothing

      Set oGoals = server.CreateObject("ptsGoalUser.CGoals")
      If oGoals Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsGoalUser.CGoals"
      Else
         With oGoals
            .Reminder CDate(reqRemindDate)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
            Set oMail = server.CreateObject("CDO.Message")
            If oMail Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
            Else
               oMail.Sender = tmpSender
               For Each oGoal in oGoals
                  tmpMsgTo = ""
                  With oGoal
                     tmpFrom = .FromEmail
                     tmpTo = .Email
                     If .IsMsg <> "0" Then tmpMsgTo = .MemberID
                     tmpBody = ""
                     If .ProspectName = "" Then
                        tmpSubject = "GOAL due: " + .CommitDate + " - " + .GoalName
                     Else
                        tmpSubject = "SERVICE due: " + .CommitDate + " - " + .GoalName
                        tmpBody = "Service for: " + .ProspectName + "<BR>"
                     End If   
                     tmpBody = tmpBody + .Description
                  End With
                  'check for valid to email address
                  If InStr(tmpTo, "@") > 0 Then
                     With oMail
                        .From = tmpFrom
                        .To = tmpTo
                        .Subject = tmpSubject 
                        .HTMLBody = tmpBody
                        .Send
                     End With
                  End If
                  If tmpMsgTo <> "" Then
                     SendMsg 1, tmpMsgTo, tmpSubject, tmpBody 
                  End If
               Next
            End If
            Set oMail = Nothing

         End With
      End If
      Set oGoals = Nothing
      
      Response.end

End Select

%>