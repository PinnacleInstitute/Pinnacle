<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionFind = 5
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
Dim oCoption, xmlCoption
Dim oMember, xmlMember
Dim oMembers, xmlMembers
Dim oMemberTitles, xmlMemberTitles
Dim oTitles, xmlTitles
'-----other transaction data variables
Dim xmlLevel0
Dim xmlLevel1
Dim xmlLevel2
Dim xmlLevel3
'-----declare page parameters
Dim reqLine
Dim reqMemberID
Dim reqLevel
Dim reqCount
Dim reqParentID
Dim reqCompanyID
Dim reqLevels
Dim reqOnly
Dim reqTitle
Dim reqQV
Dim reqURL
Dim reqInstall
Dim reqDownline1
Dim reqDownline2
Dim reqDownline3
Dim reqDownline4
Dim reqDownline5
Dim reqSearchText
Dim reqSearchType
Dim reqPos
Dim reqErr
Dim reqTopMemberID
Dim reqMemberBV
Dim reqMemberQV
Dim reqViewInfo
Dim reqMemberDesc
Dim reqLines
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
   SetCache "0470bURL", reqReturnURL
   SetCache "0470bDATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "0470b")
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
reqLine =  Numeric(GetInput("Line", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqLevel =  Numeric(GetInput("Level", reqPageData))
reqCount =  Numeric(GetInput("Count", reqPageData))
reqParentID =  Numeric(GetInput("ParentID", reqPageData))
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqLevels =  Numeric(GetInput("Levels", reqPageData))
reqOnly =  Numeric(GetInput("Only", reqPageData))
reqTitle =  Numeric(GetInput("Title", reqPageData))
reqQV =  Numeric(GetInput("QV", reqPageData))
reqURL =  GetInput("URL", reqPageData)
reqInstall =  Numeric(GetInput("Install", reqPageData))
reqDownline1 =  Numeric(GetInput("Downline1", reqPageData))
reqDownline2 =  Numeric(GetInput("Downline2", reqPageData))
reqDownline3 =  Numeric(GetInput("Downline3", reqPageData))
reqDownline4 =  Numeric(GetInput("Downline4", reqPageData))
reqDownline5 =  Numeric(GetInput("Downline5", reqPageData))
reqSearchText =  GetInput("SearchText", reqPageData)
reqSearchType =  Numeric(GetInput("SearchType", reqPageData))
reqPos =  Numeric(GetInput("Pos", reqPageData))
reqErr =  Numeric(GetInput("Err", reqPageData))
reqTopMemberID =  Numeric(GetInput("TopMemberID", reqPageData))
reqMemberBV =  GetInput("MemberBV", reqPageData)
reqMemberQV =  GetInput("MemberQV", reqPageData)
reqViewInfo =  Numeric(GetInput("ViewInfo", reqPageData))
reqMemberDesc =  GetInput("MemberDesc", reqPageData)
reqLines =  GetInput("Lines", reqPageData)
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

Sub GetDownlines()
   On Error Resume Next

   Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
   If oCoption Is Nothing Then
      DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
   Else
      With oCoption
         .SysCurrentLanguage = reqSysLanguage
         .FetchCompany CLng(reqCompanyID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         .Load .CoptionID, CLng(reqSysUserID)
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         
                  Downlines = .TBPage
                  If Downlines <> "" Then
                  If InStr(Downlines, "1" ) > 0 Then reqDownline1 = 1 Else reqDownline1 = 0
                  If InStr(Downlines, "2" ) > 0 Then reqDownline2 = 1 Else reqDownline2 = 0
                  If InStr(Downlines, "3" ) > 0 Then reqDownline3 = 1 Else reqDownline3 = 0
                  If InStr(Downlines, "4" ) > 0 Then reqDownline4 = 1 Else reqDownline4 = 0
                  If InStr(Downlines, "5" ) > 0 Then reqDownline5 = 1 Else reqDownline5 = 0
                  If reqLine = 0 Then
                  pos = InStr(Downlines, "*" )
                  If pos > 0 Then reqLine = CLng( MID(Downlines, pos+1, 1) )
                  End If
                  If InStr( Downlines, CStr(reqLine) ) = 0 Then
                  reqLine = Left(DownLines, 1 )
                  End If
                  End If
               
         xmlCoption = .XML()
         If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
      End With
   End If
   Set oCoption = Nothing
End Sub

Function BuildTree( oSrc, MemberID, Pos, Level )
   On Error Resume Next
   
               tmpNode = ""
               For Each oItem In oSrc.selectNodes("/PTSMEMBERS/PTSMEMBER[@sponsorid=" + CStr(MemberID) + " and @phone1=" + Cstr(Pos) + "]" )
                  If tmpNode = "" Then
                     With oItem
                        attrMemberID = .getAttribute("memberid")
                        attrMemberName = .getAttribute("membername")
                        attrEnrollDate = .getAttribute("enrolldate")
                        attrVisitDate = .getAttribute("visitdate")
                        attrStatus = .getAttribute("status")
                        attrTitle = .getAttribute("title")
                        attrBV = .getAttribute("bv")
                        attrQV = .getAttribute("qv")
                        attrIdentification = .getAttribute("identification")
                     End With
                     tmpNode = "<NODE"
                     tmpNode = tmpNode & " memberid=""" & attrMemberID & """ status=""" & attrStatus & """ title=""" & attrTitle & """"
                     tmpNode = tmpNode & " desc=""" & attrMemberName & " - " & attrQV & " - " & attrIdentification & " - " & attrEnrollDate & " - " & attrVisitDate & """"
                     tmpNode = tmpNode & "/>"

                     If Level = 0 Then
                        xmlLevel0 = xmlLevel0 + tmpNode
                        tmpLevel0Cnt = tmpLevel0Cnt + 1
                        tmpCnt = tmpLevel0Cnt
                     End If
                     If Level = 1 Then
                        xmlLevel1 = xmlLevel1 + tmpNode
                        tmpLevel1Cnt = tmpLevel1Cnt + 1
                        tmpCnt = tmpLevel1Cnt
                     End If
                     If Level = 2 Then
                        xmlLevel2 = xmlLevel2 + tmpNode
                        tmpLevel2Cnt = tmpLevel2Cnt + 1
                        tmpCnt = tmpLevel2Cnt
                     End If
                     If Level = 3 Then
                        xmlLevel3 = xmlLevel3 + tmpNode
                        tmpLevel3Cnt = tmpLevel3Cnt + 1
                        tmpCnt = tmpLevel3Cnt
                     End If
                     If reqLines <> "" Then reqLines = reqLines + "|"
                     reqLines = reqLines + CStr(Level) + "," + CStr(tmpCnt)
                     If Level < 3 Then
                        BuildTree oSrc, attrMemberID, 0, Level + 1
                        BuildTree oSrc, attrMemberID, 1, Level + 1
                     End If
                  End If
               Next
               If tmpNode = "" Then
                  If Level = 0 Then
                     xmlLevel0 = xmlLevel0 + "<NODE sponsorid=""" & MemberID & """ pos=""" & Pos & """/>"
                     tmpLevel0Cnt = tmpLevel0Cnt + 1
                     xmlLevel1 = xmlLevel1 + "<NODE/><NODE/>"
                     tmpLevel1Cnt = tmpLevel1Cnt + 2
                     xmlLevel2 = xmlLevel2 + "<NODE/><NODE/><NODE/><NODE/>"
                     tmpLevel2Cnt = tmpLevel2Cnt + 4
                     xmlLevel3 = xmlLevel3 + "<NODE/><NODE/><NODE/><NODE/><NODE/><NODE/><NODE/><NODE/>"
                     tmpLevel3Cnt = tmpLevel3Cnt + 8
                     tmpCnt = tmpLevel0Cnt
                  End If
                  If Level = 1 Then
                     xmlLevel1 = xmlLevel1 + "<NODE sponsorid=""" & MemberID & """ pos=""" & Pos & """/>"
                     tmpLevel1Cnt = tmpLevel1Cnt + 1
                     xmlLevel2 = xmlLevel2 + "<NODE/><NODE/>"
                     tmpLevel2Cnt = tmpLevel2Cnt + 2
                     xmlLevel3 = xmlLevel3 + "<NODE/><NODE/><NODE/><NODE/>"
                     tmpLevel3Cnt = tmpLevel3Cnt + 4
                     tmpCnt = tmpLevel1Cnt
                  End If
                  If Level = 2 Then
                     xmlLevel2 = xmlLevel2 + "<NODE sponsorid=""" & MemberID & """ pos=""" & Pos & """/>"
                     tmpLevel2Cnt = tmpLevel2Cnt + 1
                     xmlLevel3 = xmlLevel3 + "<NODE/><NODE/>"
                     tmpLevel3Cnt = tmpLevel3Cnt + 2
                     tmpCnt = tmpLevel2Cnt
                  End If
                  If Level = 3 Then
                     xmlLevel3 = xmlLevel3 + "<NODE sponsorid=""" & MemberID & """ pos=""" & Pos & """/>"
                     tmpLevel3Cnt = tmpLevel3Cnt + 1
                     tmpCnt = tmpLevel3Cnt
                  End If
                  If reqLines <> "" Then reqLines = reqLines + "|"
                  reqLines = reqLines + CStr(Level) + "," + CStr(tmpCnt)
               End If
            
End Function

If (reqSysUserGroup = 41) And (reqMemberID <> reqSysMemberID) Then
End If
If (reqErr = 1) Then
   DoError 10121, "", "Oops, Downline member not found. Be more specific."
End If
If (reqSearchType = 0) Then
   reqSearchType = 1
End If
If (reqTopMemberID = 0) Then
   reqTopMemberID = reqMemberID
End If
If (reqSysUserGroup <= 23) Then
   reqViewInfo = 1
End If
If (reqSysUserGroup = 41) Then
   Options2 = GetCache("OPTIONS2")
   If (InStr(Options2,"V") <> 0) Then
      reqViewInfo = 1
   End If
End If

               reqInstall = GetCache("INSTALL")
               If reqSysUserGroup = 0 OR reqSysUserGroup > 52 Then
               Response.write "Unauthorized Access!"
               Response.end
               End If
            
If (reqSysUserGroup = 41) And (reqMemberID = 0) Then
   reqMemberID = reqSysMemberID
End If

               If reqLine = 0 Then
               reqLine = 2
               reqDownline1 = 1
               reqDownline2 = 1
               reqDownline3 = 1
               reqDownline4 = 1
               reqDownline5 = 1
               If reqInstall = 1 AND reqSysCompanyID = 7 Then reqLine = 1
               End If
            
If (reqLevels = 0) Then
   reqLevels = 1
End If
Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            .Load CLng(reqMemberID), CLng(reqSysUserID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            reqCompanyID = .CompanyID
            
                  reqMemberDesc =  .NameFirst + " " + .NameLast + " - " + .QV4 + " - " + .EnrollDate + " - " + .VisitDate
                  reqURL = "Sections/Company/" & reqCompanyID & "/CompPlan.pdf"
                  If reqLine = 0 Then
                  '   If reqInstall = 1 AND reqCompanyID = 7 AND .Level = 3 Then reqLine = 4 Else reqLine = 2
                  End If
                  reqMemberBV = FormatCurrency(.BV2, 0 )
                  reqMemberQV = FormatCurrency(.QV2, 0 )
               
            GetDownlines
            If (reqLine = 1) Then
               reqParentID = .ReferralID
            End If
            If (reqLine = 2) Then
               reqParentID = .SponsorID
            End If
            If (reqLine = 3) Then
               reqParentID = .MentorID
            End If
            If (reqLine = 4) Then
               reqParentID = .Sponsor2ID
            End If
            If (reqLine = 5) Then
               reqParentID = .Sponsor3ID
            End If
            reqParentID = .Sponsor3ID
            reqLine = 5
            reqLevels = 4
            xmlMember = .XML()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMember = Nothing

      Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
      If oMembers Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
      Else
         With oMembers
            .SysCurrentLanguage = reqSysLanguage
            .Genealogy CLng(reqMemberID), reqLine, reqLevels, CLng(reqTitle), CCur(reqQV)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            If (reqLine = 2) And (reqCompanyID = 5) Then
               
                     For Each oItem in oMembers
                     With oItem
                     aValue = split(.Phone1, ",")
                     .BV4 = aValue(0) 'downline count
                     .BusAccts = aValue(1) 'sponsor team
                     .MaxMembers = aValue(2)   'leg title
                     End With
                     Next
                  
            End If
            reqCount = CLng(.Count(CLng(reqSysUserID)))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlMembers = .XMLGenealogy()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
   Set oSrc = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
   oSrc.loadXML xmlMembers
   xmlLevel0 = "<NODES level=""0"">"
   xmlLevel1 = "<NODES level=""1"">"
   xmlLevel2 = "<NODES level=""2"">"
   xmlLevel3 = "<NODES level=""3"">"
   reqLines = ""
   tmpLevel0Cnt = 0
   tmpLevel1Cnt = 0
   tmpLevel2Cnt = 0
   tmpLevel3Cnt = 0
   BuildTree oSrc, reqMemberID, 0, 0
   BuildTree oSrc, reqMemberID, 1, 0
   xmlLevel0 = xmlLevel0 + "</NODES>"
   xmlLevel1 = xmlLevel1 + "</NODES>"
   xmlLevel2 = xmlLevel2 + "</NODES>"
   xmlLevel3 = xmlLevel3 + "</NODES>"
   Set oSrc = Nothing

         End With
      End If
      Set oMembers = Nothing

      Set oMemberTitles = server.CreateObject("ptsMemberTitleUser.CMemberTitles")
      If oMemberTitles Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberTitleUser.CMemberTitles"
      Else
         With oMemberTitles
            .SysCurrentLanguage = reqSysLanguage
            .ListMember CLng(reqMemberID)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            xmlMemberTitles = .XMLGenealogy()
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oMemberTitles = Nothing

      Set oTitles = server.CreateObject("ptsTitleUser.CTitles")
      If oTitles Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsTitleUser.CTitles"
      Else
         With oTitles
            .SysCurrentLanguage = reqSysLanguage
            xmlTitles = xmlTitles + .EnumCompany(CLng(reqCompanyID), , , CLng(reqSysUserID))
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
         End With
      End If
      Set oTitles = Nothing

   Case CLng(cActionFind):

      Set oMember = server.CreateObject("ptsMemberUser.CMember")
      If oMember Is Nothing Then
         DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
      Else
         With oMember
            .SysCurrentLanguage = reqSysLanguage
            Result = .SearchDownline(CLng(reqCompanyID), reqTopMemberID, reqSearchType, reqSearchText, reqLine)
            If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            
                  SearchError = 0
                  aResult = Split(Result, ":" )
                  If aResult(0) <> "0" Then
                  reqMemberID = CLng(aResult(0))
                  reqPos = CLng(aResult(1))
                  reqLevel = CLng(aResult(2))
                  Else
                  SearchError = 1
                  End If
                  url = "0470.asp?memberid=" + CSTR(reqMemberID) + "&level=" + CSTR(reqLevel) + "&line=" + CSTR(reqLine) + "&levels=" + CSTR(reqLevels) + "&only=" + CSTR(reqOnly) + "&title=" + CSTR(reqTitle) + "&qv=" + CSTR(reqQV) + "&topmemberid=" + CSTR(reqTopMemberID) + "&pos=" + CSTR(reqPos) + "&err=" + CSTR(SearchError) + "&result=" + Result
                  Response.Redirect url
               
         End With
      End If
      Set oMember = Nothing
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
xmlParam = xmlParam + " line=" + Chr(34) + CStr(reqLine) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " level=" + Chr(34) + CStr(reqLevel) + Chr(34)
xmlParam = xmlParam + " count=" + Chr(34) + CStr(reqCount) + Chr(34)
xmlParam = xmlParam + " parentid=" + Chr(34) + CStr(reqParentID) + Chr(34)
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " levels=" + Chr(34) + CStr(reqLevels) + Chr(34)
xmlParam = xmlParam + " only=" + Chr(34) + CStr(reqOnly) + Chr(34)
xmlParam = xmlParam + " title=" + Chr(34) + CStr(reqTitle) + Chr(34)
xmlParam = xmlParam + " qv=" + Chr(34) + CStr(reqQV) + Chr(34)
xmlParam = xmlParam + " url=" + Chr(34) + CleanXML(reqURL) + Chr(34)
xmlParam = xmlParam + " install=" + Chr(34) + CStr(reqInstall) + Chr(34)
xmlParam = xmlParam + " downline1=" + Chr(34) + CStr(reqDownline1) + Chr(34)
xmlParam = xmlParam + " downline2=" + Chr(34) + CStr(reqDownline2) + Chr(34)
xmlParam = xmlParam + " downline3=" + Chr(34) + CStr(reqDownline3) + Chr(34)
xmlParam = xmlParam + " downline4=" + Chr(34) + CStr(reqDownline4) + Chr(34)
xmlParam = xmlParam + " downline5=" + Chr(34) + CStr(reqDownline5) + Chr(34)
xmlParam = xmlParam + " searchtext=" + Chr(34) + CleanXML(reqSearchText) + Chr(34)
xmlParam = xmlParam + " searchtype=" + Chr(34) + CStr(reqSearchType) + Chr(34)
xmlParam = xmlParam + " pos=" + Chr(34) + CStr(reqPos) + Chr(34)
xmlParam = xmlParam + " err=" + Chr(34) + CStr(reqErr) + Chr(34)
xmlParam = xmlParam + " topmemberid=" + Chr(34) + CStr(reqTopMemberID) + Chr(34)
xmlParam = xmlParam + " memberbv=" + Chr(34) + CleanXML(reqMemberBV) + Chr(34)
xmlParam = xmlParam + " memberqv=" + Chr(34) + CleanXML(reqMemberQV) + Chr(34)
xmlParam = xmlParam + " viewinfo=" + Chr(34) + CStr(reqViewInfo) + Chr(34)
xmlParam = xmlParam + " memberdesc=" + Chr(34) + CleanXML(reqMemberDesc) + Chr(34)
xmlParam = xmlParam + " lines=" + Chr(34) + CleanXML(reqLines) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction +  xmlMembers
xmlTransaction = xmlTransaction +  xmlMemberTitles
xmlTransaction = xmlTransaction +  xmlTitles
xmlTransaction = xmlTransaction +  xmlLevel0
xmlTransaction = xmlTransaction +  xmlLevel1
xmlTransaction = xmlTransaction +  xmlLevel2
xmlTransaction = xmlTransaction +  xmlLevel3
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\0470b[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\0470b[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "0470b Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "0470b Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "0470b Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "0470b.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "0470b Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "0470b Load file (oData) failed with error code " + CStr(oData.parseError)
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