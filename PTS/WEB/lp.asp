<!--#include file="Include\System.asp"-->
<!--#include file="Include\InputOptions.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionAdd = 1
Const cActionThanks = 3
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oMember, xmlMember
Dim oCompany, xmlCompany
Dim oLeadCampaign, xmlLeadCampaign
Dim oLeadPage, xmlLeadPage
Dim oHTMLFile, xmlHTMLFile
Dim oProspect, xmlProspect
Dim oLeadLog, xmlLeadLog
'-----declare page parameters
Dim reqp
Dim reqm
Dim reqa
Dim reqr
Dim reql
Dim reqx
Dim reqLeadPageID
Dim reqNewsLetterID
Dim reqAddLeadPageID
Dim reqPreview
Dim reqLog
Dim reqTest
Dim reqc
Dim reqi
Dim reqs
Dim reqz
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

reqSysTestFile = GetInput("SysTestFile", reqPageData)
If Len(reqSysTestFile) > 0 Then
   SetCache "SYSTESTFILE", reqSysTestFile
Else
   reqSysTestFile = GetCache("SYSTESTFILE")
End If

reqActionCode = Numeric(GetInput("ActionCode", reqPageData))
reqSysDate = CStr(Date())
reqSysTime = CStr(Time())
reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))
reqSysServerName = Request.ServerVariables("SERVER_NAME")
reqSysWebDirectory = Request.ServerVariables("APPL_PHYSICAL_PATH")
reqSysServerPath = Request.ServerVariables("PATH_INFO")
pos = InStr(LCASE(reqSysServerPath), "lp")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqp =  Numeric(GetInput("p", reqPageData))
reqm =  Numeric(GetInput("m", reqPageData))
reqa =  Numeric(GetInput("a", reqPageData))
reqr =  Numeric(GetInput("r", reqPageData))
reql =  GetInput("l", reqPageData)
reqx =  GetInput("x", reqPageData)
reqLeadPageID =  Numeric(GetInput("LeadPageID", reqPageData))
reqNewsLetterID =  Numeric(GetInput("NewsLetterID", reqPageData))
reqAddLeadPageID =  Numeric(GetInput("AddLeadPageID", reqPageData))
reqPreview =  Numeric(GetInput("Preview", reqPageData))
reqLog =  Numeric(GetInput("Log", reqPageData))
reqTest =  Numeric(GetInput("Test", reqPageData))
reqc =  Numeric(GetInput("c", reqPageData))
reqi =  GetInput("i", reqPageData)
reqs =  GetInput("s", reqPageData)
reqz =  Numeric(GetInput("z", reqPageData))
xmlTOP = ""
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

Sub Redirect()
   On Error Resume Next

   Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
   If oCompany Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
   Else
      With oCompany
         .SysCurrentLanguage = reqSysLanguage
         ReferralID = CLng(.Custom(reqc, 14, 0, reqm, 0))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCompany = Nothing
   
         Response.Redirect "lp.asp?p=" + CStr(reqp) + "&m=" + CStr(ReferralID)

End Sub

Sub LoadPage()
   On Error Resume Next

   Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
   If oLeadCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
   Else
      With oLeadCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load reqp, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqc = .CompanyID
         tmpCompanyID = .CompanyID
         tmpLeadCampaignName = .LeadCampaignName
         If (reqm = 0) Then
            reqm = .CycleID
         End If
         
         If (.Status <> 2) And (reqPreview = 0) Then
            Response.write "Website Not Active"
            Response.end
         End If
         
         xmlHead = "<HEAD"
         If .css <> "" Then xmlHead = xmlHead + " css=""" + .css + """"
         If .title = "" Then
            xmlHead = xmlHead + " robots=""NONE"""
         Else
            xmlHead = xmlHead + " title=""" + .title + """"
            If .description <> "" Then xmlHead = xmlHead + " description=""" + .description + """"
            If .keywords <> "" Then xmlHead = xmlHead + " keywords=""" + .keywords + """"
         End If
         xmlHead = xmlHead + "/>"

      End With
   End If
   Set oLeadCampaign = Nothing

   Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
   If oLeadPage Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
   Else
      With oLeadPage
         .SysCurrentLanguage = reqSysLanguage
         If (reqLeadPageID = 0) Then
            reqLeadPageID = CLng(.NextPage(reqp, reqLeadPageID, tmpLanguage))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         tmpLeadPageID = reqLeadPageID
         reqAddLeadPageID = reqLeadPageID
         tmpLeadPage = ""
         .Load reqLeadPageID, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlTOP = "<TOP><!--" + .TopCode + "--></TOP>"
         tmpLeadPage = .Seq
         xmlLeadPage = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqLeadPageID = CLng(.NextPage(reqp, reqLeadPageID, tmpLanguage))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadPage = Nothing

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Lead" & tmpLeadPageID & ".htm"
         .Path = reqSysWebDirectory + "Sections\Company\" + CSTR(tmpCompanyID) + "\Lead\" 
         .Language = tmpLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
   If (reqPreview = 0) Then
      tmpSignature = ""
      tmpName = ""
      tmpEmail = ""
      tmpPhone = ""
      tmpImage = "images/blank.gif"
      tmpRef = ""
      tmpLogon = ""
      tmpProspectName = ""
      tmpStreet = ""
      tmpCity = ""
      tmpState = ""
      tmpZip = ""
      tmpCountry = ""
      tmpPFirstName = ""
      tmpPLastName = ""
      tmpPEmail = ""
      tmpPPhone = ""
   End If
   If (reqPreview <> 0) Then
      tmpSignature = "ACME Corporation<BR>John Smith<BR>johns@aol.com<BR>(123)456-7890"
      tmpName = "ACME Corporation"
      tmpEmail = "johns@aol.com"
      tmpPhone = "(123)456-7890"
      tmpImage = "images/blank.gif"
      tmpRef = "123"
      tmpLogon = "peter"
      tmpProspectName = "Ranch Market"
      tmpStreet = "123 Main Street"
      tmpCity = "Dallas"
      tmpState = "Texas"
      tmpZip = "75001"
      tmpCountry = "United States"
      tmpPFirstName = "Peter"
      tmpPLastName = "Prospect"
      tmpPEmail = "peterp@aol.com"
      tmpPPhone = "(987)123-4567"
   End If
   If (reqz = 0) Then
      reqSysUserGroup = GetCache("USERGROUP")

      If (reqSysUserGroup = "") Or (reqSysUserGroup < 1) Or (reqSysUserGroup > 23) Then
         Set oAuthLog = server.CreateObject("ptsAuthLogUser.CAuthLog")
         If oAuthLog Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthLogUser.CAuthLog"
         Else
            With oAuthLog
               .SysCurrentLanguage = reqSysLanguage
               tmpIP = Request.ServerVariables("REMOTE_ADDR")
               reqm = CLng(.LogLead(tmpIP, reqm))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oAuthLog = Nothing
      End If
   End If

   If (reqm <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqm, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqc = .CompanyID
            If (.Status < 1) Or (.Status > 4) Then
               Redirect
            End If
            tmpSignature = .Signature
            If (.IsCompany = 0) Then
               tmpName = .NameFirst + " " + .NameLast
            End If
            If (.IsCompany <> 0) Then
               tmpName = .CompanyName
            End If
            tmpEmail = .Email
            tmpEmail2 = .Email2
            tmpPhone = .Phone1
            If (.Image <> "") Then
               tmpImage = "images/member/" + .Image
            End If
            If (.Image = "") Then
               tmpImage = "images/blank.gif"
            End If
            tmpLogon = .Logon
            If (reqp <> 0) Then
               Signature = .GetSignature(reqm, 2, reqp, reqSysLanguage)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (Signature <> "") Then
                  tmpSignature = Signature
               End If
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqr <> 0) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load reqr, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpProspectName = .ProspectName
            tmpStreet = .Street + " " + .Unit
            tmpCity = .City
            tmpState = .State
            tmpZip = .Zip
            tmpCountry = .Country
            tmpPFirstName = .NameFirst
            tmpPLastName = .NameLast
            tmpPEmail = .Email
            tmpPPhone = .Phone1
            If (.Status < 0) Then
               tmpEntity = 22
            End If
            If (.Status >= 0) Then
               tmpEntity = 81
            End If
            tmpLeadView = GetCache("LEADVIEW")
            If (tmpLeadPage <> "") Then
               If (tmpLeadView <> 1) Then
                  SetCache "LEADVIEW", 1
                  .LeadViews = .LeadViews + 1
                  
                        If CLng(.LeadViews) <= 10 Then
                           tmpSubject = " PROSPECT VIEWING LEAD PAGE: " + tmpPFirstName + " " + tmpPLastName + " - " + tmpPPhone + " (" + CStr(.LeadViews) + " times)"
                           tmpBody = tmpLeadCampaignName
                           SendEmail reqCompanyID, tmpEmail2, tmpEmail2, tmpEmail2, "", "", tmpSubject, tmpBody
                        End If

'                  Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
'                  If oHTTP Is Nothing Then
'                     Response.Write "Error #" & Err.number & " - " + Err.description
'                  Else
'                     oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "8133.asp?Lead=1&ProspectID=" & reqr
'                     oHTTP.send
'                  End If
'                  Set oHTTP = Nothing
                  
                  If (.LeadViews = 1) Then
                     Set oNote = server.CreateObject("ptsNoteUser.CNote")
                     If oNote Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
                     Else
                        With oNote
                           .SysCurrentLanguage = reqSysLanguage
                           .Notes = "FIRST VIEWED Lead Website: " + tmpLeadCampaignName
                           .AuthUserID = 1
                           .NoteDate = Now
                           .OwnerType = tmpEntity
                           .OwnerID = reqr
                           NoteID = CLng(.Add(1))
                           If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        End With
                     End If
                     Set oNote = Nothing
                  End If   

               End If
               
               tmpLeadPages = .LeadPages
               If InStr(tmpLeadPages, tmpLeadPage) = 0 Then
                  If tmpLeadPages  <> "" Then tmpLeadPages = tmpLeadPages + ","
                  tmpLeadPages = tmpLeadPages + tmpLeadPage
                  .LeadPages = tmpLeadPages
               End If

               .Save 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
         End With
      End If
      Set oProspect = Nothing
   End If
   
      xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", CleanXMLComment(tmpSignature) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-name}", CleanXMLComment(tmpName) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-email}", CleanXMLComment(tmpEmail) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-phone}", CleanXMLComment(tmpPhone) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-image}", CleanXMLComment(tmpImage) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", reqM )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-ref}", CleanXMLComment(tmpRef) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-s}", CleanXMLComment(reqS) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-logon}", CleanXMLComment(tmpLogon) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{companyname}", CleanXMLComment(tmpProspectName) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{street}", CleanXMLComment(tmpStreet) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{city}", CleanXMLComment(tmpCity) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{state}", CleanXMLComment(tmpState) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{zip}", CleanXMLComment(tmpZip) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{country}", CleanXMLComment(tmpCountry) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{firstname}", CleanXMLComment(tmpPFirstName) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{lastname}", CleanXMLComment(tmpPLastName) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{email}", CleanXMLComment(tmpPEmail) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{phone}", CleanXMLComment(tmpPPhone) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqR )
      
      pos = InStr( xmlHTMLFile, "{scrolltext}" )
      If pos > 0 Then
         tmpText = ""
         If reqc > 0 Then
            Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
            If oMembers Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
            Else
               With oMembers
                  .SysCurrentLanguage = reqSysLanguage
                  .NewMembers reqc
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

                  For Each oMember in oMembers
                     tmpText = tmpText + "<BR>" + oMember.Identification
                  Next
               End With
            End If
            Set oMembers = Nothing
         End If
         xmlHTMLFile = Replace( xmlHTMLFile, "{scrolltext}", tmpText )
      End If

End Sub

Sub AddLog()
   On Error Resume Next

   Set oLeadLog = server.CreateObject("ptsLeadLogUser.CLeadLog")
   If oLeadLog Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadLogUser.CLeadLog"
   Else
      With oLeadLog
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .LeadPageID = reqAddLeadPageID
         .MemberID = reqm
         .AffiliateID = reqa
         .LogDate = Now
         LeadLogID = CLng(.Add(1))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadLog = Nothing
End Sub

If (reqm = 0) And (reqc <> 0) And (reqi <> "") Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .FetchRef reqc, reqi
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.MemberID <> 0) Then
            reqm = .MemberID
         End If
      End With
   End If
   Set oMember = Nothing
End If
If (reqm = 0) And (reqSysMemberID <> 0) Then
   reqm = reqSysMemberID
End If
If (reqm <> 0) Then
   SetCache "A", reqm
End If
If (reqm = 0) Then
   ReferralID = GetCache("A")
   If (ReferralID <> "") Then
      reqm = ReferralID
   End If
End If
If (reqActionCode = 0) Then
   reqLog = 1
End If
If (reqActionCode = 2) Then
   reqLeadPageID = Request.Form.Item("LeadPageID")
   reqActionCode = 0
   If (reqLeadPageID <> 0) Then
      reqLog = 1
   End If
End If
tmpLanguage = reql
If (tmpLanguage = "") Then
   tmpLanguage = reqSysLanguage
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadPage
      If (reqLog <> 0) And (reqPreview = 0) Then
         AddLog
      End If

   Case CLng(cActionAdd):
      If (reqPreview = 0) Then
         ProspectID = 0
         reqLeadPageID = Request.Form.Item("AddLeadPageID")

         Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
         If oLeadCampaign Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
         Else
            With oLeadCampaign
               .SysCurrentLanguage = reqSysLanguage
               .Load reqp, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqNewsLetterID = .NewsLetterID
               tmpCompanyID = .CompanyID
               tmpSalesCampaignID = .SalesCampaignID
               tmpProspectTypeID = .ProspectTypeID
               tmpFolderID = .FolderID
               tmpEntity = .Entity
               
               'If there is no member specified, look for a cycle member.
               If reqm = 0 Then
                  If IsNumeric(.CycleID) Then reqm = CLng(.CycleID)
                  'If there is a cycle of member #s
                  If Len(.Cycle) > 0 Then
                     ID = Split(.Cycle, ",")
                     'If there still is no member, get the first in the cycle
                     If reqm = 0 Then reqm = x(ID)
                     'Set the next member #
                        .CycleID = ""
                     For x = 0 to Ubound(ID)
                        If CStr(reqm) = ID(x) Then
                           'If we are at the end of the list, go to the first item, else use the next
                           If x = Ubound(ID) Then .CycleID = ID(0) Else .CycleID = ID(x+1)
                           x = Ubound(ID) + 1
                        End If
                     Next 
                     'If we didn't find the # in the list, set to the first #
                     If Len(.CycleID) = 0 Then .CycleID = ID(0)
                     .Save(1)
                  End If
               End If

            End With
         End If
         Set oLeadCampaign = Nothing

         Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
         If oLeadPage Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
         Else
            With oLeadPage
               .SysCurrentLanguage = reqSysLanguage
               .Load reqLeadPageID, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpIsProspect = .IsProspect
               tmpIsLeadURL = .IsLeadURL
               tmpLeadURL = .LeadURL
               tmpIsRedirectURL = .IsRedirectURL
               tmpRedirectURL = .RedirectURL
               
   tmpCompany = ""
   tmpLastName = ""
   tmpFirstName = ""
   tmpTitle = ""
   tmpEmail = ""
   tmpPhone1 = ""
   tmpPhone2 = ""
   tmpStreet = ""
   tmpUnit = ""
   tmpCity = ""
   tmpState = ""
   tmpZip = ""
   tmpCountry = ""
   tmpWebsite = ""
   tmpBestTime = ""
   tmpTimeZone = ""
   tmpDescription = ""
   If (reqx <> "") Then tmpDescription = "x=" + reqx + "; "
               If (tmpIsLeadURL <> 0) Then
                  tmpLeadURL = Replace(tmpLeadURL, "{x}", reqx )
                  tmpLeadURL = Replace(tmpLeadURL, "{m}", reqm )
               End If   
               If (tmpIsRedirectURL <> 0) Then
                  tmpRedirectURL = Replace(tmpRedirectURL, "{x}", reqx )
                  tmpRedirectURL = Replace(tmpRedirectURL, "{m}", reqm )
               End If   
               Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
               oInputOptions.Load .Inputs, ""
               Total = oInputOptions.Count
IF reqTest = 1 Then Response.write "<BR>TEST MODE: " & Total & " custom fields"
               If Total > 0 Then
                  For x = 1 to Total
                     Nam = oInputOptions.Item(x).Name
                     data = Request.Form.Item(Nam)
IF reqTest = 1 Then Response.write "<BR>" + Nam + "=" + data
   oInputOptions.Item(x).Value = data
   Select Case LCase(Replace(Nam, " ", "" ))
   Case "company":   tmpCompany = Left(data, 60)
   Case "lastname":  tmpLastName = Left(data, 30)
   Case "firstname": tmpFirstName = Left(data, 30)
   Case "title":     tmpTitle = Left(data, 30)
   Case "email":     tmpEmail = Left(data, 80)
   Case "phone":     tmpPhone1 = Left(data, 30)
   Case "phone2":    tmpPhone2 = Left(data, 30)
   Case "street":    tmpStreet = Left(data, 60)
   Case "unit":      tmpUnit = Left(data, 40)
   Case "city":      tmpCity = Left(data, 30)
   Case "state":     tmpState = Left(data, 30)
   Case "zip":       tmpZip = Left(data, 20)
   Case "country":   tmpCountry = Left(data, 30)
   Case "website":   tmpWebsite = Left(data, 80)
   Case "besttime":   tmpBestTime = data
   Case "timezone":   tmpTimeZone = data
   Case Else
   tmpDescription = tmpDescription + Nam + "=" + data + "; "
   End Select

   If (tmpIsLeadURL <> 0) Then
                        tmpLeadURL = Replace(tmpLeadURL, "{" + Nam + "}", data )
                     End If
                     If (tmpIsRedirectURL <> 0) Then
                        tmpRedirectURL = Replace(tmpRedirectURL, "{" + Nam + "}", data )
                     End If
                  Next
               End If
IF reqTest = 1 Then Response.end
               oInputOptions.Validate
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               Set oInputOptions = Nothing

               If tmpCompany = "" Then tmpCompany = Trim(tmpFirstName + " " + tmpLastName)
               If tmpCompany = "" And reqr = 0 Then tmpCompany = "NONE"

               ThanksPageID = CLng(.ThanksPage(reqp, tmpLanguage))
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oLeadPage = Nothing

         If (xmlError = "") And (tmpIsProspect <> 0) Then
            Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
            If oProspect Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
            Else
               With oProspect
                  .SysCurrentLanguage = reqSysLanguage
                  If (reqr = 0) Then
                     .Load 0, 1
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (reqr <> 0) Then
                     .Load reqr, 1
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (reqa <> 0) Then
                     .AffiliateID = reqa
                  End If
                  If (reqr = 0) Then
                     .CompanyID = tmpCompanyID
                     .MemberID = reqm
                     .CreateDate = Now
                     .LeadViews = 1
                  End If
                  .NewsLetterID = reqNewsLetterID
                  If (reqNewsLetterID <> 0) Then
                     .EmailStatus = 1
                  End If
                  ProspectID = reqr
                  .LeadCampaignID = reqp
                  .SalesCampaignID = tmpSalesCampaignID
                  .ProspectTypeID = tmpProspectTypeID
                  .Status = 1
                  If (tmpEntity = 22) Then
                     .Status = -1
                  End If
                  If (tmpCompany <> "") Then
                     .ProspectName = tmpCompany
                  End If
                  If (tmpLastName <> "") Then
                     .NameLast = tmpLastName
                  End If
                  If (tmpFirstName <> "") Then
                     .NameFirst = tmpFirstName
                  End If
                  If (tmpTitle <> "") Then
                     .Title = tmpTitle
                  End If
                  If (tmpEmail <> "") Then
                     .Email = tmpEmail
                  End If
                  If (tmpPhone1 <> "") Then
                     .Phone1 = tmpPhone1
                  End If
                  If (tmpPhone2 <> "") Then
                     .Phone2 = tmpPhone2
                  End If
                  If (tmpStreet <> "") Then
                     .Street = tmpStreet
                  End If
                  If (tmpUnit <> "") Then
                     .Unit = tmpUnit
                  End If
                  If (tmpCity <> "") Then
                     .City = tmpCity
                  End If
                  If (tmpState <> "") Then
                     .State = tmpState
                  End If
                  If (tmpZip <> "") Then
                     .Zip = tmpZip
                  End If
                  If (tmpCountry <> "") Then
                     .Country = tmpCountry
                  End If
                  If (tmpWebsite <> "") Then
                     .Website = tmpWebsite
                  End If
                  If (IsNumeric(tmpBestTime) <> 0) Then
                     .BestTime = tmpBestTime
                  End If
                  If (IsNumeric(tmpTimeZone) <> 0) Then
                     .TimeZone = tmpTimeZone
                  End If
                  If (tmpDescription <> "") Then
                     .Description = .Description + " " + tmpDescription
                  End If
                  .LeadReplies = .LeadReplies + 1
                  If (reqr = 0) Then
                     tmpPlayProgress = Request.Form.Item("PlayProgress")
                     If (tmpPlayProgress <> "") Then
                        .Description = .Description + tmpPlayProgress + "; "
                     End If
                  End If
                  If (reqr = 0) Then
                     ProspectID = CLng(.Add(1))
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
                  If (reqr <> 0) Then
                     .Save 1
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
               End With
            End If
            Set oProspect = Nothing
         End If

         If (xmlError = "") And (tmpIsProspect <> 0) Then
            Set oCompany = server.CreateObject("ptsCompanyUser.CCompany")
            If oCompany Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - ptsCompanyUser.CCompany"
            Else
               With oCompany
                  .SysCurrentLanguage = reqSysLanguage
                  .Load tmpCompanyID, 1
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  tmpCompanyEmail = .Email
               End With
            End If
            Set oCompany = Nothing
         End If
         If (xmlError = "") And (tmpFolderID <> 0) Then
            Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
            If oHTTP Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
            Else
               tmpServer = "http://" + reqSysServerName + reqSysServerPath
               oHTTP.open "GET", tmpServer + "12502.asp" & "?FolderID=" & tmpFolderID & "&MemberID=" & reqm & "&Entity=" & tmpEntity & "&ItemID=" & ProspectID
               oHTTP.send
            End If
            Set oHTTP = Nothing
         End If
         
         If (xmlError = "") Then
            If  (reqm <> 0) And (tmpIsProspect <> 0) Then
               tmpSubject = "NEW PROSPECT: " + tmpFirstName + " " + tmpLastName + " - " + tmpPhone1
               tmpBody = ""
               SendEmail reqCompanyID, tmpCompanyEmail, tmpCompanyEmail, tmpEmail2, "", "", tmpSubject, tmpBody
            End If

         Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
         If oHTTP Is Nothing Then
         Response.Write "Error #" & Err.number & " - " + Err.description
            Else
               'send an email to the member if we added a new prospect
'               If  (reqm <> 0) And (tmpIsProspect <> 0) Then
'                  oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "8130.asp?ProspectID=" & ProspectID
'                  oHTTP.send
'               End If
               'send the lead information for additional processing
               If (tmpIsLeadURL <> 0) Then
                  oHTTP.open "GET", tmpLeadURL
                  oHTTP.send
               End If
               'send opt-in email if lead program has a newsletter and we added a new prospect
               If  (reqNewsLetterID <> 0) And (tmpIsProspect <> 0) Then
                  oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "8131.asp?ProspectID=" & ProspectID
                  oHTTP.send
               End If
            End If
            Set oHTTP = Nothing
         End If   

         If (xmlError <> "") Then
            LoadPage
         End If

         If (xmlError = "") And (tmpIsRedirectURL <> 0) Then
            Response.Redirect tmpRedirectURL
         End If

         If (xmlError = "") And (ThanksPageID <> 0) Then
            Response.Redirect "1414.asp" & "?LeadPageID=" & ThanksPageID & "&ProspectID=" & ProspectID & "&MemberID=" & reqm & "&CompanyID=" & tmpCompanyID & "&Language=" & tmpLanguage
         End If
      End If
      If (xmlError = "") Then
         reqPreview = 2
      End If

   Case CLng(cActionThanks):

      Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
      If oLeadCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
      Else
         With oLeadCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load reqp, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCompanyID = .CompanyID
         End With
      End If
      Set oLeadCampaign = Nothing

      Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
      If oLeadPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
      Else
         With oLeadPage
            .SysCurrentLanguage = reqSysLanguage
            ThanksPageID = CLng(.ThanksPage(reqp, tmpLanguage))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oLeadPage = Nothing

      Response.Redirect "1414.asp" & "?LeadPageID=" & ThanksPageID & "&ProspectID=" & reqr & "&MemberID=" & reqm & "&CompanyID=" & tmpCompanyID & "&Language=" & tmpLanguage
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " p=" + Chr(34) + CStr(reqp) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqm) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqa) + Chr(34)
xmlParam = xmlParam + " r=" + Chr(34) + CStr(reqr) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CleanXML(reql) + Chr(34)
xmlParam = xmlParam + " x=" + Chr(34) + CleanXML(reqx) + Chr(34)
xmlParam = xmlParam + " leadpageid=" + Chr(34) + CStr(reqLeadPageID) + Chr(34)
xmlParam = xmlParam + " newsletterid=" + Chr(34) + CStr(reqNewsLetterID) + Chr(34)
xmlParam = xmlParam + " addleadpageid=" + Chr(34) + CStr(reqAddLeadPageID) + Chr(34)
xmlParam = xmlParam + " preview=" + Chr(34) + CStr(reqPreview) + Chr(34)
xmlParam = xmlParam + " log=" + Chr(34) + CStr(reqLog) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqc) + Chr(34)
xmlParam = xmlParam + " i=" + Chr(34) + CleanXML(reqi) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CleanXML(reqs) + Chr(34)
xmlParam = xmlParam + " z=" + Chr(34) + CStr(reqz) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlCompany
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlLeadLog
xmlTransaction = xmlTransaction +  xmlTOP
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\lp[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\lp[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "lp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild

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
   Response.Write "lp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
   Response.End
End If
oLanguage.removeChild oLanguage.firstChild
xmlErrorLabels = oLanguage.XML
End If

'-----get the data XML
xmlData = "<DATA>"
xmlData = xmlData +  xmlTransaction
xmlData = xmlData +  xmlHead
xmlData = xmlData +  xmlParam
xmlData = xmlData +  xmlLanguage
xmlData = xmlData +  xmlError
xmlData = xmlData +  xmlErrorLabels
xmlData = xmlData + "</DATA>"

'-----create a DOM object for the XSL
xslPage = "lp.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "lp Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "lp Load file (oData) failed with error code " + CStr(oData.parseError)
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