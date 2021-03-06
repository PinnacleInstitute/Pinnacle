<!--#include file="Include\System.asp"-->
<!--#include file="Include\Email.asp"-->
<!--#include file="Include\LD_API.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionReturn = 3
Const cActionDelete = 4
Const cActionCancel = 5
Const cActionActivate = 6
Const cActionRemove = 7
Const cActionGetBackup = 8
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
Dim oMachine, xmlMachine
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqMachineID
Dim reqMemberID
Dim reqCompanyID
Dim reqPrice
Dim reqShowPassword
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
   SetCache "10703URL", reqReturnURL
   SetCache "10703DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "10703")
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
reqMachineID =  Numeric(GetInput("MachineID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqPrice =  GetInput("Price", reqPageData)
reqShowPassword =  Numeric(GetInput("ShowPassword", reqPageData))
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

Sub SetPassword()
   On Error Resume Next
   If (reqSysUserGroup = 1) Then
      reqShowPassword = 1
   End If
End Sub

Function Update_Computer(oMachine)
   On Error Resume Next
   
   Result = UpdateComputer( oMachine )
   If Result <> "OK" Then DoError -1, "", Result

End Function

Function Update_Computer_Status(oMachine, tmpStatus)
   On Error Resume Next
   
   Result = UpdateComputerStatus( oMachine, tmpStatus )
   If Result <> "OK" Then DoError -1, "", Result

End Function

reqCompanyID = 5
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      SetPassword

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqMemberID = .MemberID
            xmlMachine = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMachine = Nothing

   Case CLng(cActionUpdate):

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Email = Request.Form.Item("Email")
            
         If ValidEmail( .Email ) = 0 Then DoError 10122, "", "Oops, Invalid Email Address."

            If (xmlError = "") Then
               .FetchEmail .Email
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (CLng(.MachineID) <> 0) And (CLng(.MachineID) <> reqMachineID) Then
                  DoError 10123, "", "Oops, This email address is already assigned to another computer."
               End If
            End If
            If (xmlError = "") Then
               .Password = Request.Form.Item("Password")
               If (LEN(.Password) < 6) Then
                  DoError 10124, "", "Oops, Please enter at least 6 characters for the Password."
               End If
            End If
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpNameFirst = .NameFirst
            tmpNameLast = .NameLast
            tmpEmail = .Email
            tmpWebName = .WebName
            tmpStatus = .Status

            .MemberID = Request.Form.Item("MemberID")
            .NameFirst = Request.Form.Item("NameFirst")
            .NameLast = Request.Form.Item("NameLast")
            .Email = Request.Form.Item("Email")
            .WebName = Request.Form.Item("WebName")
            .Password = Request.Form.Item("Password")
            .Status = Request.Form.Item("Status")
            .Qty = Request.Form.Item("Qty")
            .ActiveDate = Request.Form.Item("ActiveDate")
            .CancelDate = Request.Form.Item("CancelDate")
            .RemoveDate = Request.Form.Item("RemoveDate")
            If (xmlError = "") And (.LiveDriveID <> 0) Then
               If (tmpNameFirst <> .NameFirst) Or (tmpNameLast <> .NameLast) Or (tmpEmail <> .Email) Or (tmpWebName <> .WebName) Then
                  Update_Computer oMachine
               End If
            End If
            If (xmlError = "") And (tmpStatus <> .Status) Then
               Update_Computer_Status oMachine, tmpStatus
            End If
            If (xmlError = "") Then
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (xmlError <> "") Then
               SetPassword
            End If
            If (xmlError <> "") Then
               xmlMachine = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMachine = Nothing

      If (xmlError = "") Then
         reqReturnURL = GetCache("10703URL")
         reqReturnData = GetCache("10703DATA")
         SetCache "10703URL", ""
         SetCache "10703DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionReturn):

      reqReturnURL = GetCache("10703URL")
      reqReturnData = GetCache("10703DATA")
      SetCache "10703URL", ""
      SetCache "10703DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMachine = Nothing

      If (xmlError <> "") Then
         Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
         If oMachine Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
         Else
            With oMachine
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqMachineID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlMachine = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMachine = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("10703URL")
         reqReturnData = GetCache("10703DATA")
         SetCache "10703URL", ""
         SetCache "10703DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            .MemberID = Request.Form.Item("MemberID")
            .NameFirst = Request.Form.Item("NameFirst")
            .NameLast = Request.Form.Item("NameLast")
            .Email = Request.Form.Item("Email")
            .WebName = Request.Form.Item("WebName")
            .Password = Request.Form.Item("Password")
            .Status = Request.Form.Item("Status")
            .Qty = Request.Form.Item("Qty")
            .ActiveDate = Request.Form.Item("ActiveDate")
            .CancelDate = Request.Form.Item("CancelDate")
            .RemoveDate = Request.Form.Item("RemoveDate")
            tmpStatus = .Status
            .Status = 3
            reqPrice = -5
            Update_Computer_Status oMachine, tmpStatus
            If (xmlError <> "") Then
               .Status = tmpStatus
               xmlMachine = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMachine = Nothing

      If (xmlError = "") Then
         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 101, 0, CLng(reqMemberID), reqPrice))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("10703URL")
         reqReturnData = GetCache("10703DATA")
         SetCache "10703URL", ""
         SetCache "10703DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionActivate):

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            .MemberID = Request.Form.Item("MemberID")
            .NameFirst = Request.Form.Item("NameFirst")
            .NameLast = Request.Form.Item("NameLast")
            .Email = Request.Form.Item("Email")
            .WebName = Request.Form.Item("WebName")
            .Password = Request.Form.Item("Password")
            .Status = Request.Form.Item("Status")
            .Qty = Request.Form.Item("Qty")
            .ActiveDate = Request.Form.Item("ActiveDate")
            .CancelDate = Request.Form.Item("CancelDate")
            .RemoveDate = Request.Form.Item("RemoveDate")
            tmpStatus = .Status
            .Status = 2
            reqPrice = 5
            Update_Computer_Status oMachine, tmpStatus
            If (xmlError <> "") Then
               .Status = tmpStatus
               xmlMachine = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMachine = Nothing

      If (xmlError = "") Then
         Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
         If oCompany Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
         Else
            With oCompany
               .SysCurrentLanguage = reqSysLanguage
               Count = CLng(.Custom(reqCompanyID, 101, 0, CLng(reqMemberID), reqPrice))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oCompany = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("10703URL")
         reqReturnData = GetCache("10703DATA")
         SetCache "10703URL", ""
         SetCache "10703DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionRemove):

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            .MemberID = Request.Form.Item("MemberID")
            .NameFirst = Request.Form.Item("NameFirst")
            .NameLast = Request.Form.Item("NameLast")
            .Email = Request.Form.Item("Email")
            .WebName = Request.Form.Item("WebName")
            .Password = Request.Form.Item("Password")
            .Status = Request.Form.Item("Status")
            .Qty = Request.Form.Item("Qty")
            .ActiveDate = Request.Form.Item("ActiveDate")
            .CancelDate = Request.Form.Item("CancelDate")
            .RemoveDate = Request.Form.Item("RemoveDate")
            tmpStatus = .Status
            .Status = 4
            Update_Computer_Status oMachine, tmpStatus
            If (xmlError <> "") Then
               .Status = tmpStatus
               xmlMachine = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oMachine = Nothing

      If (xmlError = "") Then
         reqReturnURL = GetCache("10703URL")
         reqReturnData = GetCache("10703DATA")
         SetCache "10703URL", ""
         SetCache "10703DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionGetBackup):
      SetPassword

      Set oMachine = server.CreateObject("ptsMachineUser.CMachine")
      If oMachine Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMachineUser.CMachine"
      Else
         With oMachine
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMachineID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   Result = GetUser( oMachine )
   If Result <> "OK" Then DoError -1, "", Result Else .Save 1 End If   

            reqMemberID = .MemberID
            xmlMachine = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMachine = Nothing
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
xmlParam = xmlParam + " machineid=" + Chr(34) + CStr(reqMachineID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " price=" + Chr(34) + CStr(reqPrice) + Chr(34)
xmlParam = xmlParam + " showpassword=" + Chr(34) + CStr(reqShowPassword) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMachine
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Machine[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Machine[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "10703 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "10703 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "10703 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "10703.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "10703 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "10703 Load file (oData) failed with error code " + CStr(oData.parseError)
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