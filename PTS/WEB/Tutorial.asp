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
Dim oBusiness, xmlBusiness
'-----declare page parameters
Dim reqcontentpage
Dim reqPopup
Dim reqLessons
Dim reqLesson
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
   SetCache "TutorialURL", reqReturnURL
   SetCache "TutorialDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "tutorial")
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
reqcontentpage =  Numeric(GetInput("contentpage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqLessons =  GetInput("Lessons", reqPageData)
reqLesson =  Numeric(GetInput("Lesson", reqPageData))
'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0


Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqLessons = reqLessons + ","
      If (InStr(reqSysUserOptions,"h") <> 0) Then
         reqLessons = reqLessons + "1,"
      End If
      If (InStr(reqSysUserOptions,"s") <> 0) Then
         reqLessons = reqLessons + "4,"
      End If
      If (InStr(reqSysUserOptions,"I") <> 0) Then
         reqLessons = reqLessons + "5,"
      End If
      If (InStr(reqSysUserOptions,"h") <> 0) Or (InStr(reqSysUserOptions,"E") <> 0) Or (InStr(reqSysUserOptions,"6") <> 0) Then
         reqLessons = reqLessons + "6,"
      End If
      If (InStr(reqSysUserOptions,"G") <> 0) Then
         reqLessons = reqLessons + "7,"
      End If
      If (InStr(reqSysUserOptions,"g") <> 0) Then
         reqLessons = reqLessons + "8,"
      End If
      If (InStr(reqSysUserOptions,"H") <> 0) Then
         reqLessons = reqLessons + "9,"
      End If
      If (InStr(reqSysUserOptions,"H") <> 0) Then
         reqLessons = reqLessons + "10,"
      End If
      If (InStr(reqSysUserOptions,"2") <> 0) Then
         reqLessons = reqLessons + "11,"
      End If
      If (InStr(reqSysUserOptions,"7") <> 0) Then
         reqLessons = reqLessons + "12,"
      End If
      If (InStr(reqSysUserOptions,"K") <> 0) Then
         reqLessons = reqLessons + "13,"
      End If
      If (InStr(reqSysUserOptions,"M") <> 0) Then
         reqLessons = reqLessons + "14,"
      End If
      If (InStr(reqSysUserOptions,"L") <> 0) Then
         reqLessons = reqLessons + "15,"
      End If
      If (InStr(reqSysUserOptions,"h") <> 0) Then
         reqLessons = reqLessons + "16,"
      End If
      If (InStr(reqSysUserOptions,"Z") <> 0) Then
         reqLessons = reqLessons + "17,"
      End If
      If (InStr(reqSysUserOptions,"z") <> 0) Then
         reqLessons = reqLessons + "18,"
      End If
      If (InStr(reqSysUserOptions,"E") <> 0) Then
         reqLessons = reqLessons + "19,"
      End If
      If (InStr(reqSysUserOptions,"~3") = 0) Then
         reqLessons = reqLessons + "20,"
      End If
      If (InStr(reqSysUserOptions,"6") <> 0) Then
         reqLessons = reqLessons + "21,"
      End If
      If (InStr(reqSysUserOptions,".") <> 0) Then
         reqLessons = reqLessons + "22,"
      End If
      If (InStr(reqSysUserOptions,"/") <> 0) Then
         reqLessons = reqLessons + "23,"
      End If
      If (InStr(reqSysUserOptions,"X") <> 0) Then
         reqLessons = reqLessons + "24,"
      End If
      If (InStr(reqSysUserOptions,"W") <> 0) Then
         reqLessons = reqLessons + "25,"
      End If
      If (InStr(reqSysUserOptions,"S") <> 0) Then
         reqLessons = reqLessons + "26,"
      End If
      If (InStr(reqSysUserOptions,"R") <> 0) Then
         reqLessons = reqLessons + "27,"
      End If
      If (InStr(reqSysUserOptions,"P") <> 0) Then
         reqLessons = reqLessons + "30,"
      End If
      If (InStr(reqSysUserOptions,"Q") <> 0) Then
         reqLessons = reqLessons + "31,"
      End If
      If (InStr(reqSysUserOptions,"m") <> 0) Then
         reqLessons = reqLessons + "32,"
      End If
      If (InStr(reqSysUserOptions,"a") <> 0) Then
         If (InStr(reqSysUserOptions,"b") <> 0) Then
            reqLessons = reqLessons + "33,"
         End If
         If (InStr(reqSysUserOptions,"c") <> 0) Then
            reqLessons = reqLessons + "34,"
         End If
         If (InStr(reqSysUserOptions,"e") <> 0) Then
            reqLessons = reqLessons + "35,"
         End If
         If (InStr(reqSysUserOptions,"d") <> 0) Then
            reqLessons = reqLessons + "36,"
         End If
      End If
      If (InStr(reqSysUserOptions,"F") <> 0) Then
         reqLessons = reqLessons + "37,"
      End If
      If (InStr(reqSysUserOptions,"|") <> 0) Then
         reqLessons = reqLessons + "38,"
      End If
      If (InStr(reqSysUserOptions,"\") <> 0) Then
         reqLessons = reqLessons + "39,"
      End If
      If (InStr(reqSysUserOptions,"+") <> 0) Then
         reqLessons = reqLessons + "40,"
      End If
      If (InStr(reqSysUserOptions,"=") <> 0) Then
         reqLessons = reqLessons + "41,"
      End If
      If (InStr(reqSysUserOptions,"_") <> 0) Then
         reqLessons = reqLessons + "42,"
      End If
      If (InStr(reqSysUserOptions,"}") <> 0) Then
         reqLessons = reqLessons + "43,"
      End If
      If (reqLesson <> 0) And (InStr(reqLessons,CSTR(reqLesson)) = 0) Then
         reqLesson = 0
      End If

      Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
      If oBusiness Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
      Else
         With oBusiness
            .Load 1, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCourse = .Tutorial
         End With
      End If
      Set oBusiness = Nothing

      Response.Redirect "1330.asp" & "?CourseID=" & tmpCourse & "&Register=" & 1 & "&contentpage=" & reqcontentpage & "&popup=" & reqPopup & "&Lessons=" & reqLessons & "&Lesson=" & reqLesson
End Select

%>