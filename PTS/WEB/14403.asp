<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionAddNews = 5
Const cActionShareNow = 6
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
Dim oBroadcastNews, xmlBroadcastNews
Dim oBroadcast, xmlBroadcast
Dim oFriendGroups, xmlFriendGroups
Dim oBroadcastNewss, xmlBroadcastNewss
Dim oNewss, xmlNewss
'-----declare page parameters
Dim reqBroadcastID
Dim reqCompanyID
Dim reqMemberID
Dim reqCount
Dim reqDeleteID
Dim reqAddNews
Dim reqListOption
Dim reqFromDate
Dim reqToDate
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
   SetCache "14403URL", reqReturnURL
   SetCache "14403DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "14403")
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
reqBroadcastID =  Numeric(GetInput("BroadcastID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqCount =  Numeric(GetInput("Count", reqPageData))
reqDeleteID =  Numeric(GetInput("DeleteID", reqPageData))
reqAddNews =  Numeric(GetInput("AddNews", reqPageData))
reqListOption =  Numeric(GetInput("ListOption", reqPageData))
reqFromDate =  GetInput("FromDate", reqPageData)
reqToDate =  GetInput("ToDate", reqPageData)
If (reqCompanyID = 0) Then
   reqCompanyID = reqSysCompanyID
End If
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

   Set oFriendGroups = server.CreateObject("ptsFriendGroupUser.CFriendGroups")
   If oFriendGroups Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsFriendGroupUser.CFriendGroups"
   Else
      With oFriendGroups
         .SysCurrentLanguage = reqSysLanguage
         xmlFriendGroups = .EnumMember(CLng(reqMemberID), , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlFriendGroups = Replace(xmlFriendGroups, "name="" """, "name=""Everyone""")
      End With
   End If
   Set oFriendGroups = Nothing

   Set oBroadcastNewss = server.CreateObject("ptsBroadcastNewsUser.CBroadcastNewss")
   If oBroadcastNewss Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastNewsUser.CBroadcastNewss"
   Else
      With oBroadcastNewss
         .SysCurrentLanguage = reqSysLanguage
         .List CLng(reqBroadcastID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  reqCount = 0
                  For Each oItem in oBroadcastNewss
                     reqCount = reqCount + 1
                  Next
               
         xmlBroadcastNewss = xmlBroadcastNewss + .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBroadcastNewss = Nothing
End Sub

Function LoadBroadcast(add)
   On Error Resume Next

   Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
   If oBroadcast Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
   Else
      With oBroadcast
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBroadcastID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMemberID = .MemberID
         If (.Status = 1) Then
            reqAddNews = 1
         End If
         xmlBroadcast = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBroadcast = Nothing
   If (reqCompanyID = 0) Then

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
         End With
      End If
      Set oMember = Nothing
   End If
   If (reqAddNews = 1) Then
      ListNews(add)
   End If
   LoadList
End Function

Sub UpdateBroadcast()
   On Error Resume Next

   Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
   If oBroadcast Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
   Else
      With oBroadcast
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBroadcastID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMemberID = .MemberID

         .BroadcastDate = Request.Form.Item("BroadcastDate")
         .Status = Request.Form.Item("Status")
         .FriendGroupID = Request.Form.Item("FriendGroupID")
         If (reqActionCode = 6) Then
            .Status = 2
         End If
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError <> "") Then
            xmlBroadcast = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
      End With
   End If
   Set oBroadcast = Nothing
   If (xmlError <> "") Then
      LoadList
   End If
End Sub

Function ListNews(add)
   On Error Resume Next
   
               If reqListOption = 0 Then
                  tmpOption = 1
               Else
                  tmpOption = 0
                  tmpDate = Now()
                  reqToDate = DateAdd("h", (reqListOption-1) * -2, tmpDate )
                  reqFromDate = DateAdd("h", -2, reqToDate )
               End If
            

   Set oNewss = server.CreateObject("ptsNewsUser.CNewss")
   If oNewss Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsNewsUser.CNewss"
   Else
      With oNewss
         .SysCurrentLanguage = reqSysLanguage
         .ListShare reqCompanyID, tmpOption, reqFromDate, reqToDate
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  If add = 1 Then
                     Set oBroadcastNews = server.CreateObject("ptsBroadcastNewsUser.CBroadcastNews")
                     If oBroadcastNews Is Nothing Then
                        DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastNewsUser.CBroadcastNews"
                     Else
                        For Each oItem in oNewss
                           tmpID = oItem.NewsID
                           If Request.Form.Item(tmpID) = "on" Then
                              NewID = oBroadcastNews.Add( reqBroadcastID, tmpID )
                              If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                           End If
                        Next
                     End If
                     Set oBroadcastNews = Nothing
                  End If

                  Set oAds = server.CreateObject("ptsAdUser.CAds")
                  If oAds Is Nothing Then
                     DoError Err.Number, Err.Source, "Unable to Create Object - ptsAdUser.CAds"
                  Else
                     With oAds
                        .SysCurrentLanguage = reqSysLanguage
                        UserType = 4
                        UserID = reqSysMemberID
                        If reqSysUserGroup = 1 Then
                           UserType = 1
                           UserID = 1
                        End If
                        If reqSysUserGroup = 51 OR reqSysUserGroup = 52 Then
                           UserType = 28
                           UserID = reqSysOrgID
                        End If
                        tmpStories = oNewss.Count(1)

                        .ListAds reqCompanyID, 4, tmpStories, UserType, UserID
                        If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                        tmpAds = .Count(1)
                     End With
                  End If

                  xmlNewss = "<PTSNEWSS>"
                  x = 1
                  For Each oItem in oNewss
                     With oItem
                        xmlNewss = xmlNewss + "<PTSNEWS newsid=""" + .NewsID + """ newstopicname=""" + .NewsTopicName + """ title=""" + CleanXML(.Title) + """ activedate=""" + .ActiveDate + """ image=""" + .Image + """><DESCRIPTION><!-- " + Replace(.Description, "--", "- ") + " --></DESCRIPTION></PTSNEWS>"
                     End With
                     If x <= tmpAds Then
                        With oAds.Item(x,"",1)
                           xmlNewss = xmlNewss + "<PTSNEWS title=""" + "" + """><DESCRIPTION><!-- " + Replace(.Msg, "--", "- ") + " --></DESCRIPTION></PTSNEWS>"
                        End With
                        x = x + 1
                     End If
                  Next
                  xmlNewss = xmlNewss + "</PTSNEWSS>"
                  Set oAds = Nothing
               
      End With
   End If
   Set oNewss = Nothing
End Function

If (reqDeleteID <> 0) Then

   Set oBroadcastNews = server.CreateObject("ptsBroadcastNewsUser.CBroadcastNews")
   If oBroadcastNews Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastNewsUser.CBroadcastNews"
   Else
      With oBroadcastNews
         .SysCurrentLanguage = reqSysLanguage
         .Delete reqDeleteID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBroadcastNews = Nothing
End If
If (reqBroadcastID = 0) Then

   Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
   If oBroadcast Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
   Else
      With oBroadcast
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .MemberID = reqMemberID
         .BroadcastDate = reqSysDate
         .Status = 1
         reqBroadcastID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBroadcast = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadBroadcast(0)

   Case CLng(cActionUpdate):
      UpdateBroadcast
      If (xmlError = "") Then
         LoadBroadcast(0)
      End If

   Case CLng(cActionCancel):

      If (xmlError = "") Then
         Response.Redirect "14401.asp" & "?MemberID=" & reqMemberID
      End If

   Case CLng(cActionDelete):

      Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
      If oBroadcast Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
      Else
         With oBroadcast
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqBroadcastID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBroadcast = Nothing

      If (xmlError <> "") Then
         Set oBroadcast = server.CreateObject("ptsBroadcastUser.CBroadcast")
         If oBroadcast Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBroadcastUser.CBroadcast"
         Else
            With oBroadcast
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqBroadcastID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlBroadcast = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oBroadcast = Nothing
      End If
      If (xmlError <> "") Then
         LoadList
      End If

      If (xmlError = "") Then
         Response.Redirect "14401.asp" & "?MemberID=" & reqMemberID
      End If

   Case CLng(cActionAddNews):
      LoadBroadcast(1)

   Case CLng(cActionShareNow):
      UpdateBroadcast

      If (xmlError = "") Then
         Response.Redirect "14401.asp" & "?MemberID=" & reqMemberID
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
xmlParam = xmlParam + " broadcastid=" + Chr(34) + CStr(reqBroadcastID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " deleteid=" + Chr(34) + CStr(reqDeleteID) + Chr(34)
xmlParam = xmlParam + " addnews=" + Chr(34) + CStr(reqAddNews) + Chr(34)
xmlParam = xmlParam + " listoption=" + Chr(34) + CStr(reqListOption) + Chr(34)
xmlParam = xmlParam + " fromdate=" + Chr(34) + CStr(reqFromDate) + Chr(34)
xmlParam = xmlParam + " todate=" + Chr(34) + CStr(reqToDate) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBroadcastNews
xmlTransaction = xmlTransaction +  xmlBroadcast
xmlTransaction = xmlTransaction +  xmlFriendGroups
xmlTransaction = xmlTransaction +  xmlBroadcastNewss
xmlTransaction = xmlTransaction +  xmlNewss
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Broadcast[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Broadcast[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "14403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "14403 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "14403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "14403.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "14403 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "14403 Load file (oData) failed with error code " + CStr(oData.parseError)
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