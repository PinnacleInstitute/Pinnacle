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
Dim oFolderItem, xmlFolderItem
'-----declare page parameters
Dim reqItem
Dim reqUnsubscribe
Dim reqFolder
Dim reqDay
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
   SetCache "DripperURL", reqReturnURL
   SetCache "DripperDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "dripper")
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
reqItem =  Numeric(GetInput("Item", reqPageData))
reqUnsubscribe =  Numeric(GetInput("Unsubscribe", reqPageData))
reqFolder =  Numeric(GetInput("Folder", reqPageData))
reqDay =  Numeric(GetInput("Day", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      If (reqItem <> 0) Then
         Set oFolderItem = server.CreateObject("ptsFolderItemUser.CFolderItem")
         If oFolderItem Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsFolderItemUser.CFolderItem"
         Else
            With oFolderItem
               .Load reqItem, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               MemberID = .MemberID
               Entity = .Entity
               ItemID = .ItemID
               Dirty = 0
               If (reqFolder = 0) And (reqDay <> 0) Then
                  .ItemDate = DATEADD("d", (reqDay-1) * -1, reqSysDate)
                  Dirty = 1
               End If
               If (reqFolder <> 0) Then
                  .Status = 3
                  Dirty = 1
               End If
               If (reqUnsubscribe <> 0) Then
                  .Status = 4
                  Dirty = 1
               End If
               If (Dirty <> 0) Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oFolderItem = Nothing
      End If

      If (reqFolder <> 0) Then
         Set oFolderItem = server.CreateObject("ptsFolderItemUser.CFolderItem")
         If oFolderItem Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsFolderItemUser.CFolderItem"
         Else
            With oFolderItem
               .FetchItemID reqFolder, MemberID, Entity, ItemID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.FolderItemID <> 0) Then
                  .Status = 1
                  If (reqDay <> 0) Then
                     .ItemDate = DATEADD("d", (reqDay-1) * -1, reqSysDate)
                  End If
                  If (reqDay = 0) Then
                     .ItemDate = reqSysDate
                  End If
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
               If (.FolderItemID = 0) Then
                  .Load 0, CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  .FolderID = reqFolder
                  .MemberID = MemberID
                  .Entity = Entity
                  .ItemID = ItemID
                  .Status = 1
                  If (reqDay <> 0) Then
                     .ItemDate = DATEADD("d", (reqDay-1) * -1, reqSysDate)
                  End If
                  If (reqDay = 0) Then
                     .ItemDate = reqSysDate
                  End If
                  .Add CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oFolderItem = Nothing
      End If
End Select

%>