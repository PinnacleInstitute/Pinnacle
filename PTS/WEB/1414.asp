<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oHTMLFile, xmlHTMLFile
Dim oLeadPage, xmlLeadPage
Dim oMember, xmlMember
Dim oProspect, xmlProspect
'-----declare page parameters
Dim reqLeadPageID
Dim reqProspectID
Dim reqMemberID
Dim reqCompanyID
Dim reqLanguage
Dim reqTest
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
pos = InStr(LCASE(reqSysServerPath), "1414")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqLeadPageID =  Numeric(GetInput("LeadPageID", reqPageData))
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqLanguage =  GetInput("Language", reqPageData)
reqTest =  Numeric(GetInput("Test", reqPageData))
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

   Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
   If oHTMLFile Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
   Else
      With oHTMLFile
         .Filename = "Lead" & reqLeadPageID & ".htm"
         .Path = reqSysWebDirectory + "Sections\Company\" + CSTR(reqCompanyID) + "\Lead\"
         .Language = tmpLanguage
         .Project = SysProject
         .Load 
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlHTMLFile = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oHTMLFile = Nothing
   tmpName = ""
   tmpSignature = ""
   tmpFirstName = ""
   tmpLastName = ""
   tmpEmail = ""
   tmpPhone = ""

   Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
   If oLeadPage Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
   Else
      With oLeadPage
         .SysCurrentLanguage = reqSysLanguage
         .Load reqLeadPageID, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpLeadCampaignID = .LeadCampaignID
         xmlTOP = "<TOP><!--" + .TopCode + "--></TOP>"
      End With
   End If
   Set oLeadPage = Nothing

   If (reqMemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load reqMemberID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.IsCompany = 0) Then
               tmpName = .NameFirst + " " + .NameLast
            End If
            If (.IsCompany <> 0) Then
               tmpName = .CompanyName
            End If
            tmpLogon = .Logon
            tmpSignature = .Signature
            Signature = .GetSignature(reqMemberID, 2, tmpLeadCampaignID, reqSysLanguage)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Signature <> "") Then
               tmpSignature = Signature
            End If
         End With
      End If
      Set oMember = Nothing
   End If

   If (reqProspectID <> 0) Then
      Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
      If oProspect Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
      Else
         With oProspect
            .SysCurrentLanguage = reqSysLanguage
            .Load reqProspectID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpFirstName = .NameFirst
            tmpLastName = .NameLast
            tmpEmail = .Email
            tmpPhone = .Phone1
         End With
      End If
      Set oProspect = Nothing
   End If
   
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-name}", CleanXMLComment(tmpName) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", CleanXMLComment(tmpSignature) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", reqMemberID )
               xmlHTMLFile = Replace( xmlHTMLFile, "{id}", reqProspectID )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-logon}", CleanXMLComment(tmpLogon) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{firstname}", CleanXMLComment(tmpFirstName) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{lastname}", CleanXMLComment(tmpLastName) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{email}", CleanXMLComment(tmpEmail) )
               xmlHTMLFile = Replace( xmlHTMLFile, "{phone}", CleanXMLComment(tmpPhone) )
            
End Sub

tmpLanguage = reqLanguage
If (tmpLanguage = "") Then
   tmpLanguage = reqSysLanguage
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadPage

   Case CLng(cActionUpdate):
      LoadPage
      tmpDescription = ""

      If (reqProspectID <> 0) Then
         Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
         If oLeadPage Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
         Else
            With oLeadPage
               .SysCurrentLanguage = reqSysLanguage
               .Load reqLeadPageID, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               If (.Inputs <> "") Then
                  
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
                     Set oInputOptions = server.CreateObject("wtSystem.CInputOptions")
                     oInputOptions.Load .Inputs, ""
                     Total = oInputOptions.Count
                     IF reqTest = 1 Then Response.write "<BR>TEST MODE: " & Total & " custom fields"
                     If Total > 0 Then
                        For x = 1 to Total
                           Nam = oInputOptions.Item(x).Name
                           data = TRIM(Request.Form.Item(Nam))
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
                        Next
                     End If
                     IF reqTest = 1 Then Response.end
                     oInputOptions.Validate
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                     Set oInputOptions = Nothing
                  
               End If
            End With
         End If
         Set oLeadPage = Nothing
      End If

      If (xmlError = "") And (reqProspectID <> 0) And (tmpDescription <> "") Then
         Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
         If oProspect Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsProspectUser.CProspect"
         Else
            With oProspect
               .SysCurrentLanguage = reqSysLanguage
               .Load reqProspectID, 1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
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
                  .Description = Left(.Description + " " + tmpDescription, 2000)
               End If
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               DoError -1, "", "Thanks For Your Info!"
            End With
         End If
         Set oProspect = Nothing
      End If
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " leadpageid=" + Chr(34) + CStr(reqLeadPageID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " language=" + Chr(34) + CleanXML(reqLanguage) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlProspect
xmlTransaction = xmlTransaction +  xmlTOP
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\LeadCampaign[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\LeadCampaign[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "1414 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "1414 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "1414.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "1414 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "1414 Load file (oData) failed with error code " + CStr(oData.parseError)
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