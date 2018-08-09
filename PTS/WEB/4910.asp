<!--#include file="Include\System.asp"-->
<% Response.Buffer=true
'-----action code constants
Const cActionNew = 0
Const cActionUpdate = 1
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
Dim oCoption, xmlCoption
Dim oMoption, xmlMoption
Dim oMember, xmlMember
'-----declare page parameters
Dim reqCompanyID
Dim reqMemberID
Dim reqOpt
Dim reqA
Dim reqB
Dim reqC
Dim reqD
Dim reqE
Dim reqF
Dim reqG
Dim reqH
Dim reqI
Dim reqJ
Dim reqK
Dim reqL
Dim reqM
Dim reqN
Dim reqO
Dim reqP
Dim reqQ
Dim reqR
Dim reqS
Dim reqT
Dim reqU
Dim reqV
Dim reqW
Dim reqX
Dim reqY
Dim reqZ
Dim reqaa
Dim reqbb
Dim reqcc
Dim reqdd
Dim reqee
Dim reqff
Dim reqgg
Dim reqhh
Dim reqii
Dim reqjj
Dim reqkk
Dim reqll
Dim reqmm
Dim reqnn
Dim reqoo
Dim reqpp
Dim reqqq
Dim reqrr
Dim reqss
Dim reqtt
Dim requu
Dim reqvv
Dim reqww
Dim reqxx
Dim reqyy
Dim reqzz
Dim reqa0
Dim reqa1
Dim reqa2
Dim reqa3
Dim reqa4
Dim reqa5
Dim reqa6
Dim reqa7
Dim reqa8
Dim reqa9
Dim reqat
Dim reqpound
Dim reqstar
Dim reqpercent
Dim reqlparen
Dim reqrparen
Dim reqbar
Dim reqbslash
Dim requnderscore
Dim reqplus
Dim reqequal
Dim reqperiod
Dim reqfslash
Dim reqcomma
Dim reqlbracket
Dim reqrbracket
Dim reqlcurly
Dim reqrcurly
Dim reqexclaim
Dim reqdollar
Dim reqcolon
Dim reqsemicolon
Dim reqcaret
Dim reqOptions
Dim reqName
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
   SetCache "4910URL", reqReturnURL
   SetCache "4910DATA", reqReturnData
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
pos = InStr(LCASE(reqSysServerPath), "4910")
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
reqCompanyID =  Numeric(GetInput("CompanyID", reqPageData))
reqMemberID =  Numeric(GetInput("MemberID", reqPageData))
reqOpt =  Numeric(GetInput("Opt", reqPageData))
reqA =  Numeric(GetInput("A", reqPageData))
reqB =  Numeric(GetInput("B", reqPageData))
reqC =  Numeric(GetInput("C", reqPageData))
reqD =  Numeric(GetInput("D", reqPageData))
reqE =  Numeric(GetInput("E", reqPageData))
reqF =  Numeric(GetInput("F", reqPageData))
reqG =  Numeric(GetInput("G", reqPageData))
reqH =  Numeric(GetInput("H", reqPageData))
reqI =  Numeric(GetInput("I", reqPageData))
reqJ =  Numeric(GetInput("J", reqPageData))
reqK =  Numeric(GetInput("K", reqPageData))
reqL =  Numeric(GetInput("L", reqPageData))
reqM =  Numeric(GetInput("M", reqPageData))
reqN =  Numeric(GetInput("N", reqPageData))
reqO =  Numeric(GetInput("O", reqPageData))
reqP =  Numeric(GetInput("P", reqPageData))
reqQ =  Numeric(GetInput("Q", reqPageData))
reqR =  Numeric(GetInput("R", reqPageData))
reqS =  Numeric(GetInput("S", reqPageData))
reqT =  Numeric(GetInput("T", reqPageData))
reqU =  Numeric(GetInput("U", reqPageData))
reqV =  Numeric(GetInput("V", reqPageData))
reqW =  Numeric(GetInput("W", reqPageData))
reqX =  Numeric(GetInput("X", reqPageData))
reqY =  Numeric(GetInput("Y", reqPageData))
reqZ =  Numeric(GetInput("Z", reqPageData))
reqaa =  Numeric(GetInput("aa", reqPageData))
reqbb =  Numeric(GetInput("bb", reqPageData))
reqcc =  Numeric(GetInput("cc", reqPageData))
reqdd =  Numeric(GetInput("dd", reqPageData))
reqee =  Numeric(GetInput("ee", reqPageData))
reqff =  Numeric(GetInput("ff", reqPageData))
reqgg =  Numeric(GetInput("gg", reqPageData))
reqhh =  Numeric(GetInput("hh", reqPageData))
reqii =  Numeric(GetInput("ii", reqPageData))
reqjj =  Numeric(GetInput("jj", reqPageData))
reqkk =  Numeric(GetInput("kk", reqPageData))
reqll =  Numeric(GetInput("ll", reqPageData))
reqmm =  Numeric(GetInput("mm", reqPageData))
reqnn =  Numeric(GetInput("nn", reqPageData))
reqoo =  Numeric(GetInput("oo", reqPageData))
reqpp =  Numeric(GetInput("pp", reqPageData))
reqqq =  Numeric(GetInput("qq", reqPageData))
reqrr =  Numeric(GetInput("rr", reqPageData))
reqss =  Numeric(GetInput("ss", reqPageData))
reqtt =  Numeric(GetInput("tt", reqPageData))
requu =  Numeric(GetInput("uu", reqPageData))
reqvv =  Numeric(GetInput("vv", reqPageData))
reqww =  Numeric(GetInput("ww", reqPageData))
reqxx =  Numeric(GetInput("xx", reqPageData))
reqyy =  Numeric(GetInput("yy", reqPageData))
reqzz =  Numeric(GetInput("zz", reqPageData))
reqa0 =  Numeric(GetInput("a0", reqPageData))
reqa1 =  Numeric(GetInput("a1", reqPageData))
reqa2 =  Numeric(GetInput("a2", reqPageData))
reqa3 =  Numeric(GetInput("a3", reqPageData))
reqa4 =  Numeric(GetInput("a4", reqPageData))
reqa5 =  Numeric(GetInput("a5", reqPageData))
reqa6 =  Numeric(GetInput("a6", reqPageData))
reqa7 =  Numeric(GetInput("a7", reqPageData))
reqa8 =  Numeric(GetInput("a8", reqPageData))
reqa9 =  Numeric(GetInput("a9", reqPageData))
reqat =  Numeric(GetInput("at", reqPageData))
reqpound =  Numeric(GetInput("pound", reqPageData))
reqstar =  Numeric(GetInput("star", reqPageData))
reqpercent =  Numeric(GetInput("percent", reqPageData))
reqlparen =  Numeric(GetInput("lparen", reqPageData))
reqrparen =  Numeric(GetInput("rparen", reqPageData))
reqbar =  Numeric(GetInput("bar", reqPageData))
reqbslash =  Numeric(GetInput("bslash", reqPageData))
requnderscore =  Numeric(GetInput("underscore", reqPageData))
reqplus =  Numeric(GetInput("plus", reqPageData))
reqequal =  Numeric(GetInput("equal", reqPageData))
reqperiod =  Numeric(GetInput("period", reqPageData))
reqfslash =  Numeric(GetInput("fslash", reqPageData))
reqcomma =  Numeric(GetInput("comma", reqPageData))
reqlbracket =  Numeric(GetInput("lbracket", reqPageData))
reqrbracket =  Numeric(GetInput("rbracket", reqPageData))
reqlcurly =  Numeric(GetInput("lcurly", reqPageData))
reqrcurly =  Numeric(GetInput("rcurly", reqPageData))
reqexclaim =  Numeric(GetInput("exclaim", reqPageData))
reqdollar =  Numeric(GetInput("dollar", reqPageData))
reqcolon =  Numeric(GetInput("colon", reqPageData))
reqsemicolon =  Numeric(GetInput("semicolon", reqPageData))
reqcaret =  Numeric(GetInput("caret", reqPageData))
reqOptions =  GetInput("Options", reqPageData)
reqName =  GetInput("Name", reqPageData)
'-----set my page's URL and form for any of my links
reqPageURL = Replace(MakeReturnURL(), "&", "%26")
tmpPageData = Replace(MakeFormCache(), "&", "%26")
'-----If the Form cache is empty, do not replace the return data
If tmpPageData <> "" Then
   reqPageData = tmpPageData
End If

'-----get the userID and security group
CheckSecurity reqSysUserID, reqSysUserGroup, 1, 125
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

Select Case CLng(reqActionCode)

   Case CLng(cActionNew):

      If (reqOpt < 4) Then
         Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
         If oCoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
         Else
            With oCoption
               .SysCurrentLanguage = reqSysLanguage
               .FetchCompany CLng(reqCompanyID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Load CLng(.CoptionID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
                  Select Case reqOpt
                  Case -1: reqOptions = .EasyOptions
                  Case 0: reqOptions = .FreeOptions
                  Case 1: reqOptions = .Options
                  Case 2: reqOptions = .Options2
                  Case 3: reqOptions = .Options3
                  Case -2: reqOptions = .Options4
                  Case -3: reqOptions = .Options5
                  Case -4: reqOptions = .Options6
                  Case -5: reqOptions = .Options7
                  Case -6: reqOptions = .Options8
                  End Select
               
            End With
         End If
         Set oCoption = Nothing
      End If

      If (reqOpt >= 10) And (reqOpt <= 13) Then
         Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
         If oMoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
         Else
            With oMoption
               .SysCurrentLanguage = reqSysLanguage
               .FetchMember reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Load .MoptionID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
                  Select Case reqOpt
                  Case 10: reqOptions = .Options0
                  Case 11: reqOptions = .Options1
                  Case 12: reqOptions = .Options2
                  Case 13: reqOptions = .Options3
                  End Select
               
            End With
         End If
         Set oMoption = Nothing
      End If

      If (reqOpt = 4) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               reqOptions = .Options
               reqName = .NameFirst + " " + .NameLast
            End With
         End If
         Set oMember = Nothing
      End If
      
               tmp = reqOptions
               If InStr(tmp, "A") > 0 Then reqA = 1
               If InStr(tmp, "B") > 0 Then reqB = 1
               If InStr(tmp, "C") > 0 Then reqC = 1
               If InStr(tmp, "D") > 0 Then reqD = 1
               If InStr(tmp, "E") > 0 Then reqE = 1
               If InStr(tmp, "F") > 0 Then reqF = 1
               If InStr(tmp, "G") > 0 Then reqG = 1
               If InStr(tmp, "H") > 0 Then reqH = 1
               If InStr(tmp, "I") > 0 Then reqI = 1
               If InStr(tmp, "J") > 0 Then reqJ = 1
               If InStr(tmp, "K") > 0 Then reqK = 1
               If InStr(tmp, "L") > 0 Then reqL = 1
               If InStr(tmp, "M") > 0 Then reqM = 1
               If InStr(tmp, "N") > 0 Then reqN = 1
               If InStr(tmp, "O") > 0 Then reqO = 1
               If InStr(tmp, "P") > 0 Then reqP = 1
               If InStr(tmp, "Q") > 0 Then reqQ = 1
               If InStr(tmp, "R") > 0 Then reqR = 1
               If InStr(tmp, "S") > 0 Then reqS = 1
               If InStr(tmp, "T") > 0 Then reqT = 1
               If InStr(tmp, "U") > 0 Then reqU = 1
               If InStr(tmp, "V") > 0 Then reqV = 1
               If InStr(tmp, "W") > 0 Then reqW = 1
               If InStr(tmp, "X") > 0 Then reqX = 1
               If InStr(tmp, "Y") > 0 Then reqY = 1
               If InStr(tmp, "Z") > 0 Then reqZ = 1
               If InStr(tmp, "a") > 0 Then reqaa = 1
               If InStr(tmp, "b") > 0 Then reqbb = 1
               If InStr(tmp, "c") > 0 Then reqcc = 1
               If InStr(tmp, "d") > 0 Then reqdd = 1
               If InStr(tmp, "e") > 0 Then reqee = 1
               If InStr(tmp, "f") > 0 Then reqff = 1
               If InStr(tmp, "g") > 0 Then reqgg = 1
               If InStr(tmp, "h") > 0 Then reqhh = 1
               If InStr(tmp, "i") > 0 Then reqii = 1
               If InStr(tmp, "j") > 0 Then reqjj = 1
               If InStr(tmp, "k") > 0 Then reqkk = 1
               If InStr(tmp, "l") > 0 Then reqll = 1
               If InStr(tmp, "m") > 0 Then reqmm = 1
               If InStr(tmp, "n") > 0 Then reqnn = 1
               If InStr(tmp, "o") > 0 Then reqoo = 1
               If InStr(tmp, "p") > 0 Then reqpp = 1
               If InStr(tmp, "q") > 0 Then reqqq = 1
               If InStr(tmp, "r") > 0 Then reqrr = 1
               If InStr(tmp, "s") > 0 Then reqss = 1
               If InStr(tmp, "t") > 0 Then reqtt = 1
               If InStr(tmp, "u") > 0 Then requu = 1
               If InStr(tmp, "v") > 0 Then reqvv = 1
               If InStr(tmp, "w") > 0 Then reqww = 1
               If InStr(tmp, "x") > 0 Then reqxx = 1
               If InStr(tmp, "~y") > 0 Then reqyy = 1
               If InStr(tmp, "z") > 0 Then reqzz = 1
               If InStr(tmp, "0") > 0 Then reqa0 = 1
               If InStr(tmp, "1") > 0 Then reqa1 = 1
               If InStr(tmp, "2") > 0 Then reqa2 = 1
               If InStr(tmp, "~3") > 0 Then reqa3 = 1
               If InStr(tmp, "4") > 0 Then reqa4 = 1
               If InStr(tmp, "5") > 0 Then reqa5 = 1
               If InStr(tmp, "6") > 0 Then reqa6 = 1
               If InStr(tmp, "7") > 0 Then reqa7 = 1
               If InStr(tmp, "8") > 0 Then reqa8 = 1
               If InStr(tmp, "~9") > 0 Then reqa9 = 1

               If InStr(tmp, "@") > 0 Then reqat = 1
               If InStr(tmp, "#") > 0 Then reqpound = 1
               If InStr(tmp, "*") > 0 Then reqstar = 1
               If InStr(tmp, "%") > 0 Then reqpercent= 1
               If InStr(tmp, "(") > 0 Then reqlparen = 1
               If InStr(tmp, ")") > 0 Then reqrparen = 1
               If InStr(tmp, "|") > 0 Then reqbar = 1
               If InStr(tmp, "\") > 0 Then reqbslash = 1
               If InStr(tmp, "_") > 0 Then requnderscore = 1
               If InStr(tmp, "+") > 0 Then reqplus = 1
               If InStr(tmp, "=") > 0 Then reqequal = 1
               If InStr(tmp, ".") > 0 Then reqperiod = 1
               If InStr(tmp, "/") > 0 Then reqfslash = 1
               If InStr(tmp, ",") > 0 Then reqcomma = 1
               If InStr(tmp, "[") > 0 Then reqlbracket = 1
               If InStr(tmp, "]") > 0 Then reqrbracket = 1
               If InStr(tmp, "{") > 0 Then reqlcurly = 1
               If InStr(tmp, "}") > 0 Then reqrcurly = 1
               If InStr(tmp, "~!") > 0 Then reqexclaim = 1
               If InStr(tmp, "~$") > 0 Then reqdollar = 1
               If InStr(tmp, "~:") > 0 Then reqcolon = 1
               If InStr(tmp, ";") > 0 Then reqsemicolon = 1
               If InStr(tmp, "~^") > 0 Then reqcaret = 1
            

   Case CLng(cActionUpdate):
      
               tmp = ""
               If reqA = 1 Then tmp = tmp + "A"
               If reqB = 1 Then tmp = tmp + "B"
               If reqC = 1 Then tmp = tmp + "C"
               If reqD = 1 Then tmp = tmp + "D"
               If reqE = 1 Then tmp = tmp + "E"
               If reqF = 1 Then tmp = tmp + "F"
               If reqG = 1 Then tmp = tmp + "G"
               If reqH = 1 Then tmp = tmp + "H"
               If reqI = 1 Then tmp = tmp + "I"
               If reqJ = 1 Then tmp = tmp + "J"
               If reqK = 1 Then tmp = tmp + "K"
               If reqL = 1 Then tmp = tmp + "L"
               If reqM = 1 Then tmp = tmp + "M"
               If reqN = 1 Then tmp = tmp + "N"
               If reqO = 1 Then tmp = tmp + "O"
               If reqP = 1 Then tmp = tmp + "P"
               If reqQ = 1 Then tmp = tmp + "Q"
               If reqR = 1 Then tmp = tmp + "R"
               If reqS = 1 Then tmp = tmp + "S"
               If reqT = 1 Then tmp = tmp + "T"
               If reqU = 1 Then tmp = tmp + "U"
               If reqV = 1 Then tmp = tmp + "V"
               If reqW = 1 Then tmp = tmp + "W"
               If reqX = 1 Then tmp = tmp + "X"
               If reqY = 1 Then tmp = tmp + "Y"
               If reqZ = 1 Then tmp = tmp + "Z"
               If reqaa = 1 Then tmp = tmp + "a"
               If reqbb = 1 Then tmp = tmp + "b"
               If reqcc = 1 Then tmp = tmp + "c"
               If reqdd = 1 Then tmp = tmp + "d"
               If reqee = 1 Then tmp = tmp + "e"
               If reqff = 1 Then tmp = tmp + "f"
               If reqgg = 1 Then tmp = tmp + "g"
               If reqhh = 1 Then tmp = tmp + "h"
               If reqii = 1 Then tmp = tmp + "i"
               If reqjj = 1 Then tmp = tmp + "j"
               If reqkk = 1 Then tmp = tmp + "k"
               If reqll = 1 Then tmp = tmp + "l"
               If reqmm = 1 Then tmp = tmp + "m"
               If reqnn = 1 Then tmp = tmp + "n"
               If reqoo = 1 Then tmp = tmp + "o"
               If reqpp = 1 Then tmp = tmp + "p"
               If reqqq = 1 Then tmp = tmp + "q"
               If reqrr = 1 Then tmp = tmp + "r"
               If reqss = 1 Then tmp = tmp + "s"
               If reqtt = 1 Then tmp = tmp + "t"
               If requu = 1 Then tmp = tmp + "u"
               If reqvv = 1 Then tmp = tmp + "v"
               If reqww = 1 Then tmp = tmp + "w"
               If reqxx = 1 Then tmp = tmp + "x"
               If reqyy = 1 Then tmp = tmp + "~y"
               If reqzz = 1 Then tmp = tmp + "z"
               If reqa0 = 1 Then tmp = tmp + "0"
               If reqa1 = 1 Then tmp = tmp + "1"
               If reqa2 = 1 Then tmp = tmp + "2"
               If reqa3 = 1 Then tmp = tmp + "~3"
               If reqa4 = 1 Then tmp = tmp + "4"
               If reqa5 = 1 Then tmp = tmp + "5"
               If reqa6 = 1 Then tmp = tmp + "6"
               If reqa7 = 1 Then tmp = tmp + "7"
               If reqa8 = 1 Then tmp = tmp + "8"
               If reqa9 = 1 Then tmp = tmp + "~9"

               If reqat = 1 Then tmp = tmp + "@"
               If reqpound = 1 Then tmp = tmp + "#"
               If reqstar = 1 Then tmp = tmp + "*"
               If reqpercent = 1 Then tmp = tmp + "%"
               If reqlparen = 1 Then tmp = tmp + "("
               If reqrparen = 1 Then tmp = tmp + ")"
               If reqbar = 1 Then tmp = tmp + "|"
               If reqbslash = 1 Then tmp = tmp + "\"
               If requnderscore = 1 Then tmp = tmp + "_"
               If reqplus = 1 Then tmp = tmp + "+"
               If reqequal = 1 Then tmp = tmp + "="
               If reqperiod = 1 Then tmp = tmp + "."
               If reqfslash = 1 Then tmp = tmp + "/"
               If reqcomma = 1 Then tmp = tmp + ","
               If reqlbracket = 1 Then tmp = tmp + "["
               If reqrbracket = 1 Then tmp = tmp + "]"
               If reqlcurly = 1 Then tmp = tmp + "{"
               If reqrcurly = 1 Then tmp = tmp + "}"
               If reqexclaim = 1 Then tmp = tmp + "~!"
               If reqdollar = 1 Then tmp = tmp + "~$"
               If reqcolon = 1 Then tmp = tmp + "~:"
               If reqsemicolon = 1 Then tmp = tmp + ";"
               If reqcaret = 1 Then tmp = tmp + "~^"
            

      If (reqOpt < 4) Then
         Set oCoption = server.CreateObject("ptsCoptionUser.CCoption")
         If oCoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsCoptionUser.CCoption"
         Else
            With oCoption
               .SysCurrentLanguage = reqSysLanguage
               .FetchCompany CLng(reqCompanyID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Load CLng(.CoptionID), CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
                  Select Case reqOpt
                  Case -1: .EasyOptions = tmp
                  Case 0: .FreeOptions = tmp
                  Case 1: .Options = tmp
                  Case 2: .Options2 = tmp
                  Case 3: .Options3 = tmp
                  Case -2: .Options4 = tmp
                  Case -3: .Options5 = tmp
                  Case -4: .Options6 = tmp
                  Case -5: .Options7 = tmp
                  Case -6: .Options8 = tmp
                  End Select
               
               If (xmlError = "") Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oCoption = Nothing
      End If

      If (reqOpt >= 10) And (reqOpt <= 13) Then
         Set oMoption = server.CreateObject("ptsMoptionUser.CMoption")
         If oMoption Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMoptionUser.CMoption"
         Else
            With oMoption
               .SysCurrentLanguage = reqSysLanguage
               .FetchMember reqMemberID
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Load .MoptionID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               
                  Select Case reqOpt
                  Case 10: .Options0 = tmp
                  Case 11: .Options1 = tmp
                  Case 12: .Options2 = tmp
                  Case 13: .Options3 = tmp
                  End Select
               
               If (xmlError = "") Then
                  .Save CLng(reqSysUserID)
                  If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               End If
            End With
         End If
         Set oMoption = Nothing
      End If

      If (reqOpt = 4) Then
         Set oMember = server.CreateObject("ptsMemberUser.CMember")
         If oMember Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMember"
         Else
            With oMember
               .SysCurrentLanguage = reqSysLanguage
               .Load reqMemberID, CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
               .Options = tmp
               .Save CLng(reqSysUserID)
               If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If
            End With
         End If
         Set oMember = Nothing
      End If

      If (xmlError = "") Then
         reqReturnURL = GetCache("4910URL")
         reqReturnData = GetCache("4910DATA")
         SetCache "4910URL", ""
         SetCache "4910DATA", ""
         If (Len(reqReturnURL) > 0) Then
            SetCache "RETURNURL", reqReturnURL
            SetCache "RETURNDATA", reqReturnData
            Response.Redirect Replace(reqReturnURL, "%26", "&")
         End If
      End If

   Case CLng(cActionCancel):

      reqReturnURL = GetCache("4910URL")
      reqReturnData = GetCache("4910DATA")
      SetCache "4910URL", ""
      SetCache "4910DATA", ""
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
xmlParam = xmlParam + " companyid=" + Chr(34) + CStr(reqCompanyID) + Chr(34)
xmlParam = xmlParam + " memberid=" + Chr(34) + CStr(reqMemberID) + Chr(34)
xmlParam = xmlParam + " opt=" + Chr(34) + CStr(reqOpt) + Chr(34)
xmlParam = xmlParam + " a=" + Chr(34) + CStr(reqA) + Chr(34)
xmlParam = xmlParam + " b=" + Chr(34) + CStr(reqB) + Chr(34)
xmlParam = xmlParam + " c=" + Chr(34) + CStr(reqC) + Chr(34)
xmlParam = xmlParam + " d=" + Chr(34) + CStr(reqD) + Chr(34)
xmlParam = xmlParam + " e=" + Chr(34) + CStr(reqE) + Chr(34)
xmlParam = xmlParam + " f=" + Chr(34) + CStr(reqF) + Chr(34)
xmlParam = xmlParam + " g=" + Chr(34) + CStr(reqG) + Chr(34)
xmlParam = xmlParam + " h=" + Chr(34) + CStr(reqH) + Chr(34)
xmlParam = xmlParam + " i=" + Chr(34) + CStr(reqI) + Chr(34)
xmlParam = xmlParam + " j=" + Chr(34) + CStr(reqJ) + Chr(34)
xmlParam = xmlParam + " k=" + Chr(34) + CStr(reqK) + Chr(34)
xmlParam = xmlParam + " l=" + Chr(34) + CStr(reqL) + Chr(34)
xmlParam = xmlParam + " m=" + Chr(34) + CStr(reqM) + Chr(34)
xmlParam = xmlParam + " n=" + Chr(34) + CStr(reqN) + Chr(34)
xmlParam = xmlParam + " o=" + Chr(34) + CStr(reqO) + Chr(34)
xmlParam = xmlParam + " p=" + Chr(34) + CStr(reqP) + Chr(34)
xmlParam = xmlParam + " q=" + Chr(34) + CStr(reqQ) + Chr(34)
xmlParam = xmlParam + " r=" + Chr(34) + CStr(reqR) + Chr(34)
xmlParam = xmlParam + " s=" + Chr(34) + CStr(reqS) + Chr(34)
xmlParam = xmlParam + " t=" + Chr(34) + CStr(reqT) + Chr(34)
xmlParam = xmlParam + " u=" + Chr(34) + CStr(reqU) + Chr(34)
xmlParam = xmlParam + " v=" + Chr(34) + CStr(reqV) + Chr(34)
xmlParam = xmlParam + " w=" + Chr(34) + CStr(reqW) + Chr(34)
xmlParam = xmlParam + " x=" + Chr(34) + CStr(reqX) + Chr(34)
xmlParam = xmlParam + " y=" + Chr(34) + CStr(reqY) + Chr(34)
xmlParam = xmlParam + " z=" + Chr(34) + CStr(reqZ) + Chr(34)
xmlParam = xmlParam + " aa=" + Chr(34) + CStr(reqaa) + Chr(34)
xmlParam = xmlParam + " bb=" + Chr(34) + CStr(reqbb) + Chr(34)
xmlParam = xmlParam + " cc=" + Chr(34) + CStr(reqcc) + Chr(34)
xmlParam = xmlParam + " dd=" + Chr(34) + CStr(reqdd) + Chr(34)
xmlParam = xmlParam + " ee=" + Chr(34) + CStr(reqee) + Chr(34)
xmlParam = xmlParam + " ff=" + Chr(34) + CStr(reqff) + Chr(34)
xmlParam = xmlParam + " gg=" + Chr(34) + CStr(reqgg) + Chr(34)
xmlParam = xmlParam + " hh=" + Chr(34) + CStr(reqhh) + Chr(34)
xmlParam = xmlParam + " ii=" + Chr(34) + CStr(reqii) + Chr(34)
xmlParam = xmlParam + " jj=" + Chr(34) + CStr(reqjj) + Chr(34)
xmlParam = xmlParam + " kk=" + Chr(34) + CStr(reqkk) + Chr(34)
xmlParam = xmlParam + " ll=" + Chr(34) + CStr(reqll) + Chr(34)
xmlParam = xmlParam + " mm=" + Chr(34) + CStr(reqmm) + Chr(34)
xmlParam = xmlParam + " nn=" + Chr(34) + CStr(reqnn) + Chr(34)
xmlParam = xmlParam + " oo=" + Chr(34) + CStr(reqoo) + Chr(34)
xmlParam = xmlParam + " pp=" + Chr(34) + CStr(reqpp) + Chr(34)
xmlParam = xmlParam + " qq=" + Chr(34) + CStr(reqqq) + Chr(34)
xmlParam = xmlParam + " rr=" + Chr(34) + CStr(reqrr) + Chr(34)
xmlParam = xmlParam + " ss=" + Chr(34) + CStr(reqss) + Chr(34)
xmlParam = xmlParam + " tt=" + Chr(34) + CStr(reqtt) + Chr(34)
xmlParam = xmlParam + " uu=" + Chr(34) + CStr(requu) + Chr(34)
xmlParam = xmlParam + " vv=" + Chr(34) + CStr(reqvv) + Chr(34)
xmlParam = xmlParam + " ww=" + Chr(34) + CStr(reqww) + Chr(34)
xmlParam = xmlParam + " xx=" + Chr(34) + CStr(reqxx) + Chr(34)
xmlParam = xmlParam + " yy=" + Chr(34) + CStr(reqyy) + Chr(34)
xmlParam = xmlParam + " zz=" + Chr(34) + CStr(reqzz) + Chr(34)
xmlParam = xmlParam + " a0=" + Chr(34) + CStr(reqa0) + Chr(34)
xmlParam = xmlParam + " a1=" + Chr(34) + CStr(reqa1) + Chr(34)
xmlParam = xmlParam + " a2=" + Chr(34) + CStr(reqa2) + Chr(34)
xmlParam = xmlParam + " a3=" + Chr(34) + CStr(reqa3) + Chr(34)
xmlParam = xmlParam + " a4=" + Chr(34) + CStr(reqa4) + Chr(34)
xmlParam = xmlParam + " a5=" + Chr(34) + CStr(reqa5) + Chr(34)
xmlParam = xmlParam + " a6=" + Chr(34) + CStr(reqa6) + Chr(34)
xmlParam = xmlParam + " a7=" + Chr(34) + CStr(reqa7) + Chr(34)
xmlParam = xmlParam + " a8=" + Chr(34) + CStr(reqa8) + Chr(34)
xmlParam = xmlParam + " a9=" + Chr(34) + CStr(reqa9) + Chr(34)
xmlParam = xmlParam + " at=" + Chr(34) + CStr(reqat) + Chr(34)
xmlParam = xmlParam + " pound=" + Chr(34) + CStr(reqpound) + Chr(34)
xmlParam = xmlParam + " star=" + Chr(34) + CStr(reqstar) + Chr(34)
xmlParam = xmlParam + " percent=" + Chr(34) + CStr(reqpercent) + Chr(34)
xmlParam = xmlParam + " lparen=" + Chr(34) + CStr(reqlparen) + Chr(34)
xmlParam = xmlParam + " rparen=" + Chr(34) + CStr(reqrparen) + Chr(34)
xmlParam = xmlParam + " bar=" + Chr(34) + CStr(reqbar) + Chr(34)
xmlParam = xmlParam + " bslash=" + Chr(34) + CStr(reqbslash) + Chr(34)
xmlParam = xmlParam + " underscore=" + Chr(34) + CStr(requnderscore) + Chr(34)
xmlParam = xmlParam + " plus=" + Chr(34) + CStr(reqplus) + Chr(34)
xmlParam = xmlParam + " equal=" + Chr(34) + CStr(reqequal) + Chr(34)
xmlParam = xmlParam + " period=" + Chr(34) + CStr(reqperiod) + Chr(34)
xmlParam = xmlParam + " fslash=" + Chr(34) + CStr(reqfslash) + Chr(34)
xmlParam = xmlParam + " comma=" + Chr(34) + CStr(reqcomma) + Chr(34)
xmlParam = xmlParam + " lbracket=" + Chr(34) + CStr(reqlbracket) + Chr(34)
xmlParam = xmlParam + " rbracket=" + Chr(34) + CStr(reqrbracket) + Chr(34)
xmlParam = xmlParam + " lcurly=" + Chr(34) + CStr(reqlcurly) + Chr(34)
xmlParam = xmlParam + " rcurly=" + Chr(34) + CStr(reqrcurly) + Chr(34)
xmlParam = xmlParam + " exclaim=" + Chr(34) + CStr(reqexclaim) + Chr(34)
xmlParam = xmlParam + " dollar=" + Chr(34) + CStr(reqdollar) + Chr(34)
xmlParam = xmlParam + " colon=" + Chr(34) + CStr(reqcolon) + Chr(34)
xmlParam = xmlParam + " semicolon=" + Chr(34) + CStr(reqsemicolon) + Chr(34)
xmlParam = xmlParam + " caret=" + Chr(34) + CStr(reqcaret) + Chr(34)
xmlParam = xmlParam + " options=" + Chr(34) + CleanXML(reqOptions) + Chr(34)
xmlParam = xmlParam + " name=" + Chr(34) + CleanXML(reqName) + Chr(34)
xmlParam = xmlParam + " />"

'-----get the transaction XML
xmlTransaction = "<TXN>"
xmlTransaction = xmlTransaction +  xmlCoption
xmlTransaction = xmlTransaction +  xmlMoption
xmlTransaction = xmlTransaction +  xmlMember
xmlTransaction = xmlTransaction + "</TXN>"

'-----display the confirmation message if appropriate
If (Len(xmlError) = 0) Then
   If (Len(reqConfirm) > 0) Then
      DoError 0, "", reqConfirm
   End If
End If
'-----get the language XML
fileLanguage = "Language" + "\4910[" + reqSysLanguage + "].xml"
If reqSysLanguage <> "en" Then
   If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = "Language\4910[en].xml"
End If
Set oLanguage = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oLanguage.load server.MapPath(fileLanguage)
If oLanguage.parseError <> 0 Then
   Response.Write "4910 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
   Response.Write "4910 Load file (oCommon) failed with error code " + CStr(oCommon.parseError)
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
   Response.Write "4910 Load file (oLanguage) failed with error code " + CStr(oLanguage.parseError)
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
xslPage = "4910.xsl"
Set oStyle = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oStyle.load server.MapPath(xslPage)
If oStyle.parseError <> 0 Then
   Response.Write "4910 Load file (oStyle) failed with error code " + CStr(oStyle.parseError)
   Response.End
End If

'-----create a DOM object for the XML
Set oData = server.CreateObject("MSXML2.FreeThreadedDOMDocument")
oData.loadXML xmlData
If oData.parseError <> 0 Then
   Response.Write "4910 Load file (oData) failed with error code " + CStr(oData.parseError)
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