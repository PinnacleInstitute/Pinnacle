<!--#include file="Include\System.asp"-->
<!--#include file="Include\Resources.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAddAnother = 1
Const cActionAdd = 2
Const cActionCancel = 3
Const cActionProspects = 4
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
Dim oPages, xmlPages
Dim oLeadCampaigns, xmlLeadCampaigns
Dim oProspect, xmlProspect
Dim oLeadPage, xmlLeadPage
Dim oMember, xmlMember
Dim oHTMLFile, xmlHTMLFile
Dim oLeadCampaign, xmlLeadCampaign
Dim oCompany, xmlCompany
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqProspectID
Dim reqMemberEmail
Dim reqLeadCampaignID
Dim reqAdded
Dim reqLeadPageID
Dim reqContentPage
Dim reqPopup
Dim reqPopup1
Dim reqNameFirst
Dim reqNameLast
Dim reqEmail
Dim reqPhone
Dim reqSubject
Dim reqTemplateID
Dim reqEntity
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
   SetCache "8111URL", reqReturnURL
   SetCache "8111DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "8111")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
reqMemberEmail =  GetInput("MemberEmail", reqPageData)
reqLeadCampaignID =  Numeric(GetInput("LeadCampaignID", reqPageData))
reqAdded =  Numeric(GetInput("Added", reqPageData))
reqLeadPageID =  Numeric(GetInput("LeadPageID", reqPageData))
reqContentPage =  Numeric(GetInput("ContentPage", reqPageData))
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqPopup1 =  Numeric(GetInput("Popup1", reqPageData))
reqNameFirst =  GetInput("NameFirst", reqPageData)
reqNameLast =  GetInput("NameLast", reqPageData)
reqEmail =  GetInput("Email", reqPageData)
reqPhone =  GetInput("Phone", reqPageData)
reqSubject =  GetInput("Subject", reqPageData)
reqTemplateID =  Numeric(GetInput("TemplateID", reqPageData))
reqEntity =  Numeric(GetInput("Entity", reqPageData))
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

Sub LoadList()
   On Error Resume Next
   tmpGroupID = Numeric(GetCache("GROUPID"))
   If (reqSysUserGroup <> 41) Then
      tmpGroupID = reqMemberID
      GetResources tmpGroupID
   End If
   tmpGroupID1 = 0
   tmpGroupID2 = 0
   tmpGroupID3 = 0
   tmpResource = 10
   If (tmpGroupID <> 0) Then
      GetResource tmpResource, tmpGroupID1, tmpGroupID2, tmpGroupID3
   End If

   Set oPages = server.CreateObject("ptsPageUser.CPages")
   If oPages Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPages"
   Else
      With oPages
         .SysCurrentLanguage = reqSysLanguage
         xmlPages = .EnumPage(CLng(reqCompanyID), tmpGroupID, tmpGroupID1, tmpGroupID2, tmpGroupID3, 3)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPages = Nothing
   tmpResource = 2
   If (tmpGroupID <> 0) Then
      GetResource tmpResource, tmpGroupID1, tmpGroupID2, tmpGroupID3
   End If

   Set oLeadCampaigns = server.CreateObject("ptsLeadCampaignUser.CLeadCampaigns")
   If oLeadCampaigns Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaigns"
   Else
      With oLeadCampaigns
         .SysCurrentLanguage = reqSysLanguage
         xmlLeadCampaigns = .EnumMember(CLng(reqCompanyID), tmpGroupID, tmpGroupID1, tmpGroupID2, tmpGroupID3, CLng(reqMemberID), CLng(reqLeadCampaignID), , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadCampaigns = Nothing

   If (reqProspectID <> 0) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqProspectID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpProspectName = .ProspectName
            tmpStreet = .Street + " " + .Unit
            tmpCity = .City
            tmpState = .State
            tmpZip = .Zip
            tmpCountry = .Country
            tmpNameFirst = .NameFirst
            tmpNameLast = .NameLast
            tmpEmail = .Email
            tmpPhone = .Phone1
            If (.NextEvent <> 0) Then
               tmpEvent = .NextDate + " " + .NextTime
            End If
            xmlProspect = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oProspect = Nothing
   End If

   If (reqLeadCampaignID <> 0) Then
      Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
      If oLeadPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
      Else
         With oLeadPage
            .SysCurrentLanguage = reqSysLanguage
            .FetchEmail CLng(reqLeadCampaignID), reqSysLanguage
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqLeadPageID = .LeadPageID
            reqSubject = .LeadPageName
         End With
      End If
      Set oLeadPage = Nothing
   End If

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqMemberEmail = .Email
            tmpSignature = .Signature
            tmpMFirstname = .NameFirst
            tmpMLastname = .NameLast
            tmpMEmail = .Email
            tmpMPhone = .Phone1
            tmpMID = .MemberID
            If (reqLeadCampaignID <> 0) Then
               Signature = .GetSignature(CLng(reqMemberID), 4, 0, reqSysLanguage)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (Signature <> "") Then
                  tmpSignature = Signature
               End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqLeadPageID <> 0) And (reqTemplateID = 0) Then
      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = "Lead" & reqLeadPageID & ".htm"
            .Path = reqSysWebDirectory + "Sections\Company\" + CSTR(reqCompanyID) + "\Lead\"
            .Language = "en"
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Data = .Data + tmpBody
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
   End If
   If (reqTemplateID <> 0) Then

      Set oPage = server.CreateObject("ptsPageUser.CPage")
      If oPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPage"
      Else
         With oPage
            .SysCurrentLanguage = reqSysLanguage
            .Load reqTemplateID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqSubject = .Subject
         End With
      End If
      Set oPage = Nothing

      If (reqTemplateID <> 0) Then
         Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
         If oHTMLFile Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
         Else
            With oHTMLFile
               .Filename = reqTemplateID & ".htm"
               .Path = reqSysWebDirectory + "Pages\"
               .Language = reqSysLanguage
               .Project = SysProject
               .Load 
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlHTMLFile = .XML()
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oHTMLFile = Nothing
      End If
   End If
   
         xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", CleanXMLComment(tmpSignature) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-firstname}", CleanXMLComment(tmpMFirstname) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-lastname}", CleanXMLComment(tmpMLastname) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-email}", CleanXMLComment(tmpMEmail) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-phone}", CleanXMLComment(tmpMPhone) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", tmpMID )
         xmlHTMLFile = Replace( xmlHTMLFile, "{companyname}", CleanXMLComment(tmpProspectName) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{street}", CleanXMLComment(tmpStreet) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{city}", CleanXMLComment(tmpCity) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{state}", CleanXMLComment(tmpState) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{zip}", CleanXMLComment(tmpZip) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{country}", CleanXMLComment(tmpCountry) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{firstname}", CleanXMLComment(tmpNameFirst) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{lastname}", CleanXMLComment(tmpNameLast) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{email}", CleanXMLComment(tmpEmail) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{phone}", CleanXMLComment(tmpPhone) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{event}", CleanXMLComment(tmpEvent) )
         xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqProspectID )

End Sub

Sub AddProspect()
   On Error Resume Next
   If (reqLeadCampaignID = 0) Then
      DoError -2147220518, "", "Oops, Please select a Lead Page to email to the new prospects."
   End If
   If (reqProspectID = 0) Then
      If (xmlError = "") And (reqNameFirst = "") Then
         DoError -2147220519, "", "Oops, Please enter a new prospect first name."
      End If
      If (xmlError = "") And (reqNameLast = "") Then
         DoError -2147220520, "", "Oops, Please enter a new prospect last name."
      End If
      If (xmlError = "") And ((reqEmail = "") Or (InStr(reqEmail,"@") = 0)) Then
         DoError -2147220521, "", "Oops, Please enter a valid new prospect email address."
      End If
   End If

   If (xmlError = "") And (reqLeadCampaignID <> 0) Then
      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqLeadCampaignID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpLeadCampaignName = .LeadCampaignName
            tmpNewsLetterID = .NewsLetterID
            tmpSalesCampaignID = .SalesCampaignID
            tmpProspectTypeID = .ProspectTypeID
         End With
      End If
      Set oLeadCampaign = Nothing
   End If

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqCompanyID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpSender = .Email
      End With
   End If
   Set oCompany = Nothing

   If (xmlError = "") And (reqLeadCampaignID <> 0) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            If (reqProspectID <> 0) Then
               .Load CLng(reqProspectID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqProspectID <> 0) Then
               reqNameFirst = .NameFirst
               reqNameLast = .NameLast
               reqEmail = .Email
               reqPhone = .Phone1
            End If
            If (reqProspectID = 0) Then
               .CompanyID = reqCompanyID
               .MemberID = reqMemberID
               .Status = 1
               If (reqEntity = 22) Then
                  .Status = -1
               End If
               .CreateDate = reqSysDate
               .NewsLetterID = tmpNewsLetterID
               .SalesCampaignID = tmpSalesCampaignID
               .LeadCampaignID = reqLeadCampaignID
               .ProspectTypeID = tmpProspectTypeID
            End If
            
         If reqEmail <> "" And InStr(reqEmail, "@") <> 0 Then
            reqAdded = 1
            If reqProspectID = 0 Then
               .NameFirst = reqNameFirst
               .NameLast = reqNameLast
               .Phone1 = reqPhone
               .Email = reqEmail
               .ProspectName = reqNameFirst + " " + reqNameLast
               ProspectID = CLng(.Add(CLng(reqSysUserID)))
            Else
               If .LeadCampaignID <> 0 Then
                  tmpNotes = .LeadCampaignID & " Views:" &.LeadViews & " Replies:" & .LeadReplies
               Else
                  tmpNotes = ""
               End If   
               .LeadCampaignID = reqLeadCampaignID
               .LeadViews = 0
               .LeadPages = ""
               .LeadReplies = 0
               .Save CLng(reqSysUserID)
               ProspectID = reqProspectID
            End If
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

            tmpSubject = Replace( reqSubject, "{firstname}", reqNameFirst )
            tmpSubject = Replace( tmpSubject, "{lastname}", reqNameLast )

            tmpFrom = trim(Request.Form.Item("MemberEmail"))
            tmpTo = reqEmail
            tmpBody = Request.Form.Item("Data")
            reqLink = "http://" + reqSysServerName + reqSysServerPath + "lp.asp?p=" & reqLeadCampaignID & "&m=" & reqMemberID & "&r=" & ProspectID
            tmpBody = Replace( tmpBody, "{link}", reqLink )

            SendEmail reqSysCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody

            Set oNote = server.CreateObject("ptsNoteUser.CNote")
            If oNote Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
            Else
               With oNote
               .SysCurrentLanguage = reqSysLanguage
               .Load 0, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If reqProspectID = 0 OR tmpNotes = "" Then
                     If reqEntity = 22 Then
                        .Notes = "EMAILED Lead Page, " + tmpLeadCampaignName + ", to contact"
                     Else
                        .Notes = "EMAILED Lead Page, " + tmpLeadCampaignName + ", to prospect"
                     End If
                  Else
                     .Notes = "CHANGED Lead Page #" & tmpNotes
                  End If
                  .AuthUserID = 1
                  .NoteDate = Now
                  .OwnerType = reqEntity
                  .OwnerID = ProspectID
                  NoteID = CLng(.Add(CLng(reqSysUserID)))
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oNote = Nothing

         End If

         End With
      End If
      Set oProspect = Nothing
   End If
End Sub

If (reqSysUserGroup = 41) And (InStr(reqSysUserOptions,"Z") = 0) Then

   Response.Redirect "0419.asp" & "?CompanyID=" & reqCompanyID & "&Error=" & 1
End If
If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
If (reqSysUserGroup > 23) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If
If (reqEntity = 0) Then
   reqEntity = 81
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadList

   Case CLng(cActionAddAnother):
      AddProspect
      LoadList
      If (xmlError = "") Then
         reqNameFirst = ""
         reqNameLast = ""
         reqEmail = ""
         reqPhone = ""
      End If

   Case CLng(cActionAdd):
      AddProspect
      If (xmlError <> "") Or (reqPopup <> 0) Then
         LoadList
      End If
      If (xmlError = "") And (reqPopup = 0) And (reqProspectID <> 0) Then

         If (reqEntity = 81) Then
            Response.Redirect "8103.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & reqCompanyID & "&MemberID=" & reqMemberID & "&Popup=" & reqPopup1
         End If

         If (reqEntity = 22) Then
            Response.Redirect "8163.asp" & "?ProspectID=" & reqProspectID & "&CompanyID=" & reqCompanyID & "&MemberID=" & reqMemberID
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("8111URL")
      reqReturnData = GetCache("8111DATA")
      SetCache "8111URL", ""
      SetCache "8111DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionProspects):

      If (reqEntity = 81) Then
         Response.Redirect "8101.asp" & "?CompanyID=" & reqCompanyID & "&MemberID=" & reqMemberID & "&ContentPage=" & reqContentPage & "&Popup=" & reqPopup
      End If

      If (reqEntity = 22) Then
         Response.Redirect "8161.asp" & "?CompanyID=" & reqCompanyID & "&MemberID=" & reqMemberID
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " memberemail=" + Chr(34) + CleanXML(reqMemberEmail) + Chr(34)
xmlParam = xmlParam + " leadcampaignid=" + Chr(34) + CStr(reqLeadCampaignID) + Chr(34)
xmlParam = xmlParam + " added=" + Chr(34) + CStr(reqAdded) + Chr(34)
xmlParam = xmlParam + " leadpageid=" + Chr(34) + CStr(reqLeadPageID) + Chr(34)
xmlParam = xmlParam + " contentpage=" + Chr(34) + CStr(reqContentPage) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " popup1=" + Chr(34) + CStr(reqPopup1) + Chr(34)
xmlParam = xmlParam + " namefirst=" + Chr(34) + CleanXML(reqNameFirst) + Chr(34)
xmlParam = xmlParam + " namelast=" + Chr(34) + CleanXML(reqNameLast) + Chr(34)
xmlParam = xmlParam + " email=" + Chr(34) + CleanXML(reqEmail) + Chr(34)
xmlParam = xmlParam + " phone=" + Chr(34) + CleanXML(reqPhone) + Chr(34)
xmlParam = xmlParam + " subject=" + Chr(34) + CleanXML(reqSubject) + Chr(34)
xmlParam = xmlParam + " templateid=" + Chr(34) + CStr(reqTemplateID) + Chr(34)
xmlParam = xmlParam + " entity=" + Chr(34) + CStr(reqEntity) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPages
xmlTransaction = xmlTransaction +  xmlLeadCampaigns
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\8111[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\8111[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "8111 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "8111 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "8111 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "8111.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "8111 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "8111 Load file (oData) failed with error code " + CStr(oData.parseError)
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