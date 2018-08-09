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
Dim oProspect, xmlProspect
'-----declare page parameters
Dim reqC
Dim reqM
Dim reqProspect
Dim reqFirst
Dim reqLast
Dim reqEmail
Dim reqPhone
Dim reqPhone2
Dim reqTimeZone
Dim reqBestTime
Dim reqDescription
Dim reqSource
Dim reqStreet
Dim reqUnit
Dim reqCity
Dim reqState
Dim reqZip
Dim reqCountry
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
   SetCache "AddLeadURL", reqReturnURL
   SetCache "AddLeadDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "addlead")
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
reqM =  Numeric(GetInput("M", reqPageData))
reqProspect =  Numeric(GetInput("Prospect", reqPageData))
reqFirst =  GetInput("First", reqPageData)
reqLast =  GetInput("Last", reqPageData)
reqEmail =  GetInput("Email", reqPageData)
reqPhone =  GetInput("Phone", reqPageData)
reqPhone2 =  GetInput("Phone2", reqPageData)
reqTimeZone =  GetInput("TimeZone", reqPageData)
reqBestTime =  GetInput("BestTime", reqPageData)
reqDescription =  GetInput("Description", reqPageData)
reqSource =  GetInput("Source", reqPageData)
reqStreet =  GetInput("Street", reqPageData)
reqUnit =  GetInput("Unit", reqPageData)
reqCity =  GetInput("City", reqPageData)
reqState =  GetInput("State", reqPageData)
reqZip =  GetInput("Zip", reqPageData)
reqCountry =  GetInput("Country", reqPageData)
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .ProspectName = Left(reqFirst + " " + reqLast,60)
            .CreateDate = reqSysDate
            .EmailStatus = 2
            If (reqProspect = 0) Then
               .Status = -1
            End If
            If (reqProspect <> 0) Then
               .Status = 1
            End If
            .CompanyID = reqC
            .MemberID = reqM
            .NameFirst = Left(reqFirst,30)
            .NameLast = Left(reqLast,30)
            .Email = Left(reqEmail,80)
            .Phone1 = Left(reqPhone,30)
            .Phone2 = Left(reqPhone2,30)
            .TimeZone = reqTimeZone
            .BestTime = reqBestTime
            .Description = Left(reqDescription,2000)
            .Source = Left(reqSource,20)
            .Street = Left(reqStreet,60)
            .Unit = Left(reqUnit,40)
            .City = Left(reqCity,30)
            .State = Left(reqState,30)
            .Zip = Left(reqZip,20)
            .Country = Left(reqCountry,30)
            ProspectID = 0
            ProspectID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProspect = Nothing
      
          If (Err.Number = 0) Then Response.Write ProspectID Else Response.Write Err.Description
        
End Select

%>