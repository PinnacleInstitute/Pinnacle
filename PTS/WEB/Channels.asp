<!--#include file="Include\System.asp"-->
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
Dim oNewss, xmlNewss
'-----declare page parameters
Dim reqCompanyID
Dim reqNewsType
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
   SetCache "ChannelsURL", reqReturnURL
   SetCache "ChannelsDATA", reqReturnData
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
pos = InStr(reqSysServerPath, "Channels")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqNewsType =  Numeric(GetInput("NewsType", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oNewss = server.CreateObject("ptsNewsUser.CNewss")
      If oNewss Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsUser.CNewss"
      Else
         With oNewss
            .ListChannels CLng(reqCompanyID), CLng(reqNewsType)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlNewss = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oNewss = Nothing
      
      If xmlError = "" Then
         Response.Write xmlNewss
      Else
         Response.Write xmlError
      End If
      Response.End

End Select

%>