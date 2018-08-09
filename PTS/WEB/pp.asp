<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oLeadCampaign, xmlLeadCampaign
Dim oLeadPage, xmlLeadPage
Dim oHTMLFile, xmlHTMLFile
Dim oMember, xmlMember
Dim oProspect, xmlProspect
Dim oSignature, xmlSignature
Dim oLeadLog, xmlLeadLog
'-----declare page parameters
Dim reqp
Dim reqm
Dim reqa
Dim reqr
Dim reql
Dim reqx
Dim reqpg
Dim reqPageID
Dim reqAddPageID
Dim reqPreview
Dim reqLog
Dim reqTest
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
pos = InStr(LCASE(reqSysServerPath), "pp")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqp =  Numeric(GetInput("p", reqPageData))
reqm =  Numeric(GetInput("m", reqPageData))
reqa =  Numeric(GetInput("a", reqPageData))
reqr =  Numeric(GetInput("r", reqPageData))
reql =  GetInput("l", reqPageData)
reqx =  GetInput("x", reqPageData)
reqpg =  Numeric(GetInput("pg", reqPageData))
reqPageID =  Numeric(GetInput("PageID", reqPageData))
reqAddPageID =  Numeric(GetInput("AddPageID", reqPageData))
reqPreview =  Numeric(GetInput("Preview", reqPageData))
reqLog =  Numeric(GetInput("Log", reqPageData))
reqTest =  Numeric(GetInput("Test", reqPageData))
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
         tmpCompanyID = .CompanyID
         tmpLeadCampaignName = .LeadCampaignName
         
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
         If (reqpg = 0) And (reqPageID = 0) Then
            reqPageID = CLng(.NextPage(reqp, reqPageID, tmpLanguage))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (reqpg <> 0) And (reqPageID = 0) Then
            reqPageID = CLng(.GetSeq(reqp, reqpg, tmpLanguage))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         tmpPageID = reqPageID
         reqAddPageID = reqPageID
         tmpPage = ""
         .Load reqPageID, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlTOP = "<TOP><!--" + .TopCode + "--></TOP>"
         tmpPage = .Seq
         xmlLeadPage = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqPageID = CLng(.NextPage(reqp, reqPageID, tmpLanguage))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadPage = Nothing

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Lead" & tmpPageID & ".htm"
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
      tmpLogon = ""
      tmpImage = "images/blank.gif"
      tmpRef = ""
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
      tmpLogon = "Peter"
      tmpImage = "images/blank.gif"
      tmpRef = "123"
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
            tmpLogon = .Logon
            If (.Image <> "") Then
               tmpImage = "images/member/" + .Image
            End If
            If (.Image = "") Then
               tmpImage = "images/blank.gif"
            End If
            tmpRef = .Reference
            If (reqp <> 0) Then
               Signature = .GetSignature(reqm, 3, reqp, reqSysLanguage)
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
            tmpPresentView = GetCache("PRESENTVIEW")
            If (tmpPage <> "") Then
               If (tmpPresentView <> 1) Then
                  SetCache "PRESENTVIEW", 1
                  .PresentViews = .PresentViews + 1
                  
   If CLng(.PresentViews) <= 10 Then
      tmpSubject = " PROSPECT VIEWING PRESENTATION: " + tmpPFirstName + " " + tmpPLastName + " - " + tmpPPhone + " (" + CStr(.PresentViews) + " times)"
      tmpBody = tmpLeadCampaignName
      SendEmail reqCompanyID, tmpEmail2, tmpEmail2, tmpEmail2, "", "", tmpSubject, tmpBody
   End If
   '                  Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
   '                  If oHTTP Is Nothing Then
   '                     Response.Write "Error #" & Err.number & " - " + Err.description
'                  Else
'                     oHTTP.open "GET", "http://" + reqSysServerName + reqSysServerPath + "8133.asp?Lead=0&ProspectID=" & reqr
'                     oHTTP.send
'                  End If
'                  Set oHTTP = Nothing
                  
                  If (.PresentViews = 1) Then
                     Set oNote = server.CreateObject("ptsNoteUser.CNote")
                     If oNote Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsNoteUser.CNote"
                     Else
                        With oNote
                           .SysCurrentLanguage = reqSysLanguage
                           .Notes = "FIRST VIEWED Presentation Website: " + tmpLeadCampaignName 
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
               
               tmpPresentPages = .PresentPages
               If InStr(tmpPresentPages, tmpPage) = 0 Then
                  If tmpPresentPages  <> "" Then tmpPresentPages = tmpPresentPages + ","
                  tmpPresentPages = tmpPresentPages + tmpPage
                  .PresentPages = tmpPresentPages
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
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-logon}", CleanXMLComment(tmpLogon) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-image}", CleanXMLComment(tmpImage) )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", reqM )
      xmlHTMLFile = Replace( xmlHTMLFile, "{m-ref}", CleanXMLComment(tmpRef) )
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


   If (reqm <> 0) Then
      Set oSignature = server.CreateObject("ptsSignatureUser.CSignature")
      If oSignature Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsSignatureUser.CSignature"
      Else
         With oSignature
            .SysCurrentLanguage = reqSysLanguage
            
      If InStr(xmlHTMLFile, "{welcome}" ) > 0 Then
            Result = .GetPersonal(reqm, 7, reqp, tmpLanguage)
         xmlHTMLFile = Replace( xmlHTMLFile, "{welcome}", CleanXMLComment(Result) )
      End If
      If InStr(xmlHTMLFile, "{story}" ) > 0 Then
            Result = .GetPersonal(reqm, 8, reqp, tmpLanguage)
         xmlHTMLFile = Replace( xmlHTMLFile, "{story}", CleanXMLComment(Result) )
      End If
      If InStr(xmlHTMLFile, "{vision}" ) > 0 Then
            Result = .GetPersonal(reqm, 9, reqp, tmpLanguage)
         xmlHTMLFile = Replace( xmlHTMLFile, "{vision}", CleanXMLComment(Result) )
      End If
      If InStr(xmlHTMLFile, "{testimony}" ) > 0 Then
            Result = .GetPersonal(reqm, 10, reqp, tmpLanguage)
         xmlHTMLFile = Replace( xmlHTMLFile, "{testimony}", CleanXMLComment(Result) )
      End If
      If InStr(xmlHTMLFile, "{invite}" ) > 0 Then
            Result = .GetPersonal(reqm, 11, reqp, tmpLanguage)
         xmlHTMLFile = Replace( xmlHTMLFile, "{invite}", CleanXMLComment(Result) )
      End If

         End With
      End If
      Set oSignature = Nothing
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
         .LeadPageID = reqAddPageID
         .MemberID = reqm
         .AffiliateID = reqa
         .LogDate = Now
         LeadLogID = CLng(.Add(1))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oLeadLog = Nothing
End Sub

If (reqm = 0) And (reqSysMemberID <> 0) Then
   reqm = reqSysMemberID
End If
If (reqp <> 0) Then
   SetCache "PPP", reqp
End If
If (reqp = 0) Then
   x = GetCache("PPP")
   If (IsNumeric(x) ) Then
      reqp = CLng(x)
   End If
End If
If (reqm <> 0) Then
   SetCache "PPM", reqm
   SetCache "A", reqm
End If
If (reqm = 0) Then
   x = GetCache("PPM")
   If (IsNumeric(x) ) Then
      reqm = CLng(x)
   End If
End If
If (reqr <> 0) Then
   SetCache "PPR", reqr
End If
If (reqr = 0) Then
   x = GetCache("PPR")
   If (IsNumeric(x) ) Then
      reqr = CLng(x)
   End If
End If
If (reqp <> 0) Then
   SetCache "PPPREVIEW", reqPreview
End If
If (reqp = 0) And (reqPreview = 0) Then
   x = GetCache("PPPREVIEW")
   If (IsNumeric(x) ) Then
      reqPreview = CLng(x)
   End If
End If
If (reqActionCode = 0) Then
   reqLog = 1
End If
If (reqActionCode = 2) Then
   reqPageID = Request.Form.Item("PageID")
   reqActionCode = 0
   If (reqPageID <> 0) Then
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
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " p=" + Chr(34) + CStr(reqp) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqm) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqa) + Chr(34)
xmlParam = xmlParam + " r=" + Chr(34) + CStr(reqr) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CleanXML(reql) + Chr(34)
xmlParam = xmlParam + " x=" + Chr(34) + CleanXML(reqx) + Chr(34)
xmlParam = xmlParam + " pg=" + Chr(34) + CStr(reqpg) + Chr(34)
xmlParam = xmlParam + " pageid=" + Chr(34) + CStr(reqPageID) + Chr(34)
xmlParam = xmlParam + " addpageid=" + Chr(34) + CStr(reqAddPageID) + Chr(34)
xmlParam = xmlParam + " preview=" + Chr(34) + CStr(reqPreview) + Chr(34)
xmlParam = xmlParam + " log=" + Chr(34) + CStr(reqLog) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " z=" + Chr(34) + CStr(reqz) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlSignature
xmlTransaction = xmlTransaction +  xmlLeadLog
xmlTransaction = xmlTransaction +  xmlTOP
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\pp[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\pp[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "pp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "pp Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "pp.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "pp Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "pp Load file (oData) failed with error code " + CStr(oData.parseError)
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