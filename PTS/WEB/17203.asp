<!--#include file="Include\System.asp"-->
<!--#include file="Include\CustomFields.asp"-->
<!--#include file="Include\StripHTML.asp"-->
<!--#include file="Include\BarterOptions.asp"-->
<!--#include file="Include\GeoCode.asp"-->
<!--#include file="Include\Languages.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionUpdateStay = 5
Const cActionAdd = 2
Const cActionAddStay = 6
Const cActionCancel = 3
Const cActionDelete = 4
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
Dim oBarterCategory, xmlBarterCategory
Dim oBarterArea, xmlBarterArea
Dim oBarterAd, xmlBarterAd
Dim oBarterImages, xmlBarterImages
Dim oConsumer, xmlConsumer
Dim oBarterCategorys, xmlBarterCategorys
Dim oBarterAreas, xmlBarterAreas
'-----other transaction data variables
Dim xmlCustomFields
Dim xmlHTMLFile
'-----declare page parameters
Dim reqBarterAdID
Dim reqConsumerID
Dim reqBarterArea1ID
Dim reqBarterArea2ID
Dim reqBarterCategoryID
Dim reqIsCustomFields
Dim reqNoPrice
Dim reqNoCondition
Dim reqAreaCategory
Dim reqMode
Dim reqMapErr
Dim reqAreaParentID
Dim reqCityAreas
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
   SetCache "17203URL", reqReturnURL
   SetCache "17203DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "17203")
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
reqConsumerID =  Numeric(GetInput("ConsumerID", reqPageData))
reqBarterArea1ID =  Numeric(GetInput("BarterArea1ID", reqPageData))
reqBarterArea2ID =  Numeric(GetInput("BarterArea2ID", reqPageData))
reqBarterCategoryID =  Numeric(GetInput("BarterCategoryID", reqPageData))
reqIsCustomFields =  Numeric(GetInput("IsCustomFields", reqPageData))
reqNoPrice =  Numeric(GetInput("NoPrice", reqPageData))
reqNoCondition =  Numeric(GetInput("NoCondition", reqPageData))
reqAreaCategory =  GetInput("AreaCategory", reqPageData)
reqMode =  Numeric(GetInput("Mode", reqPageData))
reqMapErr =  Numeric(GetInput("MapErr", reqPageData))
reqAreaParentID =  Numeric(GetInput("AreaParentID", reqPageData))
reqCityAreas =  Numeric(GetInput("CityAreas", reqPageData))
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

Function SaveCustomFields(obj, bvBarterCategoryID)
   On Error Resume Next

   If (reqBarterCategoryID <> 0) Then
      Set oBarterCategory = server.CreateObject("ptsBarterCategoryUser.CBarterCategory")
      If oBarterCategory Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCategoryUser.CBarterCategory"
      Else
         With oBarterCategory
            .SysCurrentLanguage = reqSysLanguage
            .Load bvBarterCategoryID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCustomFields = .CustomFields
         End With
      End If
      Set oBarterCategory = Nothing
   End If
   
            Dim cf, id, v
            Set cf = New CustomFields
            With cf
            .Load tmpCustomFields, "", False
            .GetValues()
            .Validate()
            total = UBOUND(.CustomFields)
            For x = 0 to total
            id = .CustomFields(x).ID
            v = .CustomFields(x).Value
            With obj
            Select Case id
            Case "T1": .T1 = v
            Case "T2": .T2 = v
            Case "T3": .T3 = v
            Case "T4": .T4 = v
            Case "T5": .T5 = v
            Case "N1": .N1 = v
            Case "N2": .N2 = v
            Case "N3": .N3 = v
            Case "N4": .N4 = v
            Case "N5": .N5 = v
            Case "L1": .L1 = v
            Case "L2": .L2 = v
            Case "L3": .L3 = v
            Case "L4": .L4 = v
            Case "L5": .L5 = v
            Case "L6": .L6 = v
            Case "L7": .L7 = v
            Case "L8": .L8 = v
            Case "L9": .L9 = v
            Case "L10": .L10 = v
            Case "Y1": .Y1 = v
            Case "Y2": .Y2 = v
            Case "Y3": .Y3 = v
            Case "Y4": .Y4 = v
            Case "Y5": .Y5 = v
            Case "Y6": .Y6 = v
            Case "Y7": .Y7 = v
            Case "Y8": .Y8 = v
            Case "Y9": .Y9 = v
            Case "Y10": .Y10 = v
            Case "D1": .D1 = v
            Case "D2": .D2 = v
            Case "D3": .D3 = v
            Case "D4": .D4 = v
            Case "D5": .D5 = v
            End Select
            End With
            Next
            End With
            Set cf = Nothing
          
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

Function GetPayments()
   On Error Resume Next
   
            opt =  ""
            IF reqBarterPaymentPoints = 1 Then opt = opt + "1"
            IF reqBarterPaymentCash   = 1 Then opt = opt + "2"
            IF reqBarterPaymentCC     = 1 Then opt = opt + "3"
            IF reqBarterPaymentPP     = 1 Then opt = opt + "3"
            IF reqBarterPaymentBTC    = 1 Then opt = opt + "A"
            IF reqBarterPaymentNXC    = 1 Then opt = opt + "B"
            IF reqBarterPaymentETH    = 1 Then opt = opt + "C"
            IF reqBarterPaymentETC    = 1 Then opt = opt + "D"
            IF reqBarterPaymentLTC    = 1 Then opt = opt + "E"
            IF reqBarterPaymentDASH   = 1 Then opt = opt + "F"
            IF reqBarterPaymentMonero = 1 Then opt = opt + "G"
            IF reqBarterPaymentSteem  = 1 Then opt = opt + "H"
            IF reqBarterPaymentRipple = 1 Then opt = opt + "I"
            IF reqBarterPaymentDoge   = 1 Then opt = opt + "J"
            IF reqBarterPaymentGCR    = 1 Then opt = opt + "Y"
            IF reqBarterPaymentOther  = 1 Then opt = opt + "Z"
            GetPayments = opt
          
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
            If (tmpCustomFields <> "") Then
               reqIsCustomFields = 1
            End If
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

Function UpdateBarterAd(reload)
   On Error Resume Next

   Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
   If oBarterAd Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
   Else
      With oBarterAd
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBarterAdID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpStatus = .Status
         tmpMapStreet1 = .MapStreet1
         tmpMapStreet2 = .MapStreet2
         tmpMapCity = .MapCity
         tmpMapZip = .MapZip

         .ConsumerID = Request.Form.Item("ConsumerID")
         .BarterArea1ID = Request.Form.Item("BarterArea1ID")
         .BarterArea2ID = Request.Form.Item("BarterArea2ID")
         .BarterCategoryID = Request.Form.Item("BarterCategoryID")
         .Options = Request.Form.Item("Options")
         .Status = Request.Form.Item("Status")
         .PostDate = Request.Form.Item("PostDate")
         .UpdateDate = Request.Form.Item("UpdateDate")
         .EndDate = Request.Form.Item("EndDate")
         .ContactName = Request.Form.Item("ContactName")
         .IsEmail = Request.Form.Item("IsEmail")
         .ContactEmail = Request.Form.Item("ContactEmail")
         .IsPhone = Request.Form.Item("IsPhone")
         .ContactPhone = Request.Form.Item("ContactPhone")
         .IsText = Request.Form.Item("IsText")
         .Title = Request.Form.Item("Title")
         .Price = Request.Form.Item("Price")
         .Location = Request.Form.Item("Location")
         .Zip = Request.Form.Item("Zip")
         .Condition = Request.Form.Item("Condition")
         .Description = Request.Form.Item("Description")
         .Description = Request.Form.Item("Description")
         .IsMap = Request.Form.Item("IsMap")
         .MapStreet1 = Request.Form.Item("MapStreet1")
         .MapStreet2 = Request.Form.Item("MapStreet2")
         .MapCity = Request.Form.Item("MapCity")
         .MapZip = Request.Form.Item("MapZip")
         .Language = Request.Form.Item("Language")
         .IsMore = Request.Form.Item("IsMore")
         .IsContact = Request.Form.Item("IsContact")
         If (reqIsCustomFields <> 0) Then
            SaveCustomFields oBarterAd, .BarterCategoryID
         End If
         If (xmlError = "") Then
            .UpdateDate = Now
            .Payments = GetPayments()
            If (tmpStatus <> 2) And (.Status = 2) Then
               .PostDate = Now
               .EndDate = DateAdd("m",1,.PostDate)
            End If
            If (.IsMap <> "0") Then
               .GeoCode = ""
            End If
            If (.IsMap = "1") Then
               If (.GeoCode = "") Or (.MapStreet1 <> tmpMapStreet1) Or (.MapStreet2 <> tmpMapStreet2) Or (.MapCity <> tmpMapCity) Or (.MapZip <> tmpMapZip) Then
                  
                  .GeoCode = GM_GeoCode(.MapStreet1 + "+" + .MapStreet2 + "+" + .MapCity + "+" + .MapZip)
                  If InStr(.GeoCode, "Err:") > 0 Then .IsMap = 0
                
               End If
            End If
            If (InStr(.GeoCode, "Err:") <> 0) Then
               reqMapErr = 1
            End If
            .Options = SetBarterAdOption(.Options, "A", reqNoPrice)
            .Options = SetBarterAdOption(.Options, "B", reqNoCondition)
            .Save CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            UpdateBarterPayments(.Payments)
         End If
         xmlBarterAd = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") Then
            tmpDescription = StripHTML(.Description)
            Result = CLng(.UpdateFT(CLng(.BarterAdID), .Title, .Location, .Zip, tmpDescription))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError <> "") Or (reload <> 0) Then
            SetupBarterAd oBarterAd, reqBarterAdID
         End If
         If (xmlError = "") And (InStr(.Options,"F") <> 0) Then

            Set oHTMLFile = server.CreateObject("wtHTMLFile.CHTMLFile")
            If oHTMLFile Is Nothing Then
               DoError Err.Number, Err.Source, "Unable to Create Object - wtHTMLFile.CHTMLFile"
            Else
               With oHTMLFile
                  .Filename = reqBarterADID
                  .Path = reqSysWebDirectory + "Sections/Barter"
                  .Language = Request.Form.Item("Language")
                  .Project = SysProject
                  .Data = Request.Form.Item("Data")
                  .Save 
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  If (xmlError <> "") Or (reload <> 0) Then
                     xmlHTMLFile = .XML()
                     If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
                  End If
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
            xmlBarterImages = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterImages = Nothing
   End If
End Function

Function AddBarterAd(reload)
   On Error Resume Next

   Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
   If oBarterAd Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
   Else
      With oBarterAd
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .ConsumerID = Request.Form.Item("ConsumerID")
         .BarterArea1ID = Request.Form.Item("BarterArea1ID")
         .BarterArea2ID = Request.Form.Item("BarterArea2ID")
         .BarterCategoryID = Request.Form.Item("BarterCategoryID")
         .Options = Request.Form.Item("Options")
         .Status = Request.Form.Item("Status")
         .PostDate = Request.Form.Item("PostDate")
         .UpdateDate = Request.Form.Item("UpdateDate")
         .EndDate = Request.Form.Item("EndDate")
         .ContactName = Request.Form.Item("ContactName")
         .IsEmail = Request.Form.Item("IsEmail")
         .ContactEmail = Request.Form.Item("ContactEmail")
         .IsPhone = Request.Form.Item("IsPhone")
         .ContactPhone = Request.Form.Item("ContactPhone")
         .IsText = Request.Form.Item("IsText")
         .Title = Request.Form.Item("Title")
         .Price = Request.Form.Item("Price")
         .Location = Request.Form.Item("Location")
         .Zip = Request.Form.Item("Zip")
         .Condition = Request.Form.Item("Condition")
         .Description = Request.Form.Item("Description")
         .Description = Request.Form.Item("Description")
         .IsMap = Request.Form.Item("IsMap")
         .MapStreet1 = Request.Form.Item("MapStreet1")
         .MapStreet2 = Request.Form.Item("MapStreet2")
         .MapCity = Request.Form.Item("MapCity")
         .MapZip = Request.Form.Item("MapZip")
         .Language = Request.Form.Item("Language")
         .IsMore = Request.Form.Item("IsMore")
         .IsContact = Request.Form.Item("IsContact")
         If (reqIsCustomFields <> 0) Then
            SaveCustomFields oBarterAd, .BarterCategoryID
         End If
         If (xmlError = "") Then
            .UpdateDate = Now
            .Payments = GetPayments()
            .Options = SetBarterAdOption(.Options, "A", reqNoPrice)
            .Options = SetBarterAdOption(.Options, "B", reqNoCondition)
            reqBarterAdID = CLng(.Add(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError = "") Then
            UpdateBarterPayments(.Payments)
         End If
         xmlBarterAd = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") Then
            tmpDescription = StripHTML(.Description)
            Result = CLng(.UpdateFT(CLng(.BarterAdID), .Title, .Location, .Zip, tmpDescription))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End If
         If (xmlError <> "") Or (reload <> 0) Then
            SetupBarterAd oBarterAd, reqBarterAdID
         End If
      End With
   End If
   Set oBarterAd = Nothing
End Function

Function UpdateBarterPayments(payments)
   On Error Resume Next

   Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
   If oConsumer Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
   Else
      With oConsumer
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqConsumerID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Barter = SetBarterPayments(.Barter, payments )
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oConsumer = Nothing
End Function

Sub InitBarterAd()
   On Error Resume Next

   If (reqBarterAdID = 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqConsumerID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpContactName = .Namefirst + " " + .NameLast
            tmpContactEmail = .Email
            tmpContactPhone = .Phone
            GetBarterPayments .Barter, tmpPayments
         End With
      End If
      Set oConsumer = Nothing
   End If

   Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
   If oBarterAd Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
   Else
      With oBarterAd
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBarterAdID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (InStr(.GeoCode, "Err:") <> 0) Then
            reqMapErr = 1
         End If
         If (reqBarterAdID <> 0) Then
            reqBarterCategoryID = .BarterCategoryID
            reqBarterArea1ID = .BarterArea1ID
            reqBarterArea2ID = .BarterArea2ID
         End If
         If (reqBarterAdID = 0) Then
            .ConsumerID = reqConsumerID
            .BarterArea1ID = reqBarterArea1ID
            .BarterArea2ID = reqBarterArea2ID
            .BarterCategoryID = reqBarterCategoryID
            .Status = 1
            .ContactName = tmpContactName
            .ContactEmail = tmpContactEmail
            .ContactPhone = tmpContactPhone
            .IsEmail = 1
            .IsPhone = 1
            .Language = "en"
            If (tmpPayments = "") Then
               tmpPayments = "1"
            End If
            .Payments = tmpPayments
         End If
         SetPayments(.Payments)
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
            xmlBarterImages = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterImages = Nothing
   End If
End Sub

Sub SetupBarterCategorys()
   On Error Resume Next

   Set oBarterCategorys = server.CreateObject("ptsBarterCategoryUser.CBarterCategorys")
   If oBarterCategorys Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCategoryUser.CBarterCategorys"
   Else
      With oBarterCategorys
         .SysCurrentLanguage = reqSysLanguage
         .ListAll CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         xmlBarterCategorys = .XML(13)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBarterCategorys = Nothing

   If (reqBarterArea1ID <> 0) Then
      Set oBarterArea = server.CreateObject("ptsBarterAreaUser.CBarterArea")
      If oBarterArea Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterArea"
      Else
         With oBarterArea
            .SysCurrentLanguage = reqSysLanguage
            If (reqBarterArea2ID = 0) Then
               .Load CLng(reqBarterArea1ID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqBarterArea2ID <> 0) Then
               .Load CLng(reqBarterArea2ID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            reqAreaCategory = .BarterAreaName
            reqAreaParentID = .ParentID
            reqCityAreas = .Children
            tmpCountryID = .CountryID
         End With
      End If
      Set oBarterArea = Nothing
   End If

   If (reqCityAreas <> 0) Then
      Set oBarterAreas = server.CreateObject("ptsBarterAreaUser.CBarterAreas")
      If oBarterAreas Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterAreas"
      Else
         With oBarterAreas
            .SysCurrentLanguage = reqSysLanguage
            .ListActive CLng(reqBarterArea1ID), tmpCountryID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlBarterAreas = .XML(13)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterAreas = Nothing
   End If
End Sub

If (reqBarterAdID = 0) Then
   If (reqBarterArea1ID = 0) Then
      reqBarterArea1ID = Numeric(GetCache("BARTERCITY"))
   End If
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      If (reqBarterAdID <> 0) Or (reqBarterCategoryID <> 0) Then
         InitBarterAd
         reqMode = 1
      End If
      If (reqBarterAdID = 0) And (reqBarterCategoryID = 0) Then
         SetupBarterCategorys
      End If

   Case CLng(cActionUpdate):
      UpdateBarterAd 0

      If (xmlError = "") Then
         reqReturnURL = GetCache("17203URL")
         reqReturnData = GetCache("17203DATA")
         SetCache "17203URL", ""
         SetCache "17203DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUpdateStay):
      UpdateBarterAd 1

   Case CLng(cActionAdd):
      AddBarterAd 0

      If (xmlError = "") Then
         reqReturnURL = GetCache("17203URL")
         reqReturnData = GetCache("17203DATA")
         SetCache "17203URL", ""
         SetCache "17203DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionAddStay):
      AddBarterAd 1

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("17203URL")
      reqReturnData = GetCache("17203DATA")
      SetCache "17203URL", ""
      SetCache "17203DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
      If oBarterAd Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
      Else
         With oBarterAd
            .SysCurrentLanguage = reqSysLanguage
            .Delete CLng(reqBarterAdID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterAd = Nothing

      If (xmlError <> "") Then
         Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
         If oBarterAd Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
         Else
            With oBarterAd
               .SysCurrentLanguage = reqSysLanguage
               .Load CLng(reqBarterAdID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               xmlBarterAd = .XML(2)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oBarterAd = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("17203URL")
         reqReturnData = GetCache("17203DATA")
         SetCache "17203URL", ""
         SetCache "17203DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
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
xmlParam = xmlParam + " consumerid=" + Chr(34) + CStr(reqConsumerID) + Chr(34)
xmlParam = xmlParam + " barterarea1id=" + Chr(34) + CStr(reqBarterArea1ID) + Chr(34)
xmlParam = xmlParam + " barterarea2id=" + Chr(34) + CStr(reqBarterArea2ID) + Chr(34)
xmlParam = xmlParam + " bartercategoryid=" + Chr(34) + CStr(reqBarterCategoryID) + Chr(34)
xmlParam = xmlParam + " iscustomfields=" + Chr(34) + CStr(reqIsCustomFields) + Chr(34)
xmlParam = xmlParam + " noprice=" + Chr(34) + CStr(reqNoPrice) + Chr(34)
xmlParam = xmlParam + " nocondition=" + Chr(34) + CStr(reqNoCondition) + Chr(34)
xmlParam = xmlParam + " areacategory=" + Chr(34) + CleanXML(reqAreaCategory) + Chr(34)
xmlParam = xmlParam + " mode=" + Chr(34) + CStr(reqMode) + Chr(34)
xmlParam = xmlParam + " maperr=" + Chr(34) + CStr(reqMapErr) + Chr(34)
xmlParam = xmlParam + " areaparentid=" + Chr(34) + CStr(reqAreaParentID) + Chr(34)
xmlParam = xmlParam + " cityareas=" + Chr(34) + CStr(reqCityAreas) + Chr(34)
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
xmlTransaction = xmlTransaction +  xmlBarterCategory
xmlTransaction = xmlTransaction +  xmlBarterArea
xmlTransaction = xmlTransaction +  xmlBarterAd
xmlTransaction = xmlTransaction +  xmlBarterImages
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlBarterCategorys
xmlTransaction = xmlTransaction +  xmlBarterAreas
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
   Response.Write "17203 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "17203 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "17203 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "17203.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "17203 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "17203 Load file (oData) failed with error code " + CStr(oData.parseError)
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