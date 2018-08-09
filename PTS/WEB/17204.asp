<!--#include file="Include\System.asp"-->
<!--#include file="Include\CustomFields.asp"-->
<!--#include file="Include\BarterOptions.asp"-->
<!--#include file="Include\LanguageCode.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionCancel = 3
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
Dim oBarterArea, xmlBarterArea
Dim oBarterCategory, xmlBarterCategory
Dim oBarterAd, xmlBarterAd
Dim oBarterImages, xmlBarterImages
'-----other transaction data variables
Dim xmlCustomFields
Dim xmlHTMLFile
'-----declare page parameters
Dim reqBarterAdID
Dim reqBarterArea1ID
Dim reqBarterArea2ID
Dim reqBarterCategoryID
Dim reqNoPrice
Dim reqNoCondition
Dim reqAreaCategory
Dim reqLocation
Dim reqLatitude
Dim reqLongitude
Dim reqGoogleURL
Dim reqPopup
Dim reqBarterPaymentPoints
Dim reqBarterPaymentCash
Dim reqBarterPaymentCC
Dim reqBarterPaymentPP
Dim reqBarterPaymentBTC
Dim reqBarterPaymentNXC
Dim reqBarterPaymentETH
Dim reqBarterPaymentETC
Dim reqBarterPaymentLTC
Dim reqBarterPaymentDASH
Dim reqBarterPaymentMonero
Dim reqBarterPaymentSteem
Dim reqBarterPaymentRipple
Dim reqBarterPaymentDoge
Dim reqBarterPaymentGCR
Dim reqBarterPaymentOther
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
   SetCache "17204URL", reqReturnURL
   SetCache "17204DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "17204")
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
reqBarterAdID =  Numeric(GetInput("BarterAdID", reqPageData))
reqBarterArea1ID =  Numeric(GetInput("BarterArea1ID", reqPageData))
reqBarterArea2ID =  Numeric(GetInput("BarterArea2ID", reqPageData))
reqBarterCategoryID =  Numeric(GetInput("BarterCategoryID", reqPageData))
reqNoPrice =  Numeric(GetInput("NoPrice", reqPageData))
reqNoCondition =  Numeric(GetInput("NoCondition", reqPageData))
reqAreaCategory =  GetInput("AreaCategory", reqPageData)
reqLocation =  GetInput("Location", reqPageData)
reqLatitude =  GetInput("Latitude", reqPageData)
reqLongitude =  GetInput("Longitude", reqPageData)
reqGoogleURL =  GetInput("GoogleURL", reqPageData)
reqPopup =  Numeric(GetInput("Popup", reqPageData))
reqBarterPaymentPoints =  Numeric(GetInput("BarterPaymentPoints", reqPageData))
reqBarterPaymentCash =  Numeric(GetInput("BarterPaymentCash", reqPageData))
reqBarterPaymentCC =  Numeric(GetInput("BarterPaymentCC", reqPageData))
reqBarterPaymentPP =  Numeric(GetInput("BarterPaymentPP", reqPageData))
reqBarterPaymentBTC =  Numeric(GetInput("BarterPaymentBTC", reqPageData))
reqBarterPaymentNXC =  Numeric(GetInput("BarterPaymentNXC", reqPageData))
reqBarterPaymentETH =  Numeric(GetInput("BarterPaymentETH", reqPageData))
reqBarterPaymentETC =  Numeric(GetInput("BarterPaymentETC", reqPageData))
reqBarterPaymentLTC =  Numeric(GetInput("BarterPaymentLTC", reqPageData))
reqBarterPaymentDASH =  Numeric(GetInput("BarterPaymentDASH", reqPageData))
reqBarterPaymentMonero =  Numeric(GetInput("BarterPaymentMonero", reqPageData))
reqBarterPaymentSteem =  Numeric(GetInput("BarterPaymentSteem", reqPageData))
reqBarterPaymentRipple =  Numeric(GetInput("BarterPaymentRipple", reqPageData))
reqBarterPaymentDoge =  Numeric(GetInput("BarterPaymentDoge", reqPageData))
reqBarterPaymentGCR =  Numeric(GetInput("BarterPaymentGCR", reqPageData))
reqBarterPaymentOther =  Numeric(GetInput("BarterPaymentOther", reqPageData))
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

Function LoadCustomFields(cf, obj)
   On Error Resume Next
   
            Dim total, id, v
            With cf
            total = UBOUND(.CustomFields)
            For x = 0 to total
            id = .CustomFields(x).ID
            With obj
            Select Case id
            Case "T1": v = .T1
            Case "T2": v = .T2
            Case "T3": v = .T3
            Case "T4": v = .T4
            Case "T5": v = .T5
            Case "N1": v = .N1
            Case "N2": v = .N2
            Case "N3": v = .N3
            Case "N4": v = .N4
            Case "N5": v = .N5
            Case "L1": v = .L1
            Case "L2": v = .L2
            Case "L3": v = .L3
            Case "L4": v = .L4
            Case "L5": v = .L5
            Case "L6": v = .L6
            Case "L7": v = .L7
            Case "L8": v = .L8
            Case "L9": v = .L9
            Case "L10": v = .L10
            Case "Y1": v = .Y1
            Case "Y2": v = .Y2
            Case "Y3": v = .Y3
            Case "Y4": v = .Y4
            Case "Y5": v = .Y5
            Case "Y6": v = .Y6
            Case "Y7": v = .Y7
            Case "Y8": v = .Y8
            Case "Y9": v = .Y9
            Case "Y10": v = .Y10
            Case "D1": v = .D1
            Case "D2": v = .D2
            Case "D3": v = .D3
            Case "D4": v = .D4
            Case "D5": v = .D5
            End Select
            End With
            .CustomFields(x).Value = v
            Next
            End With
          
End Function

Function SetPayments(opt)
   On Error Resume Next
   
            IF InStr(opt, "1") > 0 Then reqBarterPaymentPoints = 1
            IF InStr(opt, "2") > 0 Then reqBarterPaymentCash = 1
            IF InStr(opt, "3") > 0 Then reqBarterPaymentCC = 1
            IF InStr(opt, "4") > 0 Then reqBarterPaymentPP = 1
            IF InStr(opt, "A") > 0 Then reqBarterPaymentBTC = 1
            IF InStr(opt, "B") > 0 Then reqBarterPaymentNXC = 1
            IF InStr(opt, "C") > 0 Then reqBarterPaymentETH = 1
            IF InStr(opt, "D") > 0 Then reqBarterPaymentETC = 1
            IF InStr(opt, "E") > 0 Then reqBarterPaymentLTC = 1
            IF InStr(opt, "F") > 0 Then reqBarterPaymentDASH = 1
            IF InStr(opt, "G") > 0 Then reqBarterPaymentMonero = 1
            IF InStr(opt, "H") > 0 Then reqBarterPaymentSteem = 1
            IF InStr(opt, "I") > 0 Then reqBarterPaymentRipple = 1
            IF InStr(opt, "J") > 0 Then reqBarterPaymentDoge = 1
            IF InStr(opt, "Y") > 0 Then reqBarterPaymentGCR = 1
            IF InStr(opt, "Z") > 0 Then reqBarterPaymentOther = 1
          
End Function

Function SetupBarterAd(obj, bvBarterAdID)
   On Error Resume Next

   If (reqBarterArea1ID <> 0) Then
      Set oBarterArea = server.CreateObject("ptsBarterAreaUser.CBarterArea")
      If oBarterArea Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterArea"
      Else
         With oBarterArea
            .SysCurrentLanguage = reqSysLanguage
            If (reqBarterArea1ID <> 0) Then
               .Load CLng(reqBarterArea1ID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            reqAreaCategory = .BarterAreaName
            If (reqBarterArea2ID <> 0) Then
               .Load CLng(reqBarterArea2ID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqAreaCategory = reqAreaCategory + " / " + .BarterAreaName
            End If
         End With
      End If
      Set oBarterArea = Nothing
   End If

   If (reqBarterCategoryID <> 0) Then
      Set oBarterCategory = server.CreateObject("ptsBarterCategoryUser.CBarterCategory")
      If oBarterCategory Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCategoryUser.CBarterCategory"
      Else
         With oBarterCategory
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBarterCategoryID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
              If InStr(.Options, "A") > 0 Then reqNoPrice = 1
              If InStr(.Options, "B") > 0 Then reqNoCondition = 1
            
            tmpCustomFields = .CustomFields
            reqAreaCategory = reqAreaCategory + " / " + .BarterCategoryName
            xmlBarterCategory = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterCategory = Nothing
   End If
   
            Set cf = New CustomFields
            With cf
            .Load tmpCustomFields, "", True
            If bvBarterAdID > 0 Then LoadCustomFields cf, obj
            xmlCustomFields = .XML()
            End With
            Set cf = Nothing
          
End Function

Sub LoadBarterAd()
   On Error Resume Next

   Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
   If oBarterAd Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
   Else
      With oBarterAd
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBarterAdID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         reqBarterCategoryID = .BarterCategoryID
         reqBarterArea1ID = .BarterArea1ID
         reqBarterArea2ID = .BarterArea2ID
         SetPayments(.Payments)
         reqLocation = "(" + .Location
         If (.Zip <> "") Then
            reqLocation = reqLocation + ", " + .Zip
         End If
         reqLocation = reqLocation + ")"
         If (.IsMap = "1") And (.GeoCode <> "") Then
            
              aGeoCode = Split(.GeoCode, ",")
              If UBOUND(aGeoCode) = 1 Then
              reqLatitude = aGeoCode(0)
              reqLongitude = aGeoCode(1)
              End If
              'reqGoogleURL = "https://www.google.com/maps?q=loc:" + Replace( .MapStreet1 + " " + .MapStreet2 + " " +.MapCity + " " + .MapZip, " ", "+")
              reqGoogleURL = "https://www.google.com/maps?q=loc:" + .GeoCode
            
         End If
         .Language = LanguageCode(.Language)
         xmlBarterAd = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         SetupBarterAd oBarterAd, reqBarterAdID
         If (InStr(.Options,"F") <> 0) Then

            Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
            If oHTMLFile Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
            Else
               With oHTMLFile
                  .Filename = reqBarterADID
                  .Path = reqSysWebDirectory + "Sections/Barter"
                  .Language = Request.Form.Item("Language")
                  .Project = SysProject
                  .Load 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  xmlHTMLFile = .XML()
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End With
            End If
            Set oHTMLFile = Nothing
         End If
      End With
   End If
   Set oBarterAd = Nothing

   If (reqBarterAdID <> 0) Then
      Set oBarterImages = server.CreateObject("ptsBarterImageUser.CBarterImages")
      If oBarterImages Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterImageUser.CBarterImages"
      Else
         With oBarterImages
            .SysCurrentLanguage = reqSysLanguage
            .ListAll CLng(reqBarterAdID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
              For Each oItem in oBarterImages
                With oItem
                  tmpTitle = LCASE(.Title)
                  If InStr( tmpTitle, ".jpg") > 0 Then .Title = "x"
                  If InStr( tmpTitle, ".gif") > 0 Then .Title = "x"
                  If InStr( tmpTitle, ".png") > 0 Then .Title = "x"
                End With
              Next
            
            xmlBarterImages = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterImages = Nothing
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadBarterAd

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("17204URL")
      reqReturnData = GetCache("17204DATA")
      SetCache "17204URL", ""
      SetCache "17204DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
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
xmlParam = xmlParam + " barteradid=" + Chr(34) + CStr(reqBarterAdID) + Chr(34)
xmlParam = xmlParam + " barterarea1id=" + Chr(34) + CStr(reqBarterArea1ID) + Chr(34)
xmlParam = xmlParam + " barterarea2id=" + Chr(34) + CStr(reqBarterArea2ID) + Chr(34)
xmlParam = xmlParam + " bartercategoryid=" + Chr(34) + CStr(reqBarterCategoryID) + Chr(34)
xmlParam = xmlParam + " noprice=" + Chr(34) + CStr(reqNoPrice) + Chr(34)
xmlParam = xmlParam + " nocondition=" + Chr(34) + CStr(reqNoCondition) + Chr(34)
xmlParam = xmlParam + " areacategory=" + Chr(34) + CleanXML(reqAreaCategory) + Chr(34)
xmlParam = xmlParam + " location=" + Chr(34) + CleanXML(reqLocation) + Chr(34)
xmlParam = xmlParam + " latitude=" + Chr(34) + CleanXML(reqLatitude) + Chr(34)
xmlParam = xmlParam + " longitude=" + Chr(34) + CleanXML(reqLongitude) + Chr(34)
xmlParam = xmlParam + " googleurl=" + Chr(34) + CleanXML(reqGoogleURL) + Chr(34)
xmlParam = xmlParam + " popup=" + Chr(34) + CStr(reqPopup) + Chr(34)
xmlParam = xmlParam + " barterpaymentpoints=" + Chr(34) + CStr(reqBarterPaymentPoints) + Chr(34)
xmlParam = xmlParam + " barterpaymentcash=" + Chr(34) + CStr(reqBarterPaymentCash) + Chr(34)
xmlParam = xmlParam + " barterpaymentcc=" + Chr(34) + CStr(reqBarterPaymentCC) + Chr(34)
xmlParam = xmlParam + " barterpaymentpp=" + Chr(34) + CStr(reqBarterPaymentPP) + Chr(34)
xmlParam = xmlParam + " barterpaymentbtc=" + Chr(34) + CStr(reqBarterPaymentBTC) + Chr(34)
xmlParam = xmlParam + " barterpaymentnxc=" + Chr(34) + CStr(reqBarterPaymentNXC) + Chr(34)
xmlParam = xmlParam + " barterpaymenteth=" + Chr(34) + CStr(reqBarterPaymentETH) + Chr(34)
xmlParam = xmlParam + " barterpaymentetc=" + Chr(34) + CStr(reqBarterPaymentETC) + Chr(34)
xmlParam = xmlParam + " barterpaymentltc=" + Chr(34) + CStr(reqBarterPaymentLTC) + Chr(34)
xmlParam = xmlParam + " barterpaymentdash=" + Chr(34) + CStr(reqBarterPaymentDASH) + Chr(34)
xmlParam = xmlParam + " barterpaymentmonero=" + Chr(34) + CStr(reqBarterPaymentMonero) + Chr(34)
xmlParam = xmlParam + " barterpaymentsteem=" + Chr(34) + CStr(reqBarterPaymentSteem) + Chr(34)
xmlParam = xmlParam + " barterpaymentripple=" + Chr(34) + CStr(reqBarterPaymentRipple) + Chr(34)
xmlParam = xmlParam + " barterpaymentdoge=" + Chr(34) + CStr(reqBarterPaymentDoge) + Chr(34)
xmlParam = xmlParam + " barterpaymentgcr=" + Chr(34) + CStr(reqBarterPaymentGCR) + Chr(34)
xmlParam = xmlParam + " barterpaymentother=" + Chr(34) + CStr(reqBarterPaymentOther) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBarterArea
xmlTransaction = xmlTransaction +  xmlBarterCategory
xmlTransaction = xmlTransaction +  xmlBarterAd
xmlTransaction = xmlTransaction +  xmlBarterImages
xmlTransaction = xmlTransaction +  xmlCustomFields
xmlTransaction = xmlTransaction +  xmlHTMLFile
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\BarterAd[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\BarterAd[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "17204 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "17204 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "17204 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "17204.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "17204 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "17204 Load file (oData) failed with error code " + CStr(oData.parseError)
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