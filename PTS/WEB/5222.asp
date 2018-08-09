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
Dim oSalesOrder, xmlSalesOrder
'-----declare page parameters
Dim reqCO
Dim reqRE
Dim reqON
Dim reqSD
Dim reqSM
Dim reqAS
Dim reqTP
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
   SetCache "5222URL", reqReturnURL
   SetCache "5222DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5222")
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
reqCO =  Numeric(GetInput("CO", reqPageData))
reqRE =  GetInput("RE", reqPageData)
reqON =  GetInput("ON", reqPageData)
reqSD =  GetInput("SD", reqPageData)
reqSM =  Numeric(GetInput("SM", reqPageData))
reqAS =  Numeric(GetInput("AS", reqPageData))
reqTP =  GetInput("TP", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqCO = 0 Then
         response.write "0 - Missing Company"
         response.end
      End If
      If reqRE = "" Then
         response.write "0 - Missing Reference Number"
         response.end
      End If
      If reqSD = "" Then reqSD = Now()
      If reqSM = 0 Then reqSM = 1

      tmpMemberID = 0

      If (reqRE <> "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .FetchRef reqCO, reqRE
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then
                  tmpMemberID = .MemberID
               End If
               If (.MemberID = 0) Then
                  
               response.write "0 - Invalid Member Reference Number"
               response.end

               End If
            End With
         End If
         Set oMember = Nothing
      End If

      Set oSalesOrder = server.CreateObject("ptsSalesOrderUser.CSalesOrder")
      If oSalesOrder Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesOrderUser.CSalesOrder"
      Else
         With oSalesOrder
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .CompanyID = reqCO
            .MemberID = tmpMemberID
            .OrderDate = reqSD
            .Status = 3
            .Ship = reqSM
            .Total = reqTP
            .Notes = "D#" + reqRE + " O#" + reqON
            If (reqAS <> 0) Then
               .AutoShip = 1
            End If
            SalesOrderID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
               If Len(xmlError) = 0 Then
                  response.write SalesOrderID
               Else
                  response.write "0 - " + xmlError
               End If   
               response.end

         End With
      End If
      Set oSalesOrder = Nothing
End Select

%>