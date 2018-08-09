<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0

response.Write "<BR>This function has been disabled!"
response.Write "<BR>Please access your customer service back-office to lookup distributor logon info."
response.Write "<BR>Search for the desired distributor and click the far right icon in the list."
response.End

'-----system variables
Dim reqActionCode
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqSysBrdUserID, reqSysBrdUserGroup
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGAA, reqSysCGAA
'-----object variables
Dim oMember, xmlMember
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
   SetCache "OpportunityURL", reqReturnURL
   SetCache "OpportunityDATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

'reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
'reqSysEmployeeID = Numeric(GetCache("EMPLOYEEID"))
'reqSysCustomerID = Numeric(GetCache("CUSTOMERID"))
'reqSysAffiliateID = Numeric(GetCache("AFFILIATEID"))
'reqSysAffiliateType = Numeric(GetCache("AFFILIATETYPE"))
'reqSysBrdUserID = Numeric(GetCache("BRDUSERID"))
'reqSysBrdUserGroup = Numeric(GetCache("BRDUSERGROUP"))
'reqSysDate = CStr(Date())
'reqSysTime = CStr(Time())
'reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
'reqSysServerName = Request.ServerVariables("SERVER_NAME")
'reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
'reqSysServerPath = Request.ServerVariables("PATH_INFO")
'pos = InStr(reqSysServerPath, "Opportunity")
'If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)

'reqSysCompanyID = Numeric(GetCache("COMPANYID"))
'reqSysTrainerID = Numeric(GetCache("TRAINERID"))
'reqSysMemberID = Numeric(GetCache("MEMBERID"))
'reqSysOrgID = Numeric(GetCache("ORGID"))
'reqSysUserMode = Numeric(GetCache("USERMODE"))
'reqSysUserOptions = GetCache("USEROPTIONS")
'reqSysGAA = GetCache("GAA")
'reqSysCGAA = GetCache("CGAA")

'-----fetch page parameters
reqID =  GetInput("ID", reqPageData)

'-----get the userID and security group
'CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0

Set oMember = server.CreateObject("ptsMemberUser.CMember")
If oMember Is Nothing Then
    DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
Else
    With oMember
   .FetchRef 582, reqID
'   .FetchRef 13, reqID
    If (.MemberID = 0) Then
		Response.Write "Missing Member: " + reqID
	Else
		tmpAuthUserID = .AuthUserID
		Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
		If oAuthUser Is Nothing Then
			DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
		Else
			With oAuthUser
				.SysCurrentLanguage = reqSysLanguage
				.AuthUserID = tmpAuthUserID
				.Load 1
				If (.Logon = "" ) Then
					Response.Write "Missing User: " + tmpAuthUserID
				Else
					Response.Write "<BR>Dealer: " + reqID
					Response.Write "<BR>Logon: " + .Logon
					Response.Write "<BR>Password: " + .Password
				End	If
			End With
		End If
		Set oAuthUser = Nothing
    End If
    End With
End If
Set oMember = Nothing

%>