<!--#include file="Include\System.asp"-->
<!--#include file="Include\Search.asp"-->
<!--#include file="Include\BarterOptions.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionRefresh = 4
Const cActionFind = 5
Const cActionPrevious = 6
Const cActionNext = 7
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
Dim oMember, xmlMember
Dim oMerchant, xmlMerchant
Dim oConsumer, xmlConsumer
Dim oBarterCategory, xmlBarterCategory
Dim oBarterAds, xmlBarterAds
Dim oBarterAreas, xmlBarterAreas
'-----other transaction data variables
Dim xmlAdCampaign
'-----declare page parameters
Dim reqConsumerID
Dim reqCompanyID
Dim reqBarterAreaID
Dim reqBarterSubAreaID
Dim reqMainCategoryID
Dim reqBarterCategoryID
Dim reqAreaParentID
Dim reqSearchAll
Dim reqIsImages
Dim reqSubAreas
Dim reqMinPrice
Dim reqMaxPrice
Dim reqSearchText
Dim reqFindTypeID
Dim reqBookmark
Dim reqDirection
Dim reqIsSearch
Dim reqView
Dim reqSort
Dim reqTitle
Dim reqBarterArea
Dim reqMainCategory
Dim reqSubCategory
Dim reqReferredBy
Dim reqBarterAreas
Dim reqNoPrice
Dim reqNoCondition
Dim reqCondition0
Dim reqCondition1
Dim reqCondition2
Dim reqCondition3
Dim reqCondition4
Dim reqCondition5
Dim reqCondition6
Dim reqCondition7
Dim reqPayment0
Dim reqPayment1
Dim reqPayment2
Dim reqPayment3
Dim reqPayment4
Dim reqPayment5
Dim reqPayment6
Dim reqPayment7
Dim reqPayment8
Dim reqPayment9
Dim reqPayment10
Dim reqPayment11
Dim reqPayment12
Dim reqPayment13
Dim reqPayment14
Dim reqPayment15
Dim reqPayment16
Dim reqFilterOptions
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

'-----save the return URL and form data if supplied
If (Len(Request.Item("ReturnURL")) > 0) Then
   reqReturnURL = Replace(Request.Item("ReturnURL"), "&", "%26")
   reqReturnData = Replace(Request.Item("ReturnData"), "&", "%26")
   SetCache "17200URL", reqReturnURL
   SetCache "17200DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "17200")
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
reqConsumerID =  Numeric(GetInput("ConsumerID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqBarterAreaID =  Numeric(GetInput("BarterAreaID", reqPageData))
reqBarterSubAreaID =  Numeric(GetInput("BarterSubAreaID", reqPageData))
reqMainCategoryID =  Numeric(GetInput("MainCategoryID", reqPageData))
reqBarterCategoryID =  Numeric(GetInput("BarterCategoryID", reqPageData))
reqAreaParentID =  Numeric(GetInput("AreaParentID", reqPageData))
reqSearchAll =  Numeric(GetInput("SearchAll", reqPageData))
reqIsImages =  Numeric(GetInput("IsImages", reqPageData))
reqSubAreas =  Numeric(GetInput("SubAreas", reqPageData))
reqMinPrice =  GetInput("MinPrice", reqPageData)
reqMaxPrice =  GetInput("MaxPrice", reqPageData)
reqSearchText =  GetInput("SearchText", reqPageData)
reqFindTypeID =  Numeric(GetInput("FindTypeID", reqPageData))
reqBookmark =  GetInput("Bookmark", reqPageData)
reqDirection =  Numeric(GetInput("Direction", reqPageData))
reqIsSearch =  Numeric(GetInput("IsSearch", reqPageData))
reqView =  Numeric(GetInput("View", reqPageData))
reqSort =  Numeric(GetInput("Sort", reqPageData))
reqTitle =  GetInput("Title", reqPageData)
reqBarterArea =  GetInput("BarterArea", reqPageData)
reqMainCategory =  GetInput("MainCategory", reqPageData)
reqSubCategory =  GetInput("SubCategory", reqPageData)
reqReferredBy =  GetInput("ReferredBy", reqPageData)
reqBarterAreas =  GetInput("BarterAreas", reqPageData)
reqNoPrice =  Numeric(GetInput("NoPrice", reqPageData))
reqNoCondition =  Numeric(GetInput("NoCondition", reqPageData))
reqCondition0 =  Numeric(GetInput("Condition0", reqPageData))
reqCondition1 =  Numeric(GetInput("Condition1", reqPageData))
reqCondition2 =  Numeric(GetInput("Condition2", reqPageData))
reqCondition3 =  Numeric(GetInput("Condition3", reqPageData))
reqCondition4 =  Numeric(GetInput("Condition4", reqPageData))
reqCondition5 =  Numeric(GetInput("Condition5", reqPageData))
reqCondition6 =  Numeric(GetInput("Condition6", reqPageData))
reqCondition7 =  Numeric(GetInput("Condition7", reqPageData))
reqPayment0 =  Numeric(GetInput("Payment0", reqPageData))
reqPayment1 =  Numeric(GetInput("Payment1", reqPageData))
reqPayment2 =  Numeric(GetInput("Payment2", reqPageData))
reqPayment3 =  Numeric(GetInput("Payment3", reqPageData))
reqPayment4 =  Numeric(GetInput("Payment4", reqPageData))
reqPayment5 =  Numeric(GetInput("Payment5", reqPageData))
reqPayment6 =  Numeric(GetInput("Payment6", reqPageData))
reqPayment7 =  Numeric(GetInput("Payment7", reqPageData))
reqPayment8 =  Numeric(GetInput("Payment8", reqPageData))
reqPayment9 =  Numeric(GetInput("Payment9", reqPageData))
reqPayment10 =  Numeric(GetInput("Payment10", reqPageData))
reqPayment11 =  Numeric(GetInput("Payment11", reqPageData))
reqPayment12 =  Numeric(GetInput("Payment12", reqPageData))
reqPayment13 =  Numeric(GetInput("Payment13", reqPageData))
reqPayment14 =  Numeric(GetInput("Payment14", reqPageData))
reqPayment15 =  Numeric(GetInput("Payment15", reqPageData))
reqPayment16 =  Numeric(GetInput("Payment16", reqPageData))
reqFilterOptions =  GetInput("FilterOptions", reqPageData)
reqTest =  Numeric(GetInput("Test", reqPageData))
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

Function GetReferredBy(MemberID, MerchantID, ReferID)
   On Error Resume Next
   reqReferredBy = ""

   If (MemberID <> 0) Then
      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load MemberID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .NameFirst + " " + .NameLast
         End With
      End If
      Set oMember = Nothing
   End If

   If (MerchantID <> 0) Then
      Set oMerchant = server.CreateObject("ptsMerchantUser.CMerchant")
      If oMerchant Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMerchantUser.CMerchant"
      Else
         With oMerchant
            .SysCurrentLanguage = reqSysLanguage
            .Load MerchantID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = .MerchantName
         End With
      End If
      Set oMerchant = Nothing
   End If

   If (ReferID <> 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load ReferID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqReferredBy = reqReferredBy + " / " + .NameFirst + " " + .NameLast
         End With
      End If
      Set oConsumer = Nothing
   End If
End Function

Sub LoadSearch()
   On Error Resume Next

   If (reqConsumerID <> 0) Then
      Set oConsumer = server.CreateObject("ptsConsumerUser.CConsumer")
      If oConsumer Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsConsumerUser.CConsumer"
      Else
         With oConsumer
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqConsumerID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqTitle = CleanXML(.NameFirst + " " + .NameLast)
            tmpBarterAreaID = Request.Form.Item("BarterAreaID")
            tmpBarterCategoryID = Request.Form.Item("BarterCategoryID")
            GetBarterAreaCategory .Barter, reqBarterAreaID, reqBarterCategoryID
            If (tmpBarterAreaID <> "") And (tmpBarterAreaID <> reqBarterAreaID) Then
               reqBarterAreaID = Request.Form.Item("BarterAreaID")
               .Barter = SetBarterAreaCategory(.Barter, reqBarterAreaID, reqBarterCategoryID )
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (tmpBarterCategoryID <> "") And (tmpBarterCategoryID <> reqBarterCategoryID) Then
               reqBarterCategoryID = Request.Form.Item("BarterCategoryID")
               .Barter = SetBarterAreaCategory(.Barter, reqBarterAreaID, reqBarterCategoryID )
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End If
            If (reqBarterAreaID = 0) Then
               reqTitle = reqTitle + " - SELECT CITY"
            End If
            If (reqReferredBy = "") Then
               GetReferredBy .MemberID, .MerchantID, .ReferID
            End If
         End With
      End If
      Set oConsumer = Nothing
   End If
   If (reqBarterAreaID <> 0) Then

      Set oBarterArea = server.CreateObject("ptsBarterAreaUser.CBarterArea")
      If oBarterArea Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterArea"
      Else
         With oBarterArea
            .SysCurrentLanguage = reqSysLanguage
            .Load reqBarterAreaID, CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpCountryID = .CountryID
            reqAreaParentID = .ParentID
            reqTitle = reqTitle + " - " + .BarterAreaName
         End With
      End If
      Set oBarterArea = Nothing

      Set oBarterAreas = server.CreateObject("ptsBarterAreaUser.CBarterAreas")
      If oBarterAreas Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterAreas"
      Else
         With oBarterAreas
            .SysCurrentLanguage = reqSysLanguage
            .ListActive reqBarterAreaID, tmpCountryID
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
              reqBarterAreas = "<PTSBARTERAREAS><ENUM id=""0"" name=""All Areas""/>"
              reqSubAreas = 0
              For Each oItem in oBarterAreas
                reqSubAreas = reqSubAreas + 1
                With oItem
                  reqBarterAreas = reqBarterAreas + "<ENUM id=""" + .BarterAreaID + """ name=""" + .BarterAreaName+ """/>"
                End With
              Next
              reqBarterAreas = reqBarterAreas + "</PTSBARTERAREAS>"
              
         End With
      End If
      Set oBarterAreas = Nothing
   End If
   reqMainCategoryID = 0
   reqMainCategory = ""
   reqSubCategory = ""
   reqNoPrice = 0
   reqNoCondition = 0

   If (reqBarterCategoryID <> 0) Then
      Set oBarterCategory = server.CreateObject("ptsBarterCategoryUser.CBarterCategory")
      If oBarterCategory Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCategoryUser.CBarterCategory"
      Else
         With oBarterCategory
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBarterCategoryID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (.ParentID = 0) Then
               reqMainCategoryID = reqBarterCategoryID
               reqBarterCategoryID = 0
               reqMainCategory = .BarterCategoryName
               
                If InStr(.Options, "A") > 0 Then reqNoPrice = 1
                If InStr(.Options, "B") > 0 Then reqNoCondition = 1
              
            End If
            If (.ParentID <> 0) Then
               reqMainCategoryID = .ParentID
               reqSubCategory = .BarterCategoryName
               
                If InStr(.Options, "A") > 0 Then reqNoPrice = 1
                If InStr(.Options, "B") > 0 Then reqNoCondition = 1
              
               .Load .ParentID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqMainCategory = .BarterCategoryName
            End If
         End With
      End If
      Set oBarterCategory = Nothing
   End If
End Sub

If (reqCompanyID = 0) Then
   reqCompanyID = 21
End If
If (reqConsumerID = 0) Then
   reqConsumerID = Numeric(GetCache("CONSUMER"))
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      reqIsSearch = 1
      reqBookmark = ""
      reqDirection = 1
      reqView = 1
      reqSort = 1
      reqCondition0 = 1
      LoadSearch

   Case CLng(cActionRefresh):
      LoadSearch
      reqBookmark = ""
      reqDirection = 1
      reqIsSearch = 1

   Case CLng(cActionFind):
      reqBookmark = ""
      reqDirection = 1
      reqIsSearch = 1

   Case CLng(cActionPrevious):
      reqDirection = 2
      reqIsSearch = 1

   Case CLng(cActionNext):
      reqDirection = 1
      reqIsSearch = 1
End Select

If (reqIsSearch = 1) Then
   Set oBarterAds = server.CreateObject("ptsBarterAdUser.CBarterAds")
   If oBarterAds Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAds"
   Else
      With oBarterAds
         .SysCurrentLanguage = reqSysLanguage
         
          xmlBarterAreas = reqBarterAreas
          tmpOptions = ""
          
          If reqNoPrice = 0 Then
            'BUILD PRICE OPTION
            MinPrice = Numeric(Request.Form.Item("MinPrice"))
            MaxPrice = Numeric(Request.Form.Item("MaxPrice"))
            If MinPrice > 0 OR MaxPrice > 0 Then
          If MaxPrice = 0 Then MaxPrice = 99999999
          tmpOptions = tmpOptions + "Price:" + CSTR(MinPrice) + "," + CSTR(MaxPrice) + ";"
          End If

          'BUILD PAYMENT OPTION
          tmp = Request.Form.Item("Payment0")
          'check for all payments
          If tmp = "" Then
          str = ""
          For x = 1 to 16
          tmp = Request.Form.Item("Payment" + CSTR(x) )
          If tmp = "1" Then
          Select Case x
          Case 1: str = str + "1,"
          Case 2: str = str + "2,"
          Case 3: str = str + "3,"
          Case 4: str = str + "4,"
          Case 5: str = str + "A,"
          Case 6: str = str + "B,"
          Case 7: str = str + "C,"
          Case 8: str = str + "D,"
          Case 9: str = str + "E,"
          Case 10: str = str + "F,"
          Case 11: str = str + "G,"
          Case 12: str = str + "H,"
          Case 13: str = str + "I,"
          Case 14: str = str + "J,"
          Case 15: str = str + "Y,"
          Case 16: str = str + "Z,"
          End Select
          End If
          Next
          IF str <> "" Then tmpOptions = tmpOptions + "Payment:" + str
            End If
          End If

          If reqNoCondition = 0 Then
            'BUILD CONDITION OPTION
            tmp = Request.Form.Item("Condition0")
            'check for all conditions
            If tmp = "" Then
              str = ""
              For x = 1 to 7
                tmp = Request.Form.Item("Condition" + CSTR(x) )
                If tmp = "1" Then str = str + CSTR(x) + ","
              Next
              IF str <> "" Then tmpOptions = tmpOptions + "Condition:" + str
          End If
          End If

          If TRIM(reqSearchText) = "" Then
          SearchType = 5
          'reqBookmark = ""
          'reqDirection = 1
          tmpSearchText = ""
          Else
          SearchType = 1
          tmpSearchText = SearchText(Trim(reqSearchText))
          End If

          SearchType = SearchType + (reqSort-1)
          If reqView = 3 Then SearchType = SearchType + 10

          tmpBarterAreaID = reqBarterAreaID
          tmpBarterSubAreaID = reqBarterSubAreaID
          If reqSearchAll = 1 Then
          tmpBarterAreaID = 0
          tmpBarterSubAreaID = 0
          End If

          If reqTest = 1 Then
            response.write "<BR>Bookmark: " + reqBookmark
            response.write "<BR>SearchText: " + tmpSearchText
            response.write "<BR>SearchType: " + CSTR(SearchType)
            response.write "<BR>City: " + CSTR(tmpBarterAreaID)
            response.write "<BR>SubArea: " + CSTR(tmpBarterSubAreaID)
            response.write "<BR>Main Category: " + CSTR(reqMainCategoryID)
            response.write "<BR>Sub Category: " + CSTR(reqBarterCategoryID)
            response.write "<BR>Only Images: " + CSTR(reqIsImages)
            response.write "<BR>Options: " + tmpOptions
            response.write "<BR>"
          End If

          reqBookmark = .Search(reqBookmark, tmpSearchText, reqDirection, SearchType, tmpBarterAreaID, tmpBarterSubAreaID, reqMainCategoryID, reqBarterCategoryID, reqIsImages, tmpOptions)

          If reqTest = 1 Then
          response.write "<BR>Bookmark: " + reqBookmark
            response.write "<BR>"
          End If

          'Check for error for Noise Words only
          If Err.Number = -2147217900 Then
          Err.Number = 0
          reqSearchText = ""
          End If
          If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
        
         xmlBarterAds = .XMLSearch()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBarterAds = Nothing
End If

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

If (reqIsSearch = 1) And (reqSearchAll = 0) Then
   Set oBarterArea = server.CreateObject("ptsBarterAreaUser.CBarterArea")
   If oBarterArea Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAreaUser.CBarterArea"
   Else
      With oBarterArea
         .SysCurrentLanguage = reqSysLanguage
         
          If reqBarterSubAreaID > 0 Then tmpBarterAreaID = reqBarterSubAreaID Else tmpBarterAreaID = reqBarterAreaID
        
         Locations = .Custom(1, tmpBarterAreaID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBarterArea = Nothing
End If

If (reqIsSearch = 1) Then
   Set oBarterAds = server.CreateObject("ptsBarterAdUser.CBarterAds")
   If oBarterAds Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAds"
   Else
      With oBarterAds
         .SysCurrentLanguage = reqSysLanguage
         
          'Get Ad Campaigns
          'Build Ad Campaign Search String (k or p) and (s or m) and (c or a)
          str = ""
          If reqSearchText <> "" Then str = "((" + SearchText(Trim(reqSearchText)) + ") or ANY-KEY) and "
          str = str + "("
          If reqSubCategory <> "" Then str = str + """" + reqSubCategory + """"
          If reqSubCategory <> "" AND reqMainCategory <> "" Then str = str + " or "
          If reqMainCategory <> "" Then str = str + """" + reqMainCategory + """"
          If reqSubCategory = "" And reqMainCategory = "" Then str = str + "ALL-CAT"
          str = str + " or ANY-CAT) and ("
          If reqSearchAll = 1 Then str = str + "ALL-LOC"
          If reqSearchAll = 0 Then str = str + Locations
          str = str + " or ANY-LOC)"
          tmpSearchText = str
          SearchType = 100

          If reqTest = 2 Then response.write "<BR>SearchText: " + tmpSearchText

          tmpBookmark = .Search(reqBookmark, tmpSearchText, reqDirection, SearchType, tmpBarterAreaID, tmpBarterSubAreaID, reqMainCategoryID, reqBarterCategoryID, reqIsImages, tmpOptions)
        
         xmlAdCampaign = .XMLSearch(, "AdCampaign")
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oBarterAds = Nothing
End If

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
xmlParam = xmlParam + " consumerid=" + Chr(34) + CStr(reqConsumerID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " barterareaid=" + Chr(34) + CStr(reqBarterAreaID) + Chr(34)
xmlParam = xmlParam + " bartersubareaid=" + Chr(34) + CStr(reqBarterSubAreaID) + Chr(34)
xmlParam = xmlParam + " maincategoryid=" + Chr(34) + CStr(reqMainCategoryID) + Chr(34)
xmlParam = xmlParam + " bartercategoryid=" + Chr(34) + CStr(reqBarterCategoryID) + Chr(34)
xmlParam = xmlParam + " areaparentid=" + Chr(34) + CStr(reqAreaParentID) + Chr(34)
xmlParam = xmlParam + " searchall=" + Chr(34) + CStr(reqSearchAll) + Chr(34)
xmlParam = xmlParam + " isimages=" + Chr(34) + CStr(reqIsImages) + Chr(34)
xmlParam = xmlParam + " subareas=" + Chr(34) + CStr(reqSubAreas) + Chr(34)
xmlParam = xmlParam + " minprice=" + Chr(34) + CStr(reqMinPrice) + Chr(34)
xmlParam = xmlParam + " maxprice=" + Chr(34) + CStr(reqMaxPrice) + Chr(34)
xmlParam = xmlParam + " searchtext=" + Chr(34) + CleanXML(reqSearchText) + Chr(34)
xmlParam = xmlParam + " findtypeid=" + Chr(34) + CStr(reqFindTypeID) + Chr(34)
xmlParam = xmlParam + " bookmark=" + Chr(34) + CleanXML(reqBookmark) + Chr(34)
xmlParam = xmlParam + " direction=" + Chr(34) + CStr(reqDirection) + Chr(34)
xmlParam = xmlParam + " issearch=" + Chr(34) + CStr(reqIsSearch) + Chr(34)
xmlParam = xmlParam + " view=" + Chr(34) + CStr(reqView) + Chr(34)
xmlParam = xmlParam + " sort=" + Chr(34) + CStr(reqSort) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CleanXML(reqTitle) + Chr(34)
xmlParam = xmlParam + " barterarea=" + Chr(34) + CleanXML(reqBarterArea) + Chr(34)
xmlParam = xmlParam + " maincategory=" + Chr(34) + CleanXML(reqMainCategory) + Chr(34)
xmlParam = xmlParam + " subcategory=" + Chr(34) + CleanXML(reqSubCategory) + Chr(34)
xmlParam = xmlParam + " referredby=" + Chr(34) + CleanXML(reqReferredBy) + Chr(34)
xmlParam = xmlParam + " barterareas=" + Chr(34) + CleanXML(reqBarterAreas) + Chr(34)
xmlParam = xmlParam + " noprice=" + Chr(34) + CStr(reqNoPrice) + Chr(34)
xmlParam = xmlParam + " nocondition=" + Chr(34) + CStr(reqNoCondition) + Chr(34)
xmlParam = xmlParam + " condition0=" + Chr(34) + CStr(reqCondition0) + Chr(34)
xmlParam = xmlParam + " condition1=" + Chr(34) + CStr(reqCondition1) + Chr(34)
xmlParam = xmlParam + " condition2=" + Chr(34) + CStr(reqCondition2) + Chr(34)
xmlParam = xmlParam + " condition3=" + Chr(34) + CStr(reqCondition3) + Chr(34)
xmlParam = xmlParam + " condition4=" + Chr(34) + CStr(reqCondition4) + Chr(34)
xmlParam = xmlParam + " condition5=" + Chr(34) + CStr(reqCondition5) + Chr(34)
xmlParam = xmlParam + " condition6=" + Chr(34) + CStr(reqCondition6) + Chr(34)
xmlParam = xmlParam + " condition7=" + Chr(34) + CStr(reqCondition7) + Chr(34)
xmlParam = xmlParam + " payment0=" + Chr(34) + CStr(reqPayment0) + Chr(34)
xmlParam = xmlParam + " payment1=" + Chr(34) + CStr(reqPayment1) + Chr(34)
xmlParam = xmlParam + " payment2=" + Chr(34) + CStr(reqPayment2) + Chr(34)
xmlParam = xmlParam + " payment3=" + Chr(34) + CStr(reqPayment3) + Chr(34)
xmlParam = xmlParam + " payment4=" + Chr(34) + CStr(reqPayment4) + Chr(34)
xmlParam = xmlParam + " payment5=" + Chr(34) + CStr(reqPayment5) + Chr(34)
xmlParam = xmlParam + " payment6=" + Chr(34) + CStr(reqPayment6) + Chr(34)
xmlParam = xmlParam + " payment7=" + Chr(34) + CStr(reqPayment7) + Chr(34)
xmlParam = xmlParam + " payment8=" + Chr(34) + CStr(reqPayment8) + Chr(34)
xmlParam = xmlParam + " payment9=" + Chr(34) + CStr(reqPayment9) + Chr(34)
xmlParam = xmlParam + " payment10=" + Chr(34) + CStr(reqPayment10) + Chr(34)
xmlParam = xmlParam + " payment11=" + Chr(34) + CStr(reqPayment11) + Chr(34)
xmlParam = xmlParam + " payment12=" + Chr(34) + CStr(reqPayment12) + Chr(34)
xmlParam = xmlParam + " payment13=" + Chr(34) + CStr(reqPayment13) + Chr(34)
xmlParam = xmlParam + " payment14=" + Chr(34) + CStr(reqPayment14) + Chr(34)
xmlParam = xmlParam + " payment15=" + Chr(34) + CStr(reqPayment15) + Chr(34)
xmlParam = xmlParam + " payment16=" + Chr(34) + CStr(reqPayment16) + Chr(34)
xmlParam = xmlParam + " filteroptions=" + Chr(34) + CleanXML(reqFilterOptions) + Chr(34)
xmlParam = xmlParam + " test=" + Chr(34) + CStr(reqTest) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlMerchant
xmlTransaction = xmlTransaction +  xmlConsumer
xmlTransaction = xmlTransaction +  xmlBarterCategory
xmlTransaction = xmlTransaction +  xmlBarterAds
xmlTransaction = xmlTransaction +  xmlBarterAreas
xmlTransaction = xmlTransaction +  xmlAdCampaign
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
   Response.Write "17200 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "17200 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "17200 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "17200.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "17200 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "17200 Load file (oData) failed with error code " + CStr(oData.parseError)
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