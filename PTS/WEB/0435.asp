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
Dim reqX
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
   SetCache "0435URL", reqReturnURL
   SetCache "0435DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0435")
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
reqX =  Numeric(GetInput("X", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      
      If reqC = 0 Then
         response.write "0 - Missing Company"
         response.end
      End If
      If Len(reqR) = "" Then
         response.write "0 - Missing Reference"
         response.end
      End If


      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .FetchRef reqC, reqR
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
         If .MemberID = "" Then
            response.write "0"
            response.end
         End If

            If (reqX <> 0) Then
               .Load CLng(.MemberID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
               s = "<MEMBER"
               s = s + " memberid=" + Chr(34) + .memberid + Chr(34)
               s = s + " status=" + Chr(34) + .status + Chr(34)
               s = s + " level=" + Chr(34) + .level + Chr(34)
               s = s + " reference=" + Chr(34) + CleanXML(.reference) + Chr(34)
               s = s + " namefirst=" + Chr(34) + CleanXML(.namefirst) + Chr(34)
               s = s + " namelast=" + Chr(34) + CleanXML(.namelast) + Chr(34)
               If .IsCompany = "1" Then s = s + " companyname=" + Chr(34) + CleanXML(.companyname) + Chr(34)
               If Len(.Email) > 0 Then s = s + " email=" + Chr(34) + CleanXML(.email) + Chr(34)
               If Len(.Email2) > 0 Then s = s + " email2=" + Chr(34) + CleanXML(.email2) + Chr(34)
               If Len(.Phone1) > 0 Then s = s + " phone1=" + Chr(34) + CleanXML(.phone1) + Chr(34)
               If Len(.Phone2) > 0 Then s = s + " phone2=" + Chr(34) + CleanXML(.phone2) + Chr(34)
               If Len(.Fax) > 0 Then s = s + " fax=" + Chr(34) + CleanXML(.fax) + Chr(34)
               s = s + " enrolldate=" + Chr(34) + .enrolldate + Chr(34)
               s = s + " trialdays=" + Chr(34) + .trialdays + Chr(34)
               s = s + " visitdate=" + Chr(34) + .visitdate + Chr(34)
               s = s + " secure=" + Chr(34) + .secure + Chr(34)

               If (.MentorID <> 0) Then
                  .Load CLng(.MentorID), CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  
                  s = s + " mentor-reference=" + Chr(34) + .reference + Chr(34)
                  s = s + " mentor-namefirst=" + Chr(34) + CleanXML(.namefirst) + Chr(34)
                  s = s + " mentor-namelast=" + Chr(34) + CleanXML(.namelast) + Chr(34)

               End If
               
               s = s + " />"

            End If
            
         If reqX = 0 Then
            response.write .MemberID
         Else
            response.ContentType = "text/xml"
            response.write s
         End If   
         response.end

         End With
      End If
      Set oMember = Nothing
End Select

%>