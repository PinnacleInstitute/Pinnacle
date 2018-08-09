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
Dim oPayment, xmlPayment
'-----declare page parameters
Dim reqRef
Dim reqStat
Dim reqNote
Dim reqact
Dim reqstatus_id
Dim reqstatus_desc
Dim reqtrnx_id
Dim reqlog_id
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
   SetCache "1000URL", reqReturnURL
   SetCache "1000DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "1000")
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
reqRef =  GetInput("Ref", reqPageData)
reqStat =  GetInput("Stat", reqPageData)
reqNote =  GetInput("Note", reqPageData)
reqact =  GetInput("act", reqPageData)
reqstatus_id =  GetInput("status_id", reqPageData)
reqstatus_desc =  GetInput("status_desc", reqPageData)
reqtrnx_id =  GetInput("trnx_id", reqPageData)
reqlog_id =  GetInput("log_id", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


If (reqact <> "") Then
   If (lcase(reqact) = "paymenttomerchant") Then
      reqRef = reqtrnx_id
      reqNote = reqstatus_desc
      If (lcase(reqstatus_id) = "settled") Then
         reqStat = 3
      End If
      If (lcase(reqstatus_id) = "voided") Then
         reqStat = 6
      End If
   End If
   Response.Write "OK"
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      If (reqStat <> 0) Then
         Set oPayment = server.CreateObject("ptsPaymentUser.CPayment")
         If oPayment Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPaymentUser.CPayment"
         Else
            With oPayment
               Result = CLng(.Custom(0, reqRef, reqStat, reqNote))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oPayment = Nothing
      End If
End Select

%>