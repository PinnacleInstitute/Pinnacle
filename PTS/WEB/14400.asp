<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
'-----declare xml data variables
Dim xmlTransaction, xmlHead, xmlError, xmlErrorLabels
'-----object variables
Dim oBroadcast, xmlBroadcast
Dim oMember, xmlMember
Dim oBroadcasts, xmlBroadcasts
Dim oAds, xmlAds
'-----declare page parameters
Dim reqBroadcastID
Dim reqCompanyID
Dim reqMember
Dim reqFriend
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
pos = InStr(LCASE(reqSysServerPath), "14400")
If pos > 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)


'-----fetch page parameters
reqBroadcastID =  Numeric(GetInput("BroadcastID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMember =  GetInput("Member", reqPageData)
reqFriend =  Numeric(GetInput("Friend", reqPageData))
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

reqCompanyID = 12
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
      If oBroadcast Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
      Else
         With oBroadcast
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBroadcastID), 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpMemberID = .MemberID
            tmpStories = .Stories
         End With
      End If
      Set oBroadcast = Nothing

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load tmpMemberID, 1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.IsCompany = 0) Then
               reqMember = .NameFirst + " " + .NameLast
            End If
            If (.IsCompany <> 0) Then
               reqMember = .CompanyName
            End If
         End With
      End If
      Set oMember = Nothing

      Set oBroadcasts = server.CreateObject("ptsBroadcastUser.CBroadcasts")
      If oBroadcasts Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcasts"
      Else
         With oBroadcasts
            .SysCurrentLanguage = reqSysLanguage
            .ListNews CLng(reqBroadcastID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
         Set oAds = server.CreateObject("ptsAdUser.CAds")
         If oAds Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAdUser.CAds"
         Else
            With oAds
               .SysCurrentLanguage = reqSysLanguage
               .ListAds reqCompanyID, 4, tmpStories, 141, -1
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpAds = .Count(1)
            End With
         End If

         xmlBroadcasts = "<PTSBROADCASTS>"
         x = 1
         For Each oItem in oBroadcasts
            With oItem
               xmlBroadcasts = xmlBroadcasts + "<PTSBROADCAST broadcastid=""" + .BroadcastID + """ title=""" + CleanXML(.Title) + """ image=""" + .Image + """><SUMMARY><!-- " + Replace(.Summary, "--", "- ") + " --></SUMMARY></PTSBROADCAST>"
            End With
            If x <= tmpAds Then
               With oAds.Item(x,"",1)
                  xmlBroadcasts = xmlBroadcasts + "<PTSBROADCAST title=""" + "" + """><SUMMARY><!-- " + Replace(.Msg, "--", "- ") + " --></SUMMARY></PTSBROADCAST>"
               End With
               x = x + 1
            End If
         Next
         xmlBroadcasts = xmlBroadcasts + "</PTSBROADCASTS>"
         Set oAds = Nothing
               
         End With
      End If
      Set oBroadcasts = Nothing

      Set oAds = server.CreateObject("ptsAdUser.CAds")
      If oAds Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsAdUser.CAds"
      Else
         With oAds
            .SysCurrentLanguage = reqSysLanguage
            .ListAds reqCompanyID, 4, tmpStories, 141, -1
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpAds = CLng(.Count(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oAds = Nothing
End Select

xmlParam = "<PARAM"
xmlParam = xmlParam + " broadcastid=" + Chr(34) + CStr(reqBroadcastID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " member=" + Chr(34) + CleanXML(reqMember) + Chr(34)
xmlParam = xmlParam + " friend=" + Chr(34) + CStr(reqFriend) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBroadcast
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlBroadcasts
xmlTransaction = xmlTransaction +  xmlAds
xmlTransaction = xmlTransaction + "</TXN>"

'-----get the language XML
fileLanguage = "Language" + "\14400[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\14400[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "14400 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "14400 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "14400.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "14400 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "14400 Load file (oData) failed with error code " + CStr(oData.parseError)
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