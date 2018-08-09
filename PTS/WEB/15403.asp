<!--#include file="Include\System.asp"-->
<!--#include file="Include\Comm.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionTestPromo = 5
Const cActionPreviewPromo = 6
Const cActionSendPromo = 7
Const cActionRefresh = 8
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
Dim oCountrys, xmlCountrys
Dim oMerchant, xmlMerchant
Dim oPromo, xmlPromo
'-----declare page parameters
Dim reqPromoID
Dim reqMerchantID
Dim reqCompanyID
Dim reqCountryID
Dim reqCopyID
Dim reqSentPromo
Dim reqTarget1
Dim reqTarget2
Dim reqTarget3
Dim reqTarget4
Dim reqTarget5
Dim reqTarget6
Dim reqTarget7
Dim reqTarget8
Dim reqTarget9
Dim reqTarget10
Dim reqIsDemo
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
   SetCache "15403URL", reqReturnURL
   SetCache "15403DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "15403")
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
reqPromoID =  Numeric(GetInput("PromoID", reqPageData))
reqMerchantID =  Numeric(GetInput("MerchantID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqCountryID =  Numeric(GetInput("CountryID", reqPageData))
reqCopyID =  Numeric(GetInput("CopyID", reqPageData))
reqSentPromo =  Numeric(GetInput("SentPromo", reqPageData))
reqTarget1 =  GetInput("Target1", reqPageData)
reqTarget2 =  GetInput("Target2", reqPageData)
reqTarget3 =  GetInput("Target3", reqPageData)
reqTarget4 =  GetInput("Target4", reqPageData)
reqTarget5 =  GetInput("Target5", reqPageData)
reqTarget6 =  GetInput("Target6", reqPageData)
reqTarget7 =  GetInput("Target7", reqPageData)
reqTarget8 =  GetInput("Target8", reqPageData)
reqTarget9 =  GetInput("Target9", reqPageData)
reqTarget10 =  GetInput("Target10", reqPageData)
reqIsDemo =  Numeric(GetInput("IsDemo", reqPageData))
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

Function GetTarget(target)
   On Error Resume Next
   
            reqTarget1 = ""
            reqTarget2 = ""
            reqTarget3 = ""
            reqTarget4 = ""
            reqTarget5 = ""
            reqTarget6 = ""
            reqTarget7 = ""
            reqTarget8 = ""
            reqTarget9 = ""
            reqTarget10 = ""
            a = Split( target, ",")
            total = UBOUND(a)
            If total >= 0 Then reqTarget1 = a(0)
            If total >= 1 Then reqTarget2 = a(1)
            If total >= 2 Then reqTarget3 = a(2)
            If total >= 3 Then reqTarget4 = a(3)
            If total >= 4 Then reqTarget5 = a(4)
            If total >= 5 Then reqTarget6 = a(5)
            If total >= 6 Then reqTarget7 = a(6)
            If total >= 7 Then reqTarget8 = a(7)
            If total >= 8 Then reqTarget9 = a(8)
            If total >= 9 Then reqTarget10 = a(9)
          
End Function

Function SetTarget
   On Error Resume Next
   
            target = ""
            x = 0
            While( x < 10 )
              x = x + 1
              tmp = ""
              Select Case x
              Case 1 tmp = reqTarget1
              Case 2 tmp = reqTarget2
              Case 3 tmp = reqTarget3
              Case 4 tmp = reqTarget4
              Case 5 tmp = reqTarget5
              Case 6 tmp = reqTarget6
              Case 7 tmp = reqTarget7
              Case 8 tmp = reqTarget8
              Case 9 tmp = reqTarget9
              Case 10 tmp = reqTarget10
              End Select
              If tmp <> "" Then
                If target <> "" Then
                  target = target + "," + tmp
                Else
                  target = target + tmp
                End If
              End If
            Wend
            SetTarget = target
          
End Function

Sub LoadLists()
   On Error Resume Next

   Set oCountrys = server.CreateObject("ptsCountryUser.CCountrys")
   If oCountrys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCountryUser.CCountrys"
   Else
      With oCountrys
         .SysCurrentLanguage = reqSysLanguage
         xmlCountrys = xmlCountrys + .EnumCompany(reqCompanyID, , , CLng(reqSysUserID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCountrys = Nothing
End Sub

Sub CheckDemo()
   On Error Resume Next

   Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
   If oMerchant Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
   Else
      With oMerchant
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqMerchantID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.Status = 6) Then
            reqIsDemo = 1
         End If
      End With
   End If
   Set oMerchant = Nothing
End Sub

Sub AddPromo()
   On Error Resume Next
   LoadLists

   If (reqCopyID = 0) Then
      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMerchantID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.Status = 6) Then
               reqIsDemo = 1
            End If
            tmpName = .MerchantName
            tmpFrom = .Email
            If (InStr(tmpFrom, Chr(34)) = 0) Then
               tmpFrom = Chr(34) + tmpName + Chr(34) + " <" + tmpFrom + ">"
            End If
            tmpSubject = .MerchantName
            tmpCountryID = .CountryID
            tmpTargetArea = 1
            tmpTargetType = 1
            tmpTargetDays = 30
            tmpTarget = .Zip
            tmpTestEmail = .Email
         End With
      End If
      Set oMerchant = Nothing
   End If
   If (reqCopyID <> 0) Then
      CheckDemo
   End If

   If (reqCopyID <> 0) Then
      Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
      If oPromo Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
      Else
         With oPromo
            .SysCurrentLanguage = reqSysLanguage
            .Load reqCopyID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpName = .PromoName
            tmpFrom = .FromEmail
            tmpSubject = .Subject
            tmpMessage = .Message
            tmpCountryID = .CountryID
            tmpTargetArea = .TargetArea
            tmpTargetType = .TargetType
            tmpTargetDays = .TargetDays
            tmpTarget = .Target
            tmpTestEmail = .TestEmail
         End With
      End If
      Set oPromo = Nothing
   End If

   Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
   If oPromo Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
   Else
      With oPromo
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .MerchantID = reqMerchantID
         .PromoName = tmpName
         .FromEmail = tmpFrom
         .Subject = tmpSubject
         .Message = tmpMessage
         .CountryID = tmpCountryID
         reqCountryID = .CountryID
         .TargetArea = tmpTargetArea
         .TargetType = tmpTargetType
         .TargetDays = tmpTargetDays
         .Target = tmpTarget
         .SendDate = reqSysDate
         .TestEmail = tmpTestEmail
         .Status = 1
         GetTarget(.Target)
         reqPromoID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlPromo = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPromo = Nothing
End Sub

Sub LoadPromo()
   On Error Resume Next
   LoadLists

   Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
   If oPromo Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
   Else
      With oPromo
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqPromoID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (.Status <= 2) Then
            GetTarget(.Target)
         End If
         reqCountryID = .CountryID
         If (reqMerchantID = 0) Then
            reqMerchantID = .MerchantID
         End If
         If (reqSentPromo > 0) Then
            reqSentPromo = .Msgs
         End If
         xmlPromo = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oPromo = Nothing
   CheckDemo
End Sub

Sub SavePromo()
   On Error Resume Next
   tmpStatus = Request.Form.Item("Status")
   If (tmpStatus <= 2) Then
      tmpTargetArea = Request.Form.Item("TargetArea")
      tmpTargetType = Request.Form.Item("TargetType")
      tmpTargetDays = Request.Form.Item("TargetDays")
      tmpTarget = SetTarget()
      tmpCountryID = Request.Form.Item("CountryID")

      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            tmpMsgs = CLng(.CountEmail(CLng(reqMerchantID), tmpTargetArea, tmpTargetType, tmpTargetDays, tmpTarget, tmpCountryID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oConsumer = Nothing
   End If

   Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
   If oPromo Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
   Else
      With oPromo
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqPromoID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (tmpStatus <= 2) Then
            .Msgs = tmpMsgs
            .Target = tmpTarget
         End If
         reqMerchantID = .MerchantID

         .PromoName = Request.Form.Item("PromoName")
         .TargetType = Request.Form.Item("TargetType")
         .TargetDays = Request.Form.Item("TargetDays")
         .FromEmail = Request.Form.Item("FromEmail")
         .Message = Request.Form.Item("Message")
         .Status = Request.Form.Item("Status")
         .TestEmail = Request.Form.Item("TestEmail")
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError <> "") Then
            xmlPromo = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            LoadPromo
         End If
      End With
   End If
   Set oPromo = Nothing
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqPromoID <> 0) Then
         LoadPromo
      End If
      If (reqPromoID = 0) Then
         AddPromo
      End If
      
               If reqSentPromo <> 0 Then DoError -1, "", reqSentPromo & " promotions sent."
            

   Case CLng(cActionUpdate):
      SavePromo

      If (xmlError = "") Then
         reqReturnURL = GetCache("15403URL")
         reqReturnData = GetCache("15403DATA")
         SetCache "15403URL", ""
         SetCache "15403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("15403URL")
      reqReturnData = GetCache("15403DATA")
      SetCache "15403URL", ""
      SetCache "15403DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
      If oPromo Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
      Else
         With oPromo
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqPromoID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oPromo = Nothing
      If (xmlError <> "") Then
         LoadPromo
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("15403URL")
         reqReturnData = GetCache("15403DATA")
         SetCache "15403URL", ""
         SetCache "15403DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionTestPromo):
      tmpEmail = Request.Form.Item("TestEmail")
      SavePromo
      If (tmpEmail = "") Then
         LoadPromo
         DoError 10007, "", "Please enter a test promotion email address."
      End If
      If (tmpEmail <> "") Then

         Set oPromo = server.CreateObject("ptsPromoUser.CPromo")
         If oPromo Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsPromoUser.CPromo"
         Else
            With oPromo
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqPromoID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlPromo = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               tmpTo = tmpEmail
               tmpFrom = .FromEmail
               tmpSender = tmpFrom
               
                     If InStr(tmpTo, "@") > 0 Then
              If InStr(tmpFrom, "@") = 0 Then tmpFrom = tmpTo
              'tmpSubject = Replace( .Subject, "{firstname}", "Bill" )
              'tmpSubject = Replace( tmpSubject, "{lastname}", "Jones" )
              tmpSubject = "" 'Don't send subject in text message
              tmpBody = Replace( .Message, "{firstname}", "Bill" )
              tmpBody = Replace( tmpBody, "{lastname}", "Jones" )
              tmpBody = Replace( tmpBody, "{id}", "0" )
              tmpBody = Replace( tmpBody, "{email}", .TestEmail )

              SendEmail reqCompanyID, tmpSender, tmpFrom, tmpTo, "", "", tmpSubject, tmpBody
              End If
            
            End With
         End If
         Set oPromo = Nothing
      End If

   Case CLng(cActionPreviewPromo):
      SavePromo

      If (xmlError = "") Then
         Response.Redirect "15407.asp" & "?PromoID=" & reqPromoID
      End If

   Case CLng(cActionSendPromo):
      SavePromo
      If (xmlError = "") Then
         Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
         If oHTTP Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create HTTP Object - MSXML2.ServerXMLHTTP"
         Else
            tmpServer = "http://" + reqSysServerName + reqSysServerPath
            oHTTP.open "GET", tmpServer + "15406.asp" & "?PromoID=" & reqPromoID
            oHTTP.send
         End If
         Set oHTTP = Nothing
      End If

      reqReturnURL = GetCache("15403URL")
      reqReturnData = GetCache("15403DATA")
      SetCache "15403URL", ""
      SetCache "15403DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionRefresh):
      SavePromo
      LoadPromo
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
xmlParam = xmlParam + " promoid=" + Chr(34) + CStr(reqPromoID) + Chr(34)
xmlParam = xmlParam + " merchantid=" + Chr(34) + CStr(reqMerchantID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " countryid=" + Chr(34) + CStr(reqCountryID) + Chr(34)
xmlParam = xmlParam + " copyid=" + Chr(34) + CStr(reqCopyID) + Chr(34)
xmlParam = xmlParam + " sentpromo=" + Chr(34) + CStr(reqSentPromo) + Chr(34)
xmlParam = xmlParam + " target1=" + Chr(34) + CleanXML(reqTarget1) + Chr(34)
xmlParam = xmlParam + " target2=" + Chr(34) + CleanXML(reqTarget2) + Chr(34)
xmlParam = xmlParam + " target3=" + Chr(34) + CleanXML(reqTarget3) + Chr(34)
xmlParam = xmlParam + " target4=" + Chr(34) + CleanXML(reqTarget4) + Chr(34)
xmlParam = xmlParam + " target5=" + Chr(34) + CleanXML(reqTarget5) + Chr(34)
xmlParam = xmlParam + " target6=" + Chr(34) + CleanXML(reqTarget6) + Chr(34)
xmlParam = xmlParam + " target7=" + Chr(34) + CleanXML(reqTarget7) + Chr(34)
xmlParam = xmlParam + " target8=" + Chr(34) + CleanXML(reqTarget8) + Chr(34)
xmlParam = xmlParam + " target9=" + Chr(34) + CleanXML(reqTarget9) + Chr(34)
xmlParam = xmlParam + " target10=" + Chr(34) + CleanXML(reqTarget10) + Chr(34)
xmlParam = xmlParam + " isdemo=" + Chr(34) + CStr(reqIsDemo) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCountrys
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction +  xmlPromo
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\Promo[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\Promo[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "15403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "15403 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "15403 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "15403.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "15403 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "15403 Load file (oData) failed with error code " + CStr(oData.parseError)
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