<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionFind = 5
Const cActionPrevious = 6
Const cActionNext = 7
Const cActionPurchase = 8
Const cActionLookup = 9
Const cActionConsolidate = 10
Const cActionSplit = 11
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
Dim oNexxus, xmlNexxus
Dim oGift, xmlGift
Dim oMember, xmlMember
Dim oGifts, xmlGifts
Dim oBookmark, xmlBookmark
'-----declare page parameters
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqMemberID
Dim reqStatus
Dim reqGiftID
Dim reqTransferID
Dim reqTransferName
Dim reqMemberName
Dim reqTransfer
Dim reqCert2
Dim reqCert10
Dim reqCert25
Dim reqCert50
Dim reqRetail
Dim reqTotal
Dim reqPercent
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
   SetCache "15901URL", reqReturnURL
   SetCache "15901DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "15901")
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
reqSearchText =  GetInput("SearchText", reqPageData)
reqFindTypeID =  Numeric(GetInput("FindTypeID", reqPageData))
reqBookmark =  GetInput("Bookmark", reqPageData)
reqDirection =  Numeric(GetInput("Direction", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqStatus =  Numeric(GetInput("Status", reqPageData))
reqGiftID =  Numeric(GetInput("GiftID", reqPageData))
reqTransferID =  Numeric(GetInput("TransferID", reqPageData))
reqTransferName =  GetInput("TransferName", reqPageData)
reqMemberName =  GetInput("MemberName", reqPageData)
reqTransfer =  Numeric(GetInput("Transfer", reqPageData))
reqCert2 =  Numeric(GetInput("Cert2", reqPageData))
reqCert10 =  Numeric(GetInput("Cert10", reqPageData))
reqCert25 =  Numeric(GetInput("Cert25", reqPageData))
reqCert50 =  Numeric(GetInput("Cert50", reqPageData))
reqRetail =  GetInput("Retail", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqPercent =  GetInput("Percent", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 52
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

If (reqFindTypeID = 0) Then
   reqFindTypeID = 15912
End If
reqTransfer = 1

Set oNexxus = server.CreateObject("ptsNexxusUser.CNexxus")
If oNexxus Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsNexxusUser.CNexxus"
Else
   With oNexxus
      .SysCurrentLanguage = reqSysLanguage
      Result = .Custom(600, 0, CLng(reqMemberID), 2)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      
              a = Split(Result, ";")
              reqCert10 = a(0)
              reqCert25 = a(1)
              reqCert50 = a(2)
              reqCert2 = a(3)
              reqRetail = FormatCurrency(a(4))
              reqTotal = FormatCurrency(a(5))
              reqPercent = a(6)
            
   End With
End If
Set oNexxus = Nothing
If (reqSysUserGroup = 41) Then
   If (reqMemberID = 0) Then
      reqMemberID = reqSysMemberID
   End If
   If (reqMemberID <> reqSysMemberID) Then
      AbortUser()
   End If
   If (reqSysCompanyID = 21) Then
      tmp2FA = Is2FA(reqSysUserID)
      If (tmp2FA = 0) Then
         reqTransfer = -1
      End If
   End If
End If
If (reqGiftID <> 0) And (reqTransferName <> "") Then

   Set oGift = server.CreateObject("ptsGiftUser.CGift")
   If oGift Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsGiftUser.CGift"
   Else
      With oGift
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqGiftID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqGiftID = 0
         .MemberID = reqTransferID
         .Notes = "*"
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oGift = Nothing
End If
If (reqSysUserGroup <> 41) And (reqMemberName = "") Then

   Set oMember = server.CreateObject("ptsMemberUser.CMember")
   If oMember Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
   Else
      With oMember
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMemberID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqMemberName = .NameFirst + " " + .NameLast + " #" + .MemberID
      End With
   End If
   Set oMember = Nothing
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqStatus = 0
      reqBookmark = ""
      reqDirection = 1

      Set oGifts = server.CreateObject("ptsGiftUser.CGifts")
      If oGifts Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsGiftUser.CGifts"
      Else
         With oGifts
            .SysCurrentLanguage = reqSysLanguage
            .FindTypeID = reqFindTypeID
            xmlGifts = .XML(14)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oGifts = Nothing

   Case CLng(cActionFind):
      reqBookmark = ""
      reqDirection = 1

   Case CLng(cActionPrevious):
      reqDirection = 2

   Case CLng(cActionNext):
      reqDirection = 1

   Case CLng(cActionPurchase):

      Response.Redirect "NexxusGift.asp" & "?MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionLookup):
      reqTransferName = ""

      If (reqTransferID <> 0) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqTransferID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqTransferName = .NameFirst + " " + .NameLast
               If (reqSysUserGroup <> 1) And (reqSysUserGroup <> 51) Then
                  If (reqTransfer = 1) Then
                     If (.CompanyID <> 21) Then
                        reqTransfer = 2
                        reqTransferName = ""
                     End If
                  End If
                  If (reqTransfer = 1) Then
                     If (.Level = 1) And (.Status <> 1) Then
                        reqTransfer = 3
                        reqTransferName = ""
                     End If
                  End If
                  If (reqTransfer = 1) Then
                     If (.Level = 0) And (.Status = 3) Then
                        reqTransfer = 4
                        reqTransferName = ""
                     End If
                  End If
                  If (reqTransfer = 1) Then
                     If (.Qualify < 2) Or (.IsIncluded = 0) Then
                        reqTransfer = 5
                        reqTransferName = ""
                     End If
                  End If
               End If
            End With
         End If
         Set oMember = Nothing
      End If

   Case CLng(cActionConsolidate):

      Response.Redirect "NexxusGift2.asp" & "?MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL

   Case CLng(cActionSplit):

      Response.Redirect "NexxusGift3.asp" & "?MemberID=" & reqMemberID & "&ReturnURL=" & reqPageURL
End Select

Set oGifts = server.CreateObject("ptsGiftUser.CGifts")
If oGifts Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - ptsGiftUser.CGifts"
Else
   With oGifts
      .SysCurrentLanguage = reqSysLanguage
      If (reqStatus = 0) Then
         reqBookmark = .Find(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End If
      If (reqStatus = 1) Then
         reqBookmark = .FindAvailable(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End If
      If (reqStatus = 2) Then
         reqBookmark = .FindShared(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End If
      If (reqStatus = 3) Then
         reqBookmark = .FindRegistered(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End If
      If (reqStatus = 4) Then
         RetailDate = DateAdd("d",-31,reqSysDate)
         reqBookmark = .FindRetail(reqFindTypeID, reqBookmark, reqSearchText, reqDirection, CLng(reqMemberID), RetailDate, CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End If
      xmlGifts = .XML(15)
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oGifts = Nothing

Set oBookmark = server.CreateObject("wtSystem.CBookmark")
If oBookmark Is Nothing Then
   DoError Err.Number, Err.Source, "Unable to Create Object - wtSystem.CBookmark"
Else
   With oBookmark
      .LastBookmark = reqBookmark
      xmlBookmark = .XML()
      If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
   End With
End If
Set oBookmark = Nothing

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
xmlParam = xmlParam + " searchtext=" + Chr(34) + CleanXML(reqSearchText) + Chr(34)
xmlParam = xmlParam + " findtypeid=" + Chr(34) + CStr(reqFindTypeID) + Chr(34)
xmlParam = xmlParam + " bookmark=" + Chr(34) + CleanXML(reqBookmark) + Chr(34)
xmlParam = xmlParam + " direction=" + Chr(34) + CStr(reqDirection) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " status=" + Chr(34) + CStr(reqStatus) + Chr(34)
xmlParam = xmlParam + " giftid=" + Chr(34) + CStr(reqGiftID) + Chr(34)
xmlParam = xmlParam + " transferid=" + Chr(34) + CStr(reqTransferID) + Chr(34)
xmlParam = xmlParam + " transfername=" + Chr(34) + CleanXML(reqTransferName) + Chr(34)
xmlParam = xmlParam + " membername=" + Chr(34) + CleanXML(reqMemberName) + Chr(34)
xmlParam = xmlParam + " transfer=" + Chr(34) + CStr(reqTransfer) + Chr(34)
xmlParam = xmlParam + " cert2=" + Chr(34) + CStr(reqCert2) + Chr(34)
xmlParam = xmlParam + " cert10=" + Chr(34) + CStr(reqCert10) + Chr(34)
xmlParam = xmlParam + " cert25=" + Chr(34) + CStr(reqCert25) + Chr(34)
xmlParam = xmlParam + " cert50=" + Chr(34) + CStr(reqCert50) + Chr(34)
xmlParam = xmlParam + " retail=" + Chr(34) + CleanXML(reqRetail) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CleanXML(reqTotal) + Chr(34)
xmlParam = xmlParam + " percent=" + Chr(34) + CleanXML(reqPercent) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlNexxus
xmlTransaction = xmlTransaction +  xmlGift
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlGifts
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Gift[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Gift[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "15901 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "15901 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "15901 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "15901.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "15901 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "15901 Load file (oData) failed with error code " + CStr(oData.parseError)
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