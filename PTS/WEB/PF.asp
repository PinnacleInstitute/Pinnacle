<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oPage, xmlPage
Dim oHTMLFile, xmlHTMLFile
'-----declare page parameters
Dim reqP
Dim reqL
Dim reqMemberID
Dim reqProspectID
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
pos = InStr(LCASE(reqSysServerPath), "pf")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqP =  Numeric(GetInput("P", reqPageData))
reqL =  GetInput("L", reqPageData)
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqProspectID =  Numeric(GetInput("ProspectID", reqPageData))
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

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oPage = server.CreateObject("ptsPageUser.CPage")
      If oPage Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPageUser.CPage"
      Else
         With oPage
            .SysCurrentLanguage = reqSysLanguage
            .Load reqP, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCompanyID = .CompanyID
            tmpFields = .Fields
            tmpLang = .Language
            If (reqL <> "") Then
               tmpLang = reqL
            End If
         End With
      End If
      Set oPage = Nothing

      Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
      If oHTMLFile Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
      Else
         With oHTMLFile
            .Filename = reqP & ".htm"
            .Path = reqSysWebDirectory + "Pages\"
            .Language = tmpLang
            .Project = SysProject
            .Load 
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlHTMLFile = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oHTMLFile = Nothing
      
   'Create all the objects
   Set oProspect = server.CreateObject("ptsProspectUser.CProspect")
   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   Set oProspectOptions = server.CreateObject("wtSystem.CInputOptions")
   Set oMemberOptions = server.CreateObject("wtSystem.CInputOptions")

   ProspectOptionTotal = 0
   MemberOptionTotal = 0
   
   'If we have a prospect, load the prospect and its extra data
   If reqProspectID <> 0 Then
      With oProspect
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqProspectID), 1
         If reqMemberID = 0 Then reqMemberID = .MemberID 
         tmpProspectTypeID = .ProspectTypeID
         tmpInputValues = .InputValues
      End With
      'load the prospects extra data from its prospect type
      If tmpProspectTypeID <> 0 Then
         Set oProspectType = server.CreateObject("ptsProspectTypeUser.CProspectType")
         With oProspectType
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpProspectTypeID, 1
            If .InputOptions  <> "" Then
               oProspectOptions.Load .InputOptions, tmpInputValues
               ProspectOptionTotal = oProspectOptions.Count
            End If
         End With
         Set oProspectType = Nothing
      End If
   End If

   'If we have a member, load the member and its extra data
   If reqMemberID <> 0 Then
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), 1
         tmpCompanyID = .CompanyID
         tmpInputValues = .InputValues
      End With
      'load the members extra data from its company
      If tmpCompanyID <> 0 Then
         Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
         If oCoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
         Else
            With oCoption
               .SysCurrentLanguage = reqSysLanguage
               .FetchCompany CLng(tmpCompanyID)
               .Load .CoptionID, 1
               If .InputOptions  <> "" Then
                  oMemberOptions.Load .InputOptions, tmpInputValues
                  MemberOptionTotal = oMemberOptions.Count
               End If
            End With
         End If
         Set oCoption = Nothing
      End If
   End If

   'create an array of all the field definitions for this form
   aFields = Split(tmpFields, VBCrLf)
   reqTotal = UBOUND(aFields)
   'walk through the list of field definitions
   For x = 0 to reqTotal
      'If the field definition includes an equal sign, process it
      If InStr( aFields(x), "=" ) > 0 Then
         'Get the field name and the data reference
         aField = Split(aFields(x), "=")
         tmpName = aField(0)
         tmpData = aField(1)
         tmpValue = ""

         'Get the data reference parts (Member.NameLast)
         aData = Split(tmpData, ".")
         'Process The Entity part of the data reference
         Select Case UCase(aData(0))
            Case "MEMBER"
               'Get the Member data by examining the Field part of the data reference
               With oMember
                  Select Case UCase(aData(1))
                     Case "COMPANYNAME": tmpValue = .CompanyName
                     Case "NAMELAST": tmpValue = .NameLast
                     Case "NAMEFIRST": tmpValue = .NameFirst
                     Case "STREET": tmpValue = .Street
                     Case "UNIT": tmpValue = .Unit
                     Case "CITY": tmpValue = .City
                     Case "STATE": tmpValue = .State
                     Case "ZIP": tmpValue = .Zip
                     Case "COUNTRY": tmpValue = .Country
                     Case "EMAIL": tmpValue = .Email
                     Case "PHONE1": tmpValue = .Phone1
                     Case "PHONE2": tmpValue = .Phone2
                     Case "FAX": tmpValue = .Fax
                     Case "REFERENCE": tmpValue = .Reference
                     Case "VISITDATE": tmpValue = .VisitDate
                     Case "GRP": tmpValue = .GroupID
                     Case "ROLE": tmpValue = .Role
                     Case "SIGNATURE": tmpValue = .Signature
                     Case "TITLE": tmpValue = .Title
                     Case "EXTRA"
                        'Look in the Members extra data for the specified field (Member.Extra.DOB)
                        tmpExtra = UCase(aData(2))
                        If MemberOptionTotal > 0 Then
                           With oMemberOptions
                              For z = 1 To MemberOptionTotal
                                 If tmpExtra = UCase(.Item(z).Name) Then
                                    tmpValue = .Item(z).Value
                                    Exit For
                                 End If   
                              Next
                           End With
                        End If
                   End Select
               End With
            
            Case "PROSPECT"
               'Get the Prospect data by examining the Field part of the data reference
               With oProspect
                  Select Case UCase(aData(1))
                     Case "PROSPECTNAME": tmpValue = .ProspectName
                     Case "SALESCAMPAIGN": tmpValue = .SalesCampaignName
                     Case "PROSPECTTYPE": tmpValue = .ProspectTypeName
                     Case "WEBSITE": tmpValue = .Website
                     Case "DESCRIPTION": tmpValue = .Description
                     Case "REPRESENTING": tmpValue = .Representing
                     Case "POTENTIAL": tmpValue = .Potential
                     Case "NAMELAST": tmpValue = .NameLast
                     Case "NAMEFIRST": tmpValue = .NameFirst
                     Case "TITLE": tmpValue = .TitleID
                     Case "EMAIL": tmpValue = .Email
                     Case "PHONE1": tmpValue = .Phone1
                     Case "PHONE2": tmpValue = .Phone2
                     Case "STREET": tmpValue = .Street
                     Case "UNIT": tmpValue = .Unit
                     Case "CITY": tmpValue = .City
                     Case "STATE": tmpValue = .State
                     Case "ZIP": tmpValue = .Zip
                     Case "COUNTRY": tmpValue = .Country
                     Case "STATUS": tmpValue = .Status
                     Case "PRIORITY": tmpValue = .Priority
                     Case "NEXTEVENT": tmpValue = .NextEvent
                     Case "NEXTDATE": tmpValue = .NextDate
                     Case "NEXTTIME": tmpValue = .NextTime
                     Case "CREATEDATE": tmpValue = .CreateDate
                     Case "CLOSEDATE": tmpValue = .CloseDate
                     Case "FBDATE": tmpValue = .FBDate
                     Case "DEADDATE": tmpValue = .DeadDate
                     Case "DATE1": tmpValue = .Date1
                     Case "DATE2": tmpValue = .Date2
                     Case "DATE3": tmpValue = .Date3
                     Case "DATE4": tmpValue = .Date4
                     Case "DATE5": tmpValue = .Date5
                     Case "DATE6": tmpValue = .Date6
                     Case "DATE7": tmpValue = .Date7
                     Case "DATE8": tmpValue = .Date8
                     Case "DATE9": tmpValue = .Date9
                     Case "DATE10": tmpValue = .Date10
                     Case "EXTRA"
                        'Look in the Prospects extra data for the specified field (Prospect.Extra.DOB)
                        tmpExtra = UCase(aData(2))
                        If ProspectOptionTotal > 0 Then
                           With oProspectOptions
                              For z = 1 To ProspectOptionTotal
                                 If tmpExtra = UCase(.Item(z).Name) Then
                                    tmpValue = .Item(z).Value
                                    Exit For
                                 End If   
                              Next
                           End With
                        End If
                   End Select
               End With

         End Select
      End If
    Next
   
   Set oProspect = Nothing
   Set oMember = Nothing
   Set oProspectOptions = Nothing
   Set oMemberOptions = Nothing


End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " p=" + Chr(34) + CStr(reqP) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CleanXML(reqL) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " prospectid=" + Chr(34) + CStr(reqProspectID) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlPage
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\Page[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Page[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "PF Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "PF Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "PF.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "PF Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "PF Load file (oData) failed with error code " + CStr(oData.parseError)
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