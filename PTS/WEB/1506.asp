<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oLeadPage, xmlLeadPage
Dim oLeadCampaign, xmlLeadCampaign
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqCompanyID
Dim reqLeadPageID
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
pos = InStr(LCASE(reqSysServerPath), "1506")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqLeadPageID =  Numeric(GetInput("LeadPageID", reqPageData))
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

   Set oLeadPage = server.CreateObject("ptsLeadPageUser.CLeadPage")
   If oLeadPage Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadPageUser.CLeadPage"
   Else
      With oLeadPage
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqLeadPageID), 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlTOP = "<TOP><!--" + .TopCode + "--></TOP>"
         tmpLeadCampaignID = .LeadCampaignID
         tmpLanguage = .language
         If (tmpLanguage = "") Then
            tmpLanguage = reqSysLanguage
         End If
      End With
   End If
   Set oLeadPage = Nothing

   Set oLeadCampaign = server.CreateObject("ptsLeadCampaignUser.CLeadCampaign")
   If oLeadCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsLeadCampaignUser.CLeadCampaign"
   Else
      With oLeadCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load tmpLeadCampaignID, 1
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  xmlHead = "<HEAD"
                  If .css <> "" Then xmlHead = xmlHead + " css=""" + .css + """"
                  xmlHead = xmlHead + "/>"
               
      End With
   End If
   Set oLeadCampaign = Nothing

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
   
               xmlHTMLFile = Replace( xmlHTMLFile, "{id}", "456" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{firstname}", "Peter" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{lastname}", "Prospect" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{email}", "peterp@aol.com" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{phone}", "(987)123-4567" )

               xmlHTMLFile = Replace( xmlHTMLFile, "{signature}", "ACME Corporation<BR>John Smith<BR>johns@aol.com<BR>(123)456-7890" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-name}", "ACME Corporation" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-email}", "member@member.com" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-phone}", "(123)456-7890" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-image}", "images/blank.gif" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-id}", "1" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-ref}", "123" )
               xmlHTMLFile = Replace( xmlHTMLFile, "{m-logon}", "demo" )
            
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadPage

   Case CLng(cActionUpdate):
      LoadPage
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " leadpageid=" + Chr(34) + CStr(reqLeadPageID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlLeadPage
xmlTransaction = xmlTransaction +  xmlLeadCampaign
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction +  xmlTOP
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\LeadPage[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\LeadPage[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "1506 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "1506 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "1506.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "1506 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "1506 Load file (oData) failed with error code " + CStr(oData.parseError)
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