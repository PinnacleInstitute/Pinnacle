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
Dim oMember, xmlMember
'-----declare page parameters
Dim reqC
Dim reqR
Dim reqS
Dim reqL
Dim reqG
Dim reqSC
Dim reqSD
Dim reqM
Dim reqE
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
   SetCache "0428URL", reqReturnURL
   SetCache "0428DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0428")
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
reqS =  Numeric(GetInput("S", reqPageData))
reqL =  Numeric(GetInput("L", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqSC =  Numeric(GetInput("SC", reqPageData))
reqSD =  GetInput("SD", reqPageData)
reqM =  GetInput("M", reqPageData)
reqE =  GetInput("E", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LogFile "0428", Request.QueryString
      
      If reqS < 0 OR reqS > 5 Then reqS = 1
      If reqL < 0 OR reqL > 3 Then reqL = 1
      If reqS = 1 OR reqS = 2 Then
         If reqL = 0 Then reqL = 1
      End If   
      If reqS = 3 Then reqL = 0 


      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .FetchRef reqC, reqR
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpMemberID = .MemberID
            If (tmpMemberID = 0) Then
               
               response.write "0 - Member Not Found"
               response.end

            End If
            tmpMentorID = 0
            If (reqM <> "") And (reqM <> "0") Then
               .FetchRef reqC, reqM
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpMentorID = .MemberID
               If (tmpMentorID = 0) Then
                  
                  response.write "0 - Mentor Not Found"
                  response.end

               End If
            End If
            If (tmpMemberID <> 0) Then
               .Load tmpMemberID, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpStatus = .Status
               If (reqS <> 0) Then
                  .Status = reqS
                  .Level = reqL
                  If (tmpStatus <> 1) And (.Status = 1) Then
                     .PaidDate = reqSysDate
                  End If
                  If (tmpStatus <> 2) And (.Status = 2) Then
                     .PaidDate = DateAdd("d",.TrialDays,reqSysDate)
                  End If
               End If
               If (reqG <> 0) Then
                  .GroupID = reqG
               End If
               If (reqE <> "") Then
                  .Email = Left(reqE,80)
                  .Email2 = Left(reqE,80)
               End If
               If (reqSC <> 0) Then
                  .StatusChange = reqSC
                  .StatusDate = reqSD
               End If
               If (tmpMentorID <> 0) Then
                  .MentorID = tmpMentorID
               End If
               If (reqM = "0") Then
                  .MentorID = 0
               End If
               .Save 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMember = Nothing
      
         response.write 1
         response.end

End Select

%>