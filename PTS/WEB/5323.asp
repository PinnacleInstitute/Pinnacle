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
Dim oSalesItem, xmlSalesItem
'-----declare page parameters
Dim reqSI
Dim reqST
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
   SetCache "5323URL", reqReturnURL
   SetCache "5323DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "5323")
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
reqSI =  Numeric(GetInput("SI", reqPageData))
reqST =  Numeric(GetInput("ST", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqSI = 0 Then
         response.write "0 - Missing Sales Item #"
         response.end
      End If
      If reqST = 0 Then
         response.write "0 - Missing Status"
         response.end
      End If
      If reqST < 1 OR reqStatus > 5 Then
         response.write "0 - Invalid Status"
         response.end
      End If


      Set oSalesItem = server.CreateObject("ptsSalesItemUser.CSalesItem")
      If oSalesItem Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesItemUser.CSalesItem"
      Else
         With oSalesItem
            .Load reqSI, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.SalesOrderID <> "") Then
               .Status = reqST
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            
            If .SalesOrderID = "" Then
               response.write "0 - Invalid Sales Item #"
               response.end
            End If   
            
            If Len(xmlError) = 0 Then
               response.write .SalesItemID
            Else
               response.write "0 - " + xmlError
            End If   
            response.end

         End With
      End If
      Set oSalesItem = Nothing
End Select

%>