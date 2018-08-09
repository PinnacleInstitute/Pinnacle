<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
Const cActionAdd = 2
Const cActionCancel = 3
Const cActionDelete = 4
Const cActionUpdateLoad = 5
Const cActionAddLoad = 6
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
Dim oBarterCampaign, xmlBarterCampaign
Dim oBarterCredit, xmlBarterCredit
Dim oBarterAd, xmlBarterAd
'-----declare page parameters
Dim reqBarterCampaignID
Dim reqBarterAdID
Dim reqCountry
Dim reqState
Dim reqCity
Dim reqArea
Dim reqMainCategory
Dim reqSubCategory
Dim reqSelectAreaID
Dim reqSelectCategoryID
Dim reqAvailable
Dim reqTotal
Dim reqNegative
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
   SetCache "17503URL", reqReturnURL
   SetCache "17503DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "17503")
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
reqBarterCampaignID =  Numeric(GetInput("BarterCampaignID", reqPageData))
reqBarterAdID =  Numeric(GetInput("BarterAdID", reqPageData))
reqCountry =  GetInput("Country", reqPageData)
reqState =  GetInput("State", reqPageData)
reqCity =  GetInput("City", reqPageData)
reqArea =  GetInput("Area", reqPageData)
reqMainCategory =  GetInput("MainCategory", reqPageData)
reqSubCategory =  GetInput("SubCategory", reqPageData)
reqSelectAreaID =  Numeric(GetInput("SelectAreaID", reqPageData))
reqSelectCategoryID =  Numeric(GetInput("SelectCategoryID", reqPageData))
reqAvailable =  GetInput("Available", reqPageData)
reqTotal =  GetInput("Total", reqPageData)
reqNegative =  Numeric(GetInput("Negative", reqPageData))
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

Sub UpdateBarterCampaign()
   On Error Resume Next

   Set oBarterCampaign = server.CreateObject("ptsBarterCampaignUser.CBarterCampaign")
   If oBarterCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCampaignUser.CBarterCampaign"
   Else
      With oBarterCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBarterCampaignID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         tmpStatus = .Status

         .ConsumerID = Request.Form.Item("ConsumerID")
         .BarterAdID = Request.Form.Item("BarterAdID")
         .BarterAreaID = Request.Form.Item("BarterAreaID")
         .BarterCategoryID = Request.Form.Item("BarterCategoryID")
         .Status = Request.Form.Item("Status")
         .StartDate = Request.Form.Item("StartDate")
         .EndDate = Request.Form.Item("EndDate")
         .Credits = Request.Form.Item("Credits")
         .CampaignName = Request.Form.Item("CampaignName")
         .IsKeyword = Request.Form.Item("IsKeyword")
         .Keyword = Request.Form.Item("Keyword")
         .IsAllCategory = Request.Form.Item("IsAllCategory")
         .IsMainCategory = Request.Form.Item("IsMainCategory")
         .IsSubCategory = Request.Form.Item("IsSubCategory")
         .IsAllLocation = Request.Form.Item("IsAllLocation")
         .IsCountry = Request.Form.Item("IsCountry")
         .IsState = Request.Form.Item("IsState")
         .IsCity = Request.Form.Item("IsCity")
         .IsArea = Request.Form.Item("IsArea")
         
            str = ""
            If .IsKeyword = "1" Then str = str + .Keyword + " "
            If .IsKeyword = "" Then str = str + "ANY-KEY "
            If .IsSubCategory = "1" Then str = str + """" + reqSubCategory + """ "
            If .IsMainCategory = "1" Then str = str + """" + reqMainCategory + """ "
            If .IsAllCategory = "1" Then str = str + "ALL-CAT "
            If .IsSubCategory = "" And .IsMainCategory = "" And .IsAllCategory = "" Then str = str + "ANY-CAT "
            If .IsArea = "1" Then str = str + """" + reqArea + """ "
            If .IsCity = "1" Then str = str + """" + reqCity + """ "
            If .IsState = "1" Then str = str + """" + reqState + """ "
            If .IsCountry = "1" Then str = str + """" + reqCountry + """ "
            If .IsAllLocation = "1" Then str = str + "ALL-LOC "
            If .IsArea = "" And .IsCity = "" And .IsState = "" And .IsAllLocation = "" Then str = str + "ANY-LOC"
            .FT = str
          
         .Save CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (tmpStatus = 1) And (.Status = 2) Then
            Result = .Custom(2, CLng(reqBarterCampaignID), 0, 0)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result = "1") Then
               DoError 0, "", "Oops, Campaign Status not Active!"
            End If
            If (Result = "2") Then
               DoError 0, "", "Oops, Insufficient Barter Credits for this Campaign!"
            End If
            If (Result = "3") Then
               DoError 0, "", "Oops, No Targets Selected!"
            End If
         End If
         If (xmlError <> "") Then
            xmlBarterCampaign = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            LoadCredits .ConsumerID
         End If
      End With
   End If
   Set oBarterCampaign = Nothing
End Sub

Sub AddBarterCampaign()
   On Error Resume Next

   Set oBarterCampaign = server.CreateObject("ptsBarterCampaignUser.CBarterCampaign")
   If oBarterCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCampaignUser.CBarterCampaign"
   Else
      With oBarterCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load 0, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

         .ConsumerID = Request.Form.Item("ConsumerID")
         .BarterAdID = Request.Form.Item("BarterAdID")
         .BarterAreaID = Request.Form.Item("BarterAreaID")
         .BarterCategoryID = Request.Form.Item("BarterCategoryID")
         .Status = Request.Form.Item("Status")
         .StartDate = Request.Form.Item("StartDate")
         .EndDate = Request.Form.Item("EndDate")
         .Credits = Request.Form.Item("Credits")
         .CampaignName = Request.Form.Item("CampaignName")
         .IsKeyword = Request.Form.Item("IsKeyword")
         .Keyword = Request.Form.Item("Keyword")
         .IsAllCategory = Request.Form.Item("IsAllCategory")
         .IsMainCategory = Request.Form.Item("IsMainCategory")
         .IsSubCategory = Request.Form.Item("IsSubCategory")
         .IsAllLocation = Request.Form.Item("IsAllLocation")
         .IsCountry = Request.Form.Item("IsCountry")
         .IsState = Request.Form.Item("IsState")
         .IsCity = Request.Form.Item("IsCity")
         .IsArea = Request.Form.Item("IsArea")
         
            str = ""
            If .IsKeyword = "1" Then str = str + .Keyword + " "
            If .IsKeyword = "" Then str = str + "ANY-KEY "
            If .IsSubCategory = "1" Then str = str + """" + reqSubCategory + """ "
            If .IsMainCategory = "1" Then str = str + """" + reqMainCategory + """ "
            If .IsAllCategory = "1" Then str = str + "ALL-CAT "
            If .IsSubCategory = "" And .IsMainCategory = "" And .IsAllCategory = "" Then str = str + "ANY-CAT "
            If .IsArea = "1" Then str = str + """" + reqArea + """ "
            If .IsCity = "1" Then str = str + """" + reqCity + """ "
            If .IsState = "1" Then str = str + """" + reqState + """ "
            If .IsCountry = "1" Then str = str + """" + reqCountry + """ "
            If .IsAllLocation = "1" Then str = str + "ALL-LOC "
            If .IsArea = "" And .IsCity = "" And .IsState = "" And .IsAllLocation = "" Then str = str + "ANY-LOC"
            .FT = str
          
         reqBarterCampaignID = CLng(.Add(CLng(reqSysUserID)))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (xmlError = "") And (.Status = 2) Then
            Result = .Custom(2, CLng(reqBarterCampaignID), 0, 0)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (Result = "1") Then
               DoError 0, "", "Oops, Insufficient Barter Credits for this Campaign!"
            End If
         End If
         If (xmlError <> "") Then
            xmlBarterCampaign = .XML(2)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            LoadCredits .ConsumerID
         End If
      End With
   End If
   Set oBarterCampaign = Nothing
End Sub

Function LoadCredits(ConsumerID)
   On Error Resume Next

   Set oBarterCredit = server.CreateObject("ptsBarterCreditUser.CBarterCredit")
   If oBarterCredit Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCreditUser.CBarterCredit"
   Else
      With oBarterCredit
         .SysCurrentLanguage = reqSysLanguage
         Result = .Total(151, ConsumerID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
              a = Split(Result, ";")
              If a(0) < 0 Then reqNegative = 1
              reqAvailable = FormatNumber(a(0),2)
              reqTotal = FormatNumber(a(1),2)
            
      End With
   End If
   Set oBarterCredit = Nothing
End Function

Sub LoadBarterCampaign()
   On Error Resume Next

   If (reqBarterAdID <> 0) Then
      Set oBarterAd = server.CreateObject("ptsBarterAdUser.CBarterAd")
      If oBarterAd Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterAdUser.CBarterAd"
      Else
         With oBarterAd
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBarterAdID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            tmpConsumerID = .ConsumerID
            tmpBarterAreaID = .BarterArea2ID
            If (tmpBarterAreaID = 0) Then
               tmpBarterAreaID = .BarterArea1ID
            End If
            tmpBarterCategoryID = .BarterCategoryID
            tmpTitle = .Title
         End With
      End If
      Set oBarterAd = Nothing
   End If

   Set oBarterCampaign = server.CreateObject("ptsBarterCampaignUser.CBarterCampaign")
   If oBarterCampaign Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCampaignUser.CBarterCampaign"
   Else
      With oBarterCampaign
         .SysCurrentLanguage = reqSysLanguage
         .Load CLng(reqBarterCampaignID), CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         If (reqBarterCampaignID = 0) Then
            .ConsumerID = tmpConsumerID
            .BarterAdID = reqBarterAdID
            .BarterAreaID = tmpBarterAreaID
            .BarterCategoryID = tmpBarterCategoryID
            .CampaignName = tmpTitle
            .Status = 1
         End If
         tmpConsumerID = .ConsumerID
         tmpStatus = .Status
         xmlBarterCampaign = .XML(2)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         Result = .Custom(1, 0, CLng(.BarterAreaID), CLng(.BarterCategoryID))
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
              a = Split(Result, "|")
              If UBOUND(a) = 7 Then
              reqCountry = a(0)
              reqState = a(1)
              reqCity = a(2)
              reqArea = a(3)
              reqMainCategory = a(4)
              reqSubCategory = a(5)
              reqSelectAreaID = a(6)
              reqSelectCategoryID = a(7)
              End If
            
      End With
   End If
   Set oBarterCampaign = Nothing
   If (tmpStatus = 1) Then
      LoadCredits tmpConsumerID
   End If
End Sub

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):
      LoadBarterCampaign

   Case CLng(cActionUpdate):
      UpdateBarterCampaign
      If (xmlError <> "") Then
         LoadBarterCampaign
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("17503URL")
         reqReturnData = GetCache("17503DATA")
         SetCache "17503URL", ""
         SetCache "17503DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionAdd):
      AddBarterCampaign

      If (xmlError = "") Then
         reqReturnURL = GetCache("17503URL")
         reqReturnData = GetCache("17503DATA")
         SetCache "17503URL", ""
         SetCache "17503DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("17503URL")
      reqReturnData = GetCache("17503DATA")
      SetCache "17503URL", ""
      SetCache "17503DATA", ""
      If (Len(reqReturnURL) > 0) Then
         SetCache "RETURNURL", reqReturnURL
         SetCache "RETURNDATA", reqReturnData
         Response.Redirect Replace(reqReturnURL, "%26", "&")
      End If

   Case CLng(cActionDelete):

      Set oBarterCampaign = server.CreateObject("ptsBarterCampaignUser.CBarterCampaign")
      If oBarterCampaign Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsBarterCampaignUser.CBarterCampaign"
      Else
         With oBarterCampaign
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqBarterCampaignID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            .Delete CLng(reqBarterCampaignID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oBarterCampaign = Nothing

      If (xmlError = "") Then
         reqReturnURL = GetCache("17503URL")
         reqReturnData = GetCache("17503DATA")
         SetCache "17503URL", ""
         SetCache "17503DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionUpdateLoad):
      UpdateBarterCampaign
      LoadBarterCampaign

   Case CLng(cActionAddLoad):
      AddBarterCampaign
      LoadBarterCampaign
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
xmlParam = xmlParam + " bartercampaignid=" + Chr(34) + CStr(reqBarterCampaignID) + Chr(34)
xmlParam = xmlParam + " barteradid=" + Chr(34) + CStr(reqBarterAdID) + Chr(34)
xmlParam = xmlParam + " country=" + Chr(34) + CleanXML(reqCountry) + Chr(34)
xmlParam = xmlParam + " state=" + Chr(34) + CleanXML(reqState) + Chr(34)
xmlParam = xmlParam + " city=" + Chr(34) + CleanXML(reqCity) + Chr(34)
xmlParam = xmlParam + " area=" + Chr(34) + CleanXML(reqArea) + Chr(34)
xmlParam = xmlParam + " maincategory=" + Chr(34) + CleanXML(reqMainCategory) + Chr(34)
xmlParam = xmlParam + " subcategory=" + Chr(34) + CleanXML(reqSubCategory) + Chr(34)
xmlParam = xmlParam + " selectareaid=" + Chr(34) + CStr(reqSelectAreaID) + Chr(34)
xmlParam = xmlParam + " selectcategoryid=" + Chr(34) + CStr(reqSelectCategoryID) + Chr(34)
xmlParam = xmlParam + " available=" + Chr(34) + CStr(reqAvailable) + Chr(34)
xmlParam = xmlParam + " total=" + Chr(34) + CStr(reqTotal) + Chr(34)
xmlParam = xmlParam + " negative=" + Chr(34) + CStr(reqNegative) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlBarterCampaign
xmlTransaction = xmlTransaction +  xmlBarterCredit
xmlTransaction = xmlTransaction +  xmlBarterAd
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\BarterCampaign[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\BarterCampaign[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "17503 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "17503 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "17503 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "17503.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "17503 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "17503 Load file (oData) failed with error code " + CStr(oData.parseError)
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