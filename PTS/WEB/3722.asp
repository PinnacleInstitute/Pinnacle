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
Dim oAddress, xmlAddress
'-----declare page parameters
Dim reqCO
Dim reqRE
Dim reqOT
Dim reqOI
Dim reqAT
Dim reqS1
Dim reqS2
Dim reqCI
Dim reqST
Dim reqZC
Dim reqCC
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
   SetCache "3722URL", reqReturnURL
   SetCache "3722DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "3722")
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
reqOT =  Numeric(GetInput("OT", reqPageData))
reqOI =  Numeric(GetInput("OI", reqPageData))
reqAT =  Numeric(GetInput("AT", reqPageData))
reqS1 =  GetInput("S1", reqPageData)
reqS2 =  GetInput("S2", reqPageData)
reqCI =  GetInput("CI", reqPageData)
reqST =  GetInput("ST", reqPageData)
reqZC =  GetInput("ZC", reqPageData)
reqCC =  Numeric(GetInput("CC", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqOT = 0 Then reqOT = 4
      If reqAT = 0 Then reqAT = 1
      If reqCO = 0 Then
         response.write "0 - Missing Company"
         response.end
      End If
      If reqOI = 0 AND reqRE = "" Then
         response.write "0 - Missing Address Owner"
         response.end
      End If
      If reqS1 = "" Then
         response.write "0 - Missing Street"
         response.end
      End If
      If reqCI = "" Then
         response.write "0 - Missing City"
         response.end
      End If
      If reqST = "" Then
         response.write "0 - Missing State"
         response.end
      End If
      If reqZC = "" Then
         response.write "0 - Missing Zip Code"
         response.end
      End If
      If reqCC = 0 Then
         response.write "0 - Missing Country Code"
         response.end
      End If


      If (reqRE <> "") Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .FetchRef reqCO, reqRE
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.MemberID <> 0) Then
                  reqOI = .MemberID
               End If
               If (.MemberID = 0) Then
                  
               response.write "0 - Invalid Member Reference Number"
               response.end

               End If
            End With
         End If
         Set oMember = Nothing
      End If

      Set oAddress = server.CreateObject("ptsAddressUser.CAddress")
      If oAddress Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAddressUser.CAddress"
      Else
         With oAddress
            .Load 0, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .OwnerType = reqOT
            .OwnerID = reqOI
            .CountryID = reqCC
            .AddressType = reqAT
            .IsActive = 1
            .Street1 = reqS1
            .Street2 = reqS2
            .City = reqCI
            .State = reqST
            .Zip = reqZC
            AddressID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            result = CLng(.Activate(CLng(.OwnerType), CLng(.OwnerID), CLng(.AddressType), AddressID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
               If Len(xmlError) = 0 Then
                  response.write AddressID
               Else
                  response.write "0 - " + xmlError
               End If   
               response.end

         End With
      End If
      Set oAddress = Nothing
End Select

%>