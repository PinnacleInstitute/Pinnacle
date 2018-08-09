<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionUpdateExit = 2
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionCampaign = 5
Const cActionPresent = 6
Const cActionLead = 8
Const cActionCopySystem = 7
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
Dim oSalesStep, xmlSalesStep
Dim oProspect, xmlProspect
Dim oLeadCampaign, xmlLeadCampaign
Dim oProspectType, xmlProspectType
Dim oProspectTypes, xmlProspectTypes
Dim oSalesSteps, xmlSalesSteps
Dim oEmail, xmlEmail
Dim oSalesCampaign, xmlSalesCampaign
'-----other transaction data variables
Dim xmlStatus
Dim xmlChangeStatus
'-----declare page parameters
Dim reqProspectID
Dim reqPopup
Dim reqEmailID
Dim reqIsMail
Dim reqContentPage
Dim reqLeadName
Dim reqPresentName
Dim reqExtra
Dim reqMove
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
   SetCache "8103URL", reqReturnURL
   SetCache "8103DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "8103")
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
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqEmailID =  Numeric(GetInput("EmailID", reqPageData))
reqIsMail =  Numeric(GetInput("IsMail", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqLeadName =  GetInput("LeadName", reqPageData)
reqPresentName =  GetInput("PresentName", reqPageData)
reqExtra =  Numeric(GetInput("Extra", reqPageData))
reqMove =  Numeric(GetInput("Move", reqPageData))
tmpCompanyID = 0
tmpMemberID = 0
tmpStatus = 0
tmpFirstName = ""
tmpLastName = ""
tmpProspectTypeID = 0
tmpSalesCampaignID = 0
tmpStatus = 0
tmpChangeStatus = 0
tmpDate1 = 0
tmpDate2 = 0
tmpDate3 = 0
tmpDate4 = 0
tmpDate5 = 0
tmpDate6 = 0
tmpDate7 = 0
tmpDate8 = 0
tmpDate9 = 0
tmpDate10 = 0
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 61
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

Sub EmailStatus()
   On Error Resume Next

   Set oSalesStep = server.CreateObject("ptsSalesStepUser.CSalesStep")
   If oSalesStep Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesStepUser.CSalesStep"
   Else
      With oSalesStep
         .SysCurrentLanguage = reqSysLanguage
         .Load tmpStatus, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpAutoStep = .AutoStep
         tmpTo = .Email
         tmpEmailID = .EmailID
      End With
   End If
   Set oSalesStep = Nothing
   If (tmpAutoStep > 1) Then

      Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
      If oCompany Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
      Else
         With oCompany
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqSysCompanyID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSender = .Email
         End With
      End If
      Set oCompany = Nothing

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpMemberID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpMFirstName = .NameFirst
            tmpMLastName = .NameLast
            tmpMEmail = .Email
            tmpMPhone = .Phone1
            tmpSignature = .Signature
            If (tmpAutoStep = 2) Then
               tmpTo = .Email
            End If
            If (tmpAutoStep = 2) And (.IsMsg <> 0) Then
               tmpMsgTo = .MemberID
            End If
            Signature = .GetSignature(tmpMemberID, 5, 0, reqSysLanguage)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Signature <> "") Then
               tmpSignature = Signature
            End If
         End With
      End If
      Set oMember = Nothing

      Set oEmail = server.CreateObject("ptsEmailUser.CEmail")
      If oEmail Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailUser.CEmail"
      Else
         With oEmail
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpEmailID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpFile = .FileName
            tmpFrom = .FromEmail
            tmpSubject = .Subject
         End With
      End If
      Set oEmail = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .FileName = tmpFile
            .Path = reqSysWebDirectory + "Sections\Company\" & tmpCompanyID & "\"
            .Language = "en"
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpBody = .Data
         End With
      End If
      Set oHTMLFile = Nothing
      
      tmpFrom = Replace( tmpFrom, "{m-email}", tmpMEmail )
      tmpSubject = Replace( tmpSubject, "{firstname}", tmpFirstName )
      tmpSubject = Replace( tmpSubject, "{lastname}", tmpLastName )
      tmpSubject = Replace( tmpSubject, "{id}", reqProspectID )
      tmpSubject = Replace( tmpSubject, "{m-firstname}", tmpMFirstName )
      tmpSubject = Replace( tmpSubject, "{m-lastname}", tmpMLastName )

      tmpBody = Replace( tmpBody, "{firstname}", tmpFirstName )
      tmpBody = Replace( tmpBody, "{lastname}", tmpLastName )
      tmpBody = Replace( tmpBody, "{id}", reqProspectID )
      tmpBody = Replace( tmpBody, "{m-firstname}", tmpMFirstName )
      tmpBody = Replace( tmpBody, "{m-lastname}", tmpMLastName )
      tmpBody = Replace( tmpBody, "{m-id}", tmpMemberID )
      tmpBody = Replace( tmpBody, "{signature}", tmpSignature )
      tmpBody = Replace( tmpBody, "{m}", reqProspectID )
      tmpBody = Replace( tmpBody, "{m-email}", tmpMEmail )
      tmpBody = Replace( tmpBody, "{m-phone}", tmpMPhone )

      If InStr(tmpTo, "@") > 0 Then
         SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
      End If   

   End If
End Sub

Sub LoadProspect()
   On Error Resume Next

   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   If oProspect Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
   Else
      With oProspect
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProspectID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpMentoringID = GetCache("MENTORINGID")
         If (tmpMentoringID = "") Then
            tmpMentoringID = -1
         End If
         If (.Status = 4) Then
            reqMove = -81
         End If
         If (InStr(.Email, "@") = 0) Then
            reqIsMail = 0
         End If
         If (InStr(.Email, "@") <> 0) Then
            reqIsMail = 1
         End If
         reqEmailID = .EmailID
         tmpCompanyID = .CompanyID
         tmpProspectTypeID = .ProspectTypeID
         tmpSalesCampaignID = .SalesCampaignID
         tmpLeadCampaignID = .LeadCampaignID
         tmpPresentID = .PresentID
         tmpStatus = .Status
         tmpChangeStatus = .ChangeStatus
         tmpDate1 = .Date1
         tmpDate2 = .Date2
         tmpDate3 = .Date3
         tmpDate4 = .Date4
         tmpDate5 = .Date5
         tmpDate6 = .Date6
         tmpDate7 = .Date7
         tmpDate8 = .Date8
         tmpDate9 = .Date9
         tmpDate10 = .Date10
         xmlProspect = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProspect = Nothing

   If (tmpLeadCampaignID <> 0) And (InStr(reqSysUserOptions,"Z") <> 0) Or (reqSysUserGroup <= 23) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpLeadCampaignID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqLeadName = .LeadCampaignName
         End With
      End If
      Set oLeadCampaign = Nothing
   End If

   If (tmpPresentID <> 0) And (InStr(reqSysUserOptions,"z") <> 0) Or (reqSysUserGroup <= 23) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpPresentID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqPresentName = .LeadCampaignName
         End With
      End If
      Set oLeadCampaign = Nothing
   End If

   Set oProspectType = server.CreateObject("ptsProspectTypeUser.CProspectType")
   If oProspectType Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectTypeUser.CProspectType"
   Else
      With oProspectType
         .SysCurrentLanguage = reqSysLanguage
         .Load tmpProspectTypeID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpInputOptions = .InputOptions
         If (tmpInputOptions <> "") Then
            
          Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
         With oInputOptions
            .Load tmpInputOptions
            If reqSysUserGroup <= 23 Then
               tmpDisplayRows = .DisplayRows(0)
            Else
               tmpDisplayRows = .DisplayRows(1)
            End If
         End With   
         Set oInputOptions = Nothing
         reqExtra = 100 + (tmpDisplayRows * 25 )
         If reqExtra > 550 Then reqExtra = 550

         End If
      End With
   End If
   Set oProspectType = Nothing
   LoadLists
End Sub

Sub LoadLists()
   On Error Resume Next

   Set oProspectTypes = server.CreateObject("ptsProspectTypeUser.CProspectTypes")
   If oProspectTypes Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectTypeUser.CProspectTypes"
   Else
      With oProspectTypes
         .SysCurrentLanguage = reqSysLanguage
         xmlProspectTypes = .EnumCompany(tmpCompanyID, tmpProspectTypeID, , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oProspectTypes = Nothing

   Set oSalesSteps = server.CreateObject("ptsSalesStepUser.CSalesSteps")
   If oSalesSteps Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesStepUser.CSalesSteps"
   Else
      With oSalesSteps
         .SysCurrentLanguage = reqSysLanguage
         .List tmpSalesCampaignID
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
            '--- Get stored date fields for each step that stores a date indicated by DateNo
            For Each oSalesStep in oSalesSteps
               With oSalesStep
                  Select Case .DateNo
                  Case 1: .Data = tmpDate1
                  Case 2: .Data = tmpDate2
                  Case 3: .Data = tmpDate3
                  Case 4: .Data = tmpDate4
                  Case 5: .Data = tmpDate5
                  Case 6: .Data = tmpDate6
                  Case 7: .Data = tmpDate7
                  Case 8: .Data = tmpDate8
                  Case 9: .Data = tmpDate9
                  Case 10: .Data = tmpDate10
                  End Select 
               End With
            Next

'--- STATUS Get all fixed statuses and sales steps for status combo box
            xmlStatus = "<PTSSTATUSS>"
            xmlStatus = xmlStatus + "<ENUM id=""1"" name=""New"""
            If tmpStatus = 1 Then xmlStatus = xmlStatus + " selected=""True"""
            xmlStatus = xmlStatus + "/>"
            xmlStatus = xmlStatus + "<ENUM id=""0"" name=""----------""/>"
            For Each oSalesStep in oSalesSteps
               With oSalesStep
                  xmlStatus = xmlStatus + "<ENUM id=""" + .SalesStepID + """ name=""" + CleanXML(.SalesStepName) + """"
                  If tmpStatus = .SalesStepID Then xmlStatus = xmlStatus + " selected=""True"""
                  xmlStatus = xmlStatus + "/>"
               End With
            Next
            xmlStatus = xmlStatus + "<ENUM id=""0"" name=""----------""/>"
            xmlStatus = xmlStatus + "<ENUM id=""3"" name=""Fallback"""
            If tmpStatus = 3 Then xmlStatus = xmlStatus + " selected=""True"""
            xmlStatus = xmlStatus + "/>"
            xmlStatus = xmlStatus + "<ENUM id=""4"" name=""Closed"""
            If tmpStatus = 4 Then xmlStatus = xmlStatus + " selected=""True"""
            xmlStatus = xmlStatus + "/>"
            xmlStatus = xmlStatus + "<ENUM id=""5"" name=""Dead"""
            If tmpStatus = 5 Then xmlStatus = xmlStatus + " selected=""True"""
            xmlStatus = xmlStatus + "/>"
            xmlStatus = xmlStatus + "</PTSSTATUSS>"

'--- CHANGE STATUS Get all fixed statuses and sales steps for change status combo box
            xmlChangeStatus = "<PTSCHANGESTATUSS>"
            xmlChangeStatus = xmlChangeStatus + "<ENUM id=""0"" name="""""
            If tmpChangeStatus = 0 Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
            xmlChangeStatus = xmlChangeStatus + "/>"
            xmlChangeStatus = xmlChangeStatus + "<ENUM id=""1"" name=""New"""
            If tmpChangeStatus = 1 Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
            xmlChangeStatus = xmlChangeStatus + "/>"
            For Each oSalesStep in oSalesSteps
               With oSalesStep
                  xmlChangeStatus = xmlChangeStatus + "<ENUM id=""" + .SalesStepID + """ name=""" + CleanXML(.SalesStepName) + """"
                  If tmpChangeStatus = .SalesStepID Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
                  xmlChangeStatus = xmlChangeStatus + "/>"
               End With
            Next
            xmlChangeStatus = xmlChangeStatus + "<ENUM id=""3"" name=""Fallback"""
            If tmpChangeStatus = 3 Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
            xmlChangeStatus = xmlChangeStatus + "/>"
            xmlChangeStatus = xmlChangeStatus + "<ENUM id=""4"" name=""Closed"""
            If tmpChangeStatus = 4 Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
            xmlChangeStatus = xmlChangeStatus + "/>"
            xmlChangeStatus = xmlChangeStatus + "<ENUM id=""5"" name=""Dead"""
            If tmpChangeStatus = 5 Then xmlChangeStatus = xmlChangeStatus + " selected=""True"""
            xmlChangeStatus = xmlChangeStatus + "/>"
            xmlChangeStatus = xmlChangeStatus + "</PTSCHANGESTATUSS>"


         xmlSalesSteps = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oSalesSteps = Nothing

   If (reqEmailID <> 0) Then
      Set oEmail = server.CreateObject("ptsEmailUser.CEmail")
      If oEmail Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsEmailUser.CEmail"
      Else
         With oEmail
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqEmailID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlEmail = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oEmail = Nothing
   End If
End Sub

Sub UpdateProspect()
   On Error Resume Next

   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   If oProspect Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
   Else
      With oProspect
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProspectID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpCompanyID = .CompanyID
         tmpMemberID = .MemberID
         reqEmailID = .EmailID
         tmpOldStatus = .Status
         tmpCompanyID = .CompanyID
         .Date1 = Request.Form.Item("Date1")
         .Date2 = Request.Form.Item("Date2")
         .Date3 = Request.Form.Item("Date3")
         .Date4 = Request.Form.Item("Date4")
         .Date5 = Request.Form.Item("Date5")
         .Date6 = Request.Form.Item("Date6")
         .Date7 = Request.Form.Item("Date7")
         .Date8 = Request.Form.Item("Date8")
         .Date9 = Request.Form.Item("Date9")
         .Date10 = Request.Form.Item("Date10")

         .Code = Request.Form.Item("Code")
         .MemberID = Request.Form.Item("MemberID")
         .AffiliateID = Request.Form.Item("AffiliateID")
         .CompanyID = Request.Form.Item("CompanyID")
         .ProspectName = Request.Form.Item("ProspectName")
         .ProspectTypeID = Request.Form.Item("ProspectTypeID")
         .Potential = Request.Form.Item("Potential")
         .Representing = Request.Form.Item("Representing")
         .Priority = Request.Form.Item("Priority")
         .Source = Request.Form.Item("Source")
         .Status = Request.Form.Item("Status")
         .NextEvent = Request.Form.Item("NextEvent")
         .NextDate = Request.Form.Item("NextDate")
         .NextTime = Request.Form.Item("NextTime")
         .Reminder = Request.Form.Item("Reminder")
         .RemindDate = Request.Form.Item("RemindDate")
         .CreateDate = Request.Form.Item("CreateDate")
         .FBDate = Request.Form.Item("FBDate")
         .CloseDate = Request.Form.Item("CloseDate")
         .DeadDate = Request.Form.Item("DeadDate")
         .NameFirst = Request.Form.Item("NameFirst")
         .NameLast = Request.Form.Item("NameLast")
         .Title = Request.Form.Item("Title")
         .Email = Request.Form.Item("Email")
         .Phone1 = Request.Form.Item("Phone1")
         .Phone2 = Request.Form.Item("Phone2")
         .Street = Request.Form.Item("Street")
         .Unit = Request.Form.Item("Unit")
         .City = Request.Form.Item("City")
         .State = Request.Form.Item("State")
         .Zip = Request.Form.Item("Zip")
         .Country = Request.Form.Item("Country")
         .Website = Request.Form.Item("Website")
         .NoDistribute = Request.Form.Item("NoDistribute")
         .DistributorID = Request.Form.Item("DistributorID")
         .DistributeDate = Request.Form.Item("DistributeDate")
         .Description = Request.Form.Item("Description")
         .ChangeStatus = Request.Form.Item("ChangeStatus")
         .ChangeDate = Request.Form.Item("ChangeDate")
         .EmailDate = Request.Form.Item("EmailDate")
         .EmailID = Request.Form.Item("EmailID")
         .EmailStatus = Request.Form.Item("EmailStatus")
         .NewsLetterID = Request.Form.Item("NewsLetterID")
         tmpProspectTypeID = .ProspectTypeID
         tmpSalesCampaignID = .SalesCampaignID
         tmpStatus = .Status
         tmpFirstName = .NameFirst
         tmpLastName = .NameLast
         
         If .NextEvent = 0 Then 
            .NextDate = ""
            .NextTime = ""
            .Reminder = 0
            .RemindDate = ""
         End If
         If .NextEvent > 0 Then 
            If .NextDate = "0" Then .NextDate = Date()+1
            If InStr(.NextTime, ":") = 0 AND IsNumeric(.NextTime) Then .NextTime = .NextTime + ":00"
            
            If .Reminder > 0 Then
               tmpDate = .NextDate + " " + .NextTime
               If Not IsDate(tmpDate) Then tmpDate = .NextDate
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
         End If

         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (.Status <> tmpOldStatus) Then
            If (.Status > 5) Then
               EmailStatus
            End If
            .NewStatus CLng(reqProspectID), CLng(.Status)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (xmlError <> "") Or (reqPopup <> 0) Then
               .Load CLng(reqProspectID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End If
         If (xmlError <> "") Or (reqPopup <> 0) Then
            xmlProspect = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") And (tmpOldStatus <> 4) And (.Status = 4) Then
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
            Else
               tmpServer = "http://" + reqSysServerName + reqSysServerPath
               oHTTP.open "GET", tmpServer + "0418.asp" & "?MemberID=" & .MemberID & "&Notify=" & 6 & "&ID=" & .ProspectID
               oHTTP.send
            End If
            Set oHTTP = Nothing
         End If
      End With
   End If
   Set oProspect = Nothing
   If (xmlError <> "") Or (reqPopup <> 0) Then
      LoadLists
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadProspect

   Case CLng(cActionUpdate):
      UpdateProspect
      If (xmlError = "") Then
         LoadProspect
      End If

   Case CLng(cActionUpdateExit):
      UpdateProspect

      If (xmlError = "") And (reqPopup = 0) Then
         reqReturnURL = GetCache("8103URL")
         reqReturnData = GetCache("8103DATA")
         SetCache "8103URL", ""
         SetCache "8103DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      If (reqPopup = 0) Then
         reqReturnURL = GetCache("8103URL")
         reqReturnData = GetCache("8103DATA")
         SetCache "8103URL", ""
         SetCache "8103DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionDelete):

      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqProspectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProspect = Nothing
      If (xmlError <> "") Or (reqPopup <> 0) Then
         LoadProspect
      End If

      If (xmlError = "") And (reqPopup = 0) Then
         reqReturnURL = GetCache("8103URL")
         reqReturnData = GetCache("8103DATA")
         SetCache "8103URL", ""
         SetCache "8103DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCampaign):
      UpdateProspect

      Response.Redirect "8105.asp" & "?ProspectID=" & reqProspectID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionPresent):
      UpdateProspect
      tmpCompanyID = Request.Form.Item("CompanyID")
      tmpMemberID = Request.Form.Item("MemberID")

      Response.Redirect "8112.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & tmpCompanyID & "&MemberID=" & tmpMemberID & "&Popup1=" & reqPopup & "&ReturnURL=" & reqPageURL

   Case CLng(cActionLead):
      UpdateProspect
      tmpCompanyID = Request.Form.Item("CompanyID")
      tmpMemberID = Request.Form.Item("MemberID")

      Response.Redirect "8111.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & tmpCompanyID & "&MemberID=" & tmpMemberID & "&Entity=" & 81 & "&Popup1=" & reqPopup & "&ReturnURL=" & reqPageURL

   Case CLng(cActionCopySystem):
      tmpCopyURL = ""

      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqProspectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpSalesCampaignID = .SalesCampaignID
         End With
      End If
      Set oProspect = Nothing

      Set oSalesCampaign = server.CreateObject("ptsSalesCampaignUser.CSalesCampaign")
      If oSalesCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSalesCampaignUser.CSalesCampaign"
      Else
         With oSalesCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpSalesCampaignID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCopyURL = .CopyURL
         End With
      End If
      Set oSalesCampaign = Nothing

      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqProspectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
         If (xmlError = "") Then
            s = tmpCopyURL
            s = Replace( s, "{prospectid}", Replace(.ProspectID,"&", "-") )
            s = Replace( s, "{companyid}", Replace(.CompanyID,"&", "-") )
            s = Replace( s, "{memberid}", Replace(.MemberID,"&", "-") )
            s = Replace( s, "{name}", Replace(.ProspectName,"&", "-") )
            s = Replace( s, "{first}", Replace(.NameFirst,"&", "-") )
            s = Replace( s, "{last}", Replace(.NameLast,"&", "-") )
            s = Replace( s, "{website}", Replace(.Website,"&", "-") )
            s = Replace( s, "{desc}", Replace(.Description,"&", "-") )
            s = Replace( s, "{title}", Replace(.Title,"&", "-") )
            s = Replace( s, "{email}", Replace(.Email,"&", "-") )
            s = Replace( s, "{phone1}", Replace(.Phone1,"&", "-") )
            s = Replace( s, "{phone2}", Replace(.Phone2,"&", "-") )
            s = Replace( s, "{street}", Replace(.Street,"&", "-") )
            s = Replace( s, "{unit}", Replace(.Unit,"&", "-") )
            s = Replace( s, "{city}", Replace(.City,"&", "-") )
            s = Replace( s, "{state}", Replace(.State,"&", "-") )
            s = Replace( s, "{zip}", Replace(.Zip,"&", "-") )
            s = Replace( s, "{country}", Replace(.Country,"&", "-") )
            tmpCopyURL = s
         
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               oHTTP.open "GET", tmpCopyURL
               oHTTP.send
            End If
            Set oHTTP = Nothing
         End If   

         End With
      End If
      Set oProspect = Nothing
      LoadProspect
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
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " emailid=" + Chr(34) + CStr(reqEmailID) + Chr(34)
xmlParam = xmlParam + " ismail=" + Chr(34) + CStr(reqIsMail) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " leadname=" + Chr(34) + CleanXML(reqLeadName) + Chr(34)
xmlParam = xmlParam + " presentname=" + Chr(34) + CleanXML(reqPresentName) + Chr(34)
xmlParam = xmlParam + " extra=" + Chr(34) + CStr(reqExtra) + Chr(34)
xmlParam = xmlParam + " move=" + Chr(34) + CStr(reqMove) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlSalesStep
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlProspectType
xmlTransaction = xmlTransaction +  xmlProspectTypes
xmlTransaction = xmlTransaction +  xmlSalesSteps
xmlTransaction = xmlTransaction +  xmlEmail
xmlTransaction = xmlTransaction +  xmlSalesCampaign
xmlTransaction = xmlTransaction +  xmlStatus
xmlTransaction = xmlTransaction +  xmlChangeStatus
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Prospect[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Prospect[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8103 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8103 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8103 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

s = "<TAB name=""ProspectTab"">"
s=s+   "<ITEM label=""ViewSalesStatus"" width=""90"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabSalesSteps',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""ViewContactInfo"" width=""90"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabContactInfo',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""ViewDescription"" width=""82"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabDescription',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Notes"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabNotes',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Events"" width=""82"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabEvents',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Mail"" width=""70"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabMail',1))""/>"
s=s+   "</ITEM>"
s=s+   "<ITEM label=""Documents"" width=""82"">"
s=s+      "<LINK name=""JAVA(ShowTab('TabDocuments',1))""/>"
s=s+   "</ITEM>"
s=s+"</TAB>"
xmlProspectTab = s

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
xmlData = xmlData +  xmlProspectTab
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "8103.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8103 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8103 Load file (oData) failed with error code " + CStr(oData.parseError)
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