<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionDuplicate = 2
Const cActionDelete = 4
'-----page variables
Dim oData
Dim oStyle
'-----system variables
Dim reqActionCode
Dim reqSysTestFile, reqSysLanguage
Dim reqSysHeaderImage, reqSysFooterImage, reqSysReturnImage, reqSysNavBarImage, reqSysHeaderURL, reqSysReturnURL
Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType
Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory
Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData
Dim reqSysCompanyID, reqSysTrainerID, reqSysMemberID, reqSysOrgID, reqSysUserMode, reqSysUserOptions, reqSysGA_ACCTID, reqSysGA_DOMAIN
Dim reqLangDialect, reqLangCountry, reqLangDefault
Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm
Dim xmlTransaction, xmlData
'-----language variables
Dim oLanguage, xmlLanguage
Dim xslPage
Dim fileLanguage
'-----object variables
Dim oParty, xmlParty
Dim oAppt, xmlAppt
'-----declare page parameters
Dim reqApptID
Dim reqUpdated
Dim reqPartyID
On Error Resume Next

'-----Call Common System Function
CommonSystem()

Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)
   bvErrorMsg = Replace(bvErrorMsg, Chr(39), Chr(34))
   Set oUtil = server.CreateObject("wtSystem.CUtility")
   With oUtil
      tmpMsgFld = .ErrMsgFld( bvErrorMsg )
      tmpMsgVal = .ErrMsgVal( bvErrorMsg )
   End With
   Set oUtil = Nothing
   xmlError = "<ERROR number=" + Chr(34) & bvNumber & Chr(34) + " src=" + Chr(34) + bvSource + Chr(34) + " msgfld=" + Chr(34) + tmpMsgFld + Chr(34) + " msgval=" + Chr(34) + tmpMsgVal + Chr(34) + ">" + CleanXML(bvErrorMsg) + "</ERROR>"
   Err.Clear
End Sub

'-----initialize the error data
xmlError = ""

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "4803URL", reqReturnURL
   SetCache "4803DATA", reqReturnData
End If

'-----restore my form if it was cached
reqPageData = GetCache("RETURNDATA")
SetCache "RETURNDATA", ""

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysHeaderImage = GetCache("HEADERIMAGE")
reqSysFooterImage = GetCache("FOOTERIMAGE")
reqSysReturnImage = GetCache("RETURNIMAGE")
reqSysNavBarImage = GetCache("NAVBARIMAGE")
reqSysHeaderURL = GetCache("HEADERURL")
reqSysReturnURL = GetCache("RETURNURL")
reqConfirm = GetCache("CONFIRM")
SetCache "CONFIRM", ""
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
pos = InStr(LCASE(reqSysServerPath), "4803")
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
reqApptID =  Numeric(GetInput("ApptID", reqPageData))
reqUpdated =  Numeric(GetInput("Updated", reqPageData))
reqPartyID =  Numeric(GetInput("PartyID", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0
reqSysUserStatus = GetCache("USERSTATUS")
reqSysUserName = GetCache("USERNAME")

'-----get language settings
reqLangDefault = "en"
reqSysLanguage = GetInput("SysLanguage", reqPageData)
If Len(reqSysLanguage) = 0 Then
   reqSysLanguage = GetCache("LANGUAGE")
   If Len(reqSysLanguage) = 0 Then
      GetLanguage reqLangDialect, reqLangCountry, reqLangDefault
      If len(reqLangDialect) > 0 Then
         reqSysLanguage = reqLangDialect
      ElseIf len(reqLangCountry) > 0 Then
         reqSysLanguage = reqLangCountry
      Else
         reqSysLanguage = reqLangDefault
      End If
      SetCache "LANGUAGE", reqSysLanguage
   End If
Else
   SetCache "LANGUAGE", reqSysLanguage
End If

Function GetPartyID
   On Error Resume Next

   If (reqSysUserGroup <= 23) Or (InStr(reqSysUserOptions,"7") <> 0) Then
      Set oParty = server.CreateObject("ptsPartyUser.CParty")
      If oParty Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPartyUser.CParty"
      Else
         With oParty
            .SysCurrentLanguage = reqSysLanguage
            .FetchPartyID CLng(reqApptID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPartyID = .PartyID
            If (.PartyID = 0) Then
               reqPartyID = -1
            End If
         End With
      End If
      Set oParty = Nothing
   End If
End Function

Function UpdateAppt(dup)
   On Error Resume Next

   Set oAppt = server.CreateObject("ptsApptUser.CAppt")
   If oAppt Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppt"
   Else
      With oAppt
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqApptID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
         days = DateDiff( "d", .StartDate, .EndDate )


         .ApptName = Request.Form.Item("ApptName")
         .Location = Request.Form.Item("Location")
         .StartDate = Request.Form.Item("StartDate")
         .StartTime = Request.Form.Item("StartTime")
         .IsAllDay = Request.Form.Item("IsAllDay")
         .EndDate = Request.Form.Item("EndDate")
         .EndTime = Request.Form.Item("EndTime")
         .IsEdit = Request.Form.Item("IsEdit")
         .ApptType = Request.Form.Item("ApptType")
         .Importance = Request.Form.Item("Importance")
         .Show = Request.Form.Item("Show")
         .Note = Request.Form.Item("Note")
         .Reminder = Request.Form.Item("Reminder")
         .RemindDate = Request.Form.Item("RemindDate")
         .Recur = Request.Form.Item("Recur")
         .RecurDate = Request.Form.Item("RecurDate")
         .IsPlan = Request.Form.Item("IsPlan")
         If (.IsPlan <> 0) Then
            GetPartyID
         End If
         If (.IsEdit = "1") Then
            .Recur = "0"
            .RecurDate = ""
         End If
         
         If .StartDate = "" Then .StartDate = Date()
         If .EndDate = "" Then .EndDate = .StartDate
         If CDate(.EndDate) < CDate(.StartDate) Then .EndDate = DateAdd( "d", days, .StartDate )

         If InStr(.StartTime, ":") = 0 AND IsNumeric(.StartTime) Then .StartTime = .StartTime + ":00"
         If InStr(.EndTime, ":") = 0 AND IsNumeric(.EndTime)  Then .EndTime = .EndTime + ":00"
         If .StartTime = "" Then .EndTime = ""
         If .StartTime = "" AND .EndTime = "" Then .IsAllDay = 1 Else .IsAllDay = 0
         
         If .Reminder > 0 And .StartDate <> "" Then
            tmpDate = .StartDate + " " + .StartTime         
            If Not IsDate(tmpDate) Then tmpDate = .StartDate
            If IsDate(tmpDate) Then
               Select Case .Reminder
               Case "5" .RemindDate = DateAdd("n", -30, tmpDate)   '30m
               Case "6" .RemindDate = DateAdd("h", -1, tmpDate)   '1h
               Case "7" .RemindDate = DateAdd("h", -2, tmpDate)   '2h
               Case "8" .RemindDate = DateAdd("h", -3, tmpDate)   '3h
               Case "9" .RemindDate = DateAdd("h", -4, tmpDate)   '4h
               Case "10" .RemindDate = DateAdd("h", -5, tmpDate)   '5h
               Case "11" .RemindDate = DateAdd("h", -6, tmpDate)   '6h
               Case "12" .RemindDate = DateAdd("h", -7, tmpDate)   '7h
               Case "13" .RemindDate = DateAdd("h", -8, tmpDate)   '8h
               Case "14" .RemindDate = DateAdd("h", -9, tmpDate)   '9h
               Case "15" .RemindDate = DateAdd("h", -10, tmpDate)   '10h
               Case "16" .RemindDate = DateAdd("h", -11, tmpDate)   '11h
               Case "17" .RemindDate = DateAdd("h", -12, tmpDate)   '12h
               Case "18" .RemindDate = DateAdd("h", -18, tmpDate)   '18h
               Case "19" .RemindDate = DateAdd("d", -1, tmpDate)   '1d
               Case "20" .RemindDate = DateAdd("d", -2, tmpDate)   '2d
               Case "21" .RemindDate = DateAdd("d", -3, tmpDate)   '3d
               Case "22" .RemindDate = DateAdd("d", -4, tmpDate)   '4d
               Case "23" .RemindDate = DateAdd("ww", -1, tmpDate)   '1w
               Case "24" .RemindDate = DateAdd("ww", -2, tmpDate)   '2w
               End Select
            End If
         End If

         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (dup = 1) Then
            ApptID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            If (xmlError = "") Then
               Response.Redirect "4803.asp" & "?ApptID=" & ApptID & "&Updated=" & 4
            End If
         End If
         xmlAppt = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oAppt = Nothing
   If (xmlError = "") Then
      reqUpdated = 1
   End If
End Function

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oAppt = server.CreateObject("ptsApptUser.CAppt")
      If oAppt Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppt"
      Else
         With oAppt
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqApptID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.IsPlan <> 0) Then
               GetPartyID()
            End If
            xmlAppt = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAppt = Nothing

   Case CLng(cActionUpdate):
      UpdateAppt(0)

   Case CLng(cActionDuplicate):
      UpdateAppt(1)

   Case CLng(cActionDelete):

      Set oAppt = server.CreateObject("ptsApptUser.CAppt")
      If oAppt Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppt"
      Else
         With oAppt
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqApptID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAppt = Nothing

      If (xmlError <> "") Then
         Set oAppt = server.CreateObject("ptsApptUser.CAppt")
         If oAppt Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsApptUser.CAppt"
         Else
            With oAppt
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqApptID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlAppt = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAppt = Nothing
      End If
      If (xmlError = "") Then
         reqUpdated = 2
      End If
End Select

'-----get system data
xmlSystem = "<SYSTEM"
xmlSystem = xmlSystem + " headerimage=" + Chr(34) + reqSysHeaderImage + Chr(34)
xmlSystem = xmlSystem + " footerimage=" + Chr(34) + reqSysFooterImage + Chr(34)
xmlSystem = xmlSystem + " returnimage=" + Chr(34) + reqSysReturnImage + Chr(34)
xmlSystem = xmlSystem + " navbarimage=" + Chr(34) + reqSysNavBarImage + Chr(34)
xmlSystem = xmlSystem + " headerurl=" + Chr(34) + reqSysHeaderURL + Chr(34)
xmlSystem = xmlSystem + " returnurl=" + Chr(34) + CleanXML(reqSysReturnURL) + Chr(34)
xmlSystem = xmlSystem + " language=" + Chr(34) + reqSysLanguage + Chr(34)
xmlSystem = xmlSystem + " langdialect=" + Chr(34) + reqLangDialect + Chr(34)
xmlSystem = xmlSystem + " langcountry=" + Chr(34) + reqLangCountry + Chr(34)
xmlSystem = xmlSystem + " langdefault=" + Chr(34) + reqLangDefault + Chr(34)
xmlSystem = xmlSystem + " userid=" + Chr(34) + CStr(reqSysUserID) + Chr(34)
xmlSystem = xmlSystem + " usergroup=" + Chr(34) + CStr(reqSysUserGroup) + Chr(34)
xmlSystem = xmlSystem + " userstatus=" + Chr(34) + CStr(reqSysUserStatus) + Chr(34)
xmlSystem = xmlSystem + " username=" + Chr(34) + CleanXML(reqSysUserName) + Chr(34)
xmlSystem = xmlSystem + " customerid=" + Chr(34) + CStr(reqSysCustomerID) + Chr(34)
xmlSystem = xmlSystem + " employeeid=" + Chr(34) + CStr(reqSysEmployeeID) + Chr(34)
xmlSystem = xmlSystem + " affiliateid=" + Chr(34) + CStr(reqSysAffiliateID) + Chr(34)
xmlSystem = xmlSystem + " affiliatetype=" + Chr(34) + CStr(reqSysAffiliateType) + Chr(34)
xmlSystem = xmlSystem + " actioncode=" + Chr(34) + CStr(reqActionCode) + Chr(34)
xmlSystem = xmlSystem + " confirm=" + Chr(34) + CStr(reqConfirm) + Chr(34)
xmlSystem = xmlSystem + " pageData=" + Chr(34) + CleanXML(reqPageData) + Chr(34)
xmlSystem = xmlSystem + " pageURL=" + Chr(34) + CleanXML(reqPageURL) + Chr(34)
xmlSystem = xmlSystem + " currdate=" + Chr(34) + reqSysDate + Chr(34)
xmlSystem = xmlSystem + " currtime=" + Chr(34) + reqSysTime + Chr(34)
xmlSystem = xmlSystem + " currtimeno=" + Chr(34) + reqSysTimeno + Chr(34)
xmlSystem = xmlSystem + " servername=" + Chr(34) + reqSysServerName + Chr(34)
xmlSystem = xmlSystem + " serverpath=" + Chr(34) + reqSysServerPath + Chr(34)
xmlSystem = xmlSystem + " webdirectory=" + Chr(34) + reqSysWebDirectory + Chr(34)
xmlSystem = xmlSystem + " companyid=" + Chr(34) + CStr(reqSysCompanyID) + Chr(34)
xmlSystem = xmlSystem + " trainerid=" + Chr(34) + CStr(reqSysTrainerID) + Chr(34)
xmlSystem = xmlSystem + " memberid=" + Chr(34) + CStr(reqSysMemberID) + Chr(34)
xmlSystem = xmlSystem + " orgid=" + Chr(34) + CStr(reqSysOrgID) + Chr(34)
xmlSystem = xmlSystem + " usermode=" + Chr(34) + CStr(reqSysUserMode) + Chr(34)
xmlSystem = xmlSystem + " useroptions=" + Chr(34) + reqSysUserOptions + Chr(34)
xmlSystem = xmlSystem + " ga_acctid=" + Chr(34) + reqSysGA_ACCTID + Chr(34)
xmlSystem = xmlSystem + " ga_domain=" + Chr(34) + reqSysGA_DOMAIN + Chr(34)
xmlSystem = xmlSystem + " />"
xmlOwner = "<OWNER"
xmlOwner = xmlOwner + " id=" + Chr(34) + CStr(reqOwnerID) + Chr(34)
xmlOwner = xmlOwner + " title=" + Chr(34) + CleanXML(reqOwnerTitle) + Chr(34)
xmlOwner = xmlOwner + " entity=" + Chr(34) + CStr(reqOwner) + Chr(34)
xmlOwner = xmlOwner + " />"
xmlConfig = "<CONFIG"
xmlConfig = xmlConfig + " isdocuments=" + Chr(34) + GetCache("ISDOCUMENTS") + Chr(34)
xmlConfig = xmlConfig + " documentpath=" + Chr(34) + GetCache("DOCUMENTPATH") + Chr(34)
xmlConfig = xmlConfig + " />"
xmlParam = "<PARAM"
xmlParam = xmlParam + " apptid=" + Chr(34) + CStr(reqApptID) + Chr(34)
xmlParam = xmlParam + " updated=" + Chr(34) + CStr(reqUpdated) + Chr(34)
xmlParam = xmlParam + " partyid=" + Chr(34) + CStr(reqPartyID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlParty
xmlTransaction = xmlTransaction +  xmlAppt
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Appt[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Appt[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "4803 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

'-----append common labels
fileLanguage = "Language\Common[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Common[en].xml"
End If
Set oCommon = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oCommon.load server.MapPath(fileLanguage)
If oCommon.parseError <> 0 Then
   Response.Write "4803 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
   Response.End
End If
Set oLabels = oCommon.selectNodes("LANGUAGE/LABEL")
For Each oLabel In oLabels
Set oAdd = oLanguage.selectSingleNode("LANGUAGE").appendChild(oLabel.cloneNode(True))
Set oAdd = Nothing
Next
xmlLanguage = oLanguage.XML
Set oLanguage = Nothing

'-----If there is an Error, get the Error Labels XML
If xmlError <> "" Then
fileLanguage = "Language\Error[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Error[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "4803 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlSystem
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlOwner
xmlData = xmlData +  xmlConfig
xmlData = xmlData +  xmlParent
xmlData = xmlData +  xmlBookmark
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "4803.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "4803 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "4803 Load file (oData) failed with error code " + CStr(oData.parseError)
   Response.Write "<BR/>" + xmlData
   Response.End
End If

If Len(reqSysTestFile) > 0 Then
   oData.save reqSysTestFile
End If

'-----transform the XML with the XSL
Response.Write oData.transformNode(oStyle)

Set oData = Nothing
Set oStyle = Nothing
Set oLanguage = Nothing
%>