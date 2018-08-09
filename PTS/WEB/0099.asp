<!--#include file="Include\System.asp"-->
<!--#include file="Include\XML.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionGo = 5
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
Dim oBusiness, xmlBusiness
'-----other transaction data variables
Dim xmlLang
Dim xmlFile
'-----declare page parameters
Dim reqLanguage
Dim reqChanges
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
   SetCache "0099URL", reqReturnURL
   SetCache "0099DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0099")
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
reqLanguage =  GetInput("Language", reqPageData)
reqChanges =  Numeric(GetInput("Changes", reqPageData))
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 24
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

Sub LoadLanguages()
   On Error Resume Next

   Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
   If oBusiness Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBusinessUser.CBusiness"
   Else
      With oBusiness
         .Load 1, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpLanguages = .Languages
         
   xmlLang = "<PTSLANG>"
   aLanguages = Split( tmpLanguages, ";" )
   total = UBOUND(aLanguages)
   For x = 0 to total
      aLanguage = split(aLanguages(x), ",")
      id = aLanguage(0)
      name = aLanguage(1)
      'Only the system administrator can edit the English (Master) Language Labels
      If (id <> "en") or (reqSysUserGroup=1) Then
         xmlLang = xmlLang + "<ENUM id=""" + id + """ name=""" + name + """"
         If id = reqLanguage Then xmlLang = xmlLang + " selected=""true"""
         xmlLang = xmlLang + "/>"
      End If
   Next
   xmlLang = xmlLang + "</PTSLANG>"

      End With
   End If
   Set oBusiness = Nothing
End Sub

Sub LoadFiles()
   On Error Resume Next
   
   filename = "Language\Translate\Translate[en].xml"
   Set oMaster = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
   oMaster.load server.MapPath(filename)
   If oMaster.parseError <> 0 Then
      Response.Write "Translate Load file failed with error code " + CStr(oMaster.parseError)
      Response.End
   End If

   If reqLanguage <> "en" Then
      filename = "Language\Translate\Translate[" + reqLanguage + "].xml"
      Set oLang = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
      oLang.load server.MapPath(filename)
      If oLang.parseError <> 0 Then
         Response.Write "Translate Load file failed with error code " + CStr(oLang.parseError)
         Response.End
      End If
      ' LOOKUP EACH FILE IN THE LANGUAGE FILE AND CHECK IF THE FILE EXISTS AND IF IT NEEDS TO BE UPDATED
      Set oLabels = oMaster.selectNodes("PTSFILES/PTSFILE")
      For Each oLabel In oLabels
         With oLabel
            sName = .getAttribute("name")
            sDate = .getAttribute("date")
            Set oItem = oLang.selectSingleNode("PTSFILES/PTSFILE[@name='" + sName + "']")
            '-----if found, look up date, otherwise it needs to be updated
            If (oItem Is Nothing) Then
               .setAttribute "update", "true"
            Else
               sLangDate = oItem.getAttribute("date")
               If IsDate(sDate) AND IsDate(sLangDate) Then
                  .setAttribute "langdate", sLangDate
                  '-----if language file is older than English File, it needs to be updated
                  If CDate(sDate) > CDate(sLangDate) Then
                     .setAttribute "update", "true"
                  End If                  
               Else
                  .setAttribute "update", "true"
               End If
            End If
            Set oItem = Nothing
         End With
      Next
      Set oLabels = Nothing
      Set oLang = Nothing
   End If
   xmlFile = oMaster.XML
   Set oMaster = Nothing

End Sub

Sub UpdateCtrlFile()
   On Error Resume Next
   
   '-----update English Language Control File
   filename = "Language\Translate\Translate[en].xml"

   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   If oFileSys Is Nothing Then
      Response.Write "Scripting.FileSystemObject failed to load"
      Response.End
   End If

   '---check if file exists, if not, create it
   If Not oFileSys.FileExists(reqSysWebDirectory + filename) Then
      SaveXMLFile reqSysWebDirectory + filename, "<PTSFILES/>"
   End If

   '---load list of english control files
   Set oMaster = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
   oMaster.load server.MapPath(filename)
   If oMaster.parseError <> 0 Then
      Response.Write "Translate Load file failed with error code " + CStr(oMaster.parseError)
      Response.End
   End If

   '---get list of english files [en] from the directory
   Set Folder = oFileSys.GetFolder(reqSysWebDirectory + "Language")
   Set Files = Folder.Files
   Set oParent = oMaster.selectSingleNode("PTSFILES")

   '---walk through list of english files to update the control file list
   For Each File In Files
      sName = File.Name
      pos = InStr( sName, "[en]" )
      If pos > 0 Then
         sName = Left( sName, pos-1 )
         sDate = File.DateLastModified
         '---check if the filename exists in the control file
         Set oItem = oMaster.selectSingleNode("PTSFILES/PTSFILE[@name='" + sName + "']")
         '---if the filename exists, update the file date
         If Not (oItem Is Nothing) Then
            oItem.setAttribute "date", sDate
         Else   
            '---if the filename doesn't exist, add it with the file date
            Set oNode = oMaster.createElement("PTSFILE")
            oParent.appendChild oNode
            oNode.setAttribute "name", sName
            oNode.setAttribute "date", sDate
            Set oNode = Nothing
         End If
         Set oItem = Nothing
      End If
   Next
   Set oParent = Nothing
   Set Files = Nothing
   Set Folder = Nothing

   '---walk through list of files in the control file to remove unused files
   Set oParent = oMaster.selectSingleNode("PTSFILES")
   Set oLabels = oMaster.selectNodes("PTSFILES/PTSFILE")
   For Each oLabel In oLabels
      With oLabel
         sName = .getAttribute("name")
         sFile = "Language\" + sName + "[en].xml"
         '---check if the filename exists in the directory
         If Not oFileSys.FileExists(reqSysWebDirectory + sFile) Then
            '---if the filename doesn't exist, remove it from the control file
            oParent.removeChild oLabel
         End If
      End With
   Next
   Set oLabels = Nothing
   Set oParent = Nothing

   '---save the control file
   SaveXMLFile reqSysWebDirectory + filename, oMaster.XML

   Set oMaster = Nothing
   Set oFileSys = Nothing

End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqChanges = 0
      LoadLanguages
      UpdateCtrlFile

   Case CLng(cActionGo):
      LoadLanguages
      LoadFiles
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
xmlParam = xmlParam + " language=" + Chr(34) + CleanXML(reqLanguage) + Chr(34)
xmlParam = xmlParam + " changes=" + Chr(34) + CStr(reqChanges) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBusiness
xmlTransaction = xmlTransaction +  xmlLang
xmlTransaction = xmlTransaction +  xmlFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language\0099.xml"
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0099 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0099 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0099 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0099.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0099 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0099 Load file (oData) failed with error code " + CStr(oData.parseError)
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