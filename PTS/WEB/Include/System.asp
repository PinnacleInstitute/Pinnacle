<%
PUBLIC CONST IsLogging = 0
PUBLIC CONST SysClient = "Pinnacle"
PUBLIC CONST SysProject = "PTS"
PUBLIC CONST SysCookie = "TEMPPTS"
PUBLIC CONST SysCookiePersist = "PTS"

'**************************************************************************************
Function GetCache(ByVal bvName)
	GetCache = Request.Cookies(SysCookie)(bvName)
End Function

'**************************************************************************************
Sub SetCache(ByVal bvName, ByVal bvValue)
	Response.Cookies(SysCookie)(bvName) = bvValue
End Sub

'**************************************************************************************
Function GetCookie(ByVal bvName)
	GetCookie = Request.Cookies(SysCookiePersist)(bvName)
End Function

'**************************************************************************************
Sub SetCookie(ByVal bvName, ByVal bvValue)
	Response.Cookies(SysCookiePersist)(bvName) = bvValue
	Response.Cookies(SysCookiePersist).Expires = Now() + 90
End Sub

'**************************************************************************************
Function Numeric(ByVal bvValue)
   If IsNumeric(bvValue) Then Numeric = CLng(bvValue) Else Numeric = CLng(0) 
End Function

'**************************************************************************************
Function toSatoshi(ByVal bvNum)
    If IsNumeric(bvNum) Then
	    toSatoshi = bvNum * 100000000
    Else
	    toSatoshi = 0
    End If
End Function

'**************************************************************************************
Function fromSatoshi(ByVal bvNum)
    If IsNumeric(bvNum) Then
    	fromSatoshi = bvNum / 100000000
    Else
	    fromSatoshi = 0
    End If
End Function

'**************************************************************************************
Function GetReturnURL()
	Dim sURL
	sURL = Request.ServerVariables("HTTP_REFERER")
	GetReturnURL = sURL
End Function

'**************************************************************************************
Function CheckSecurity(ByRef brUserID, ByRef brUserGroup, ByVal bvSecured, ByVal bvSecuredGroup )
    brUserID = CLng(GetCache("USERID"))
    brUserGroup = CLng(GetCache("USERGROUP"))
    If bvSecured=1 Or bvSecured=2 Then
        If CLng(brUserID) = 0 Then
            SetCache "SignInURL", MakeReturnURL
            Response.Redirect "0101.asp"
        Else
            If bvSecured=1 Then
                If bvSecuredGroup = 125 OR bvSecuredGroup = 1251 Then
                    If bvSecuredGroup = 125 Then tmpGroup = "1,21,22,23,51,52,"
                    If bvSecuredGroup = 1251 Then tmpGroup = "1,21,22,23,51,"
                    If InStr( tmpGroup, CSTR(brUserGroup) + "," ) = 0 Then  AbortUser()
                Else
                    If (brUserGroup > bvSecuredGroup) Then AbortUser()
                End If
            End If
            If bvSecured=2 Then
                If (brUserGroup <> bvSecuredGroup) Then AbortUser()
            End If
        End If
    Else
        If (brUserID = 0) Then 
            brUserID = CLng(99)
            brUserGroup = CLng(99)
            SetCache "USERID", CLng(brUserID)
            SetCache "USERGROUP", CLng(brUserGroup)
            SetCache "USERSTATUS", CLng(1)
        End If
    End If
End Function

'**************************************************************************************
Function m_CheckSecurity(ByRef brUserID, ByRef brUserGroup, ByVal bvSecured, ByVal bvSecuredGroup, ByVal bvPage )
    brUserID = CLng(GetCache("USERID"))
    brUserGroup = CLng(GetCache("USERGROUP"))
    If bvSecured=1 Or bvSecured=2 Then
        If CLng(brUserID) = 0 Then
            SetCache "SignInURL", MakeReturnURL
            Response.Redirect "m_0101.asp?page=" + bvPage
        Else
            If bvSecured=1 Then
                If bvSecuredGroup = 125 OR bvSecuredGroup = 1251 Then
                    If bvSecuredGroup = 125 Then tmpGroup = "1,21,22,23,51,52,"
                    If bvSecuredGroup = 1251 Then tmpGroup = "1,21,22,23,51,"
                    If InStr( tmpGroup, CSTR(brUserGroup) + "," ) = 0 Then AbortUser()
                Else
                    If (brUserGroup > bvSecuredGroup) Then AbortUser()
                End If
            End If
            If bvSecured=2 Then
                If (brUserGroup <> bvSecuredGroup) Then AbortUser()
            End If
        End If
    Else
        If (brUserID = 0) Then 
            brUserID = CLng(99)
            brUserGroup = CLng(99)
            SetCache "USERID", CLng(brUserID)
            SetCache "USERGROUP", CLng(brUserGroup)
            SetCache "USERSTATUS", CLng(1)
        End If
    End If
End Function

'**************************************************************************************
Function MakeReturnURL()
	Dim sURL
	Dim Count
	If Request.ServerVariables("HTTPS") = "on" Then
		sURL = "https://"
	Else	
		sURL = "http://"
	End If	
	sURL = sURL + Request.ServerVariables("SERVER_NAME") + Request.ServerVariables("URL")
	iCount = 0
	For Each Item in Request.QueryString
		If (Item <> "ReturnURL") And (Item <> "ReturnData") Then
			If iCount = 0 Then sURL = sURL + "?" Else sURL = sURL + "&" End If
			sURL = sURL + Item + "=" + CSTR(Request.QueryString(Item))
			iCount = iCount + 1
		End If
	Next
	MakeReturnURL = sURL
End Function

'**************************************************************************************
Function MakeFormCache()
	Dim sValues
	iCount = 0
	For Each Item in Request.Form
		If iCount > 0 Then sValues = sValues + "&" End If
		sValues = sValues + Item + "=" + CStr(Request.Form(Item))
		iCount = iCount + 1
	Next
	MakeFormCache = sValues
End Function

'**************************************************************************************
Function GetInput(ByVal bvField, ByVal bvCache)
	Dim sValue
	Dim posBeg, posEnd
	'-----check first if there is a value in the cache, if so, use that
	If (Len(bvCache) > 0) Then
		posBeg = InStr(1, bvCache, bvField & "=",1) 
		If posBeg > 0 Then
			posBeg = posBeg + Len(bvField) + 1
			posEnd = Instr(posBeg, bvCache, "%26", 1)
			If (posEnd > 0) Then
				sValue = Mid(bvCache, posBeg, posEnd-posBeg)				
			Else
				sValue = Mid(bvCache, posBeg)				
			End If
		End If
	End If
	'-----if no cache value then use request value
	If (Len(sValue) > 0) Then
		GetInput = sValue
	Else
		GetInput = Request.Item(bvField)
	End If
End Function

'**************************************************************************************
Function ValidXML(ByVal bvStr)
	Set oRegEx = CreateObject("VBScript.RegExp")
	With oRegEx
		.Global = True   
		.IgnoreCase = True
		.Pattern = "[^\u0009\u000A\u000D\u0020-\uD7FF\uE000-\uFFFD\u10000-\u10FFFF]"
		ValidXML = .Replace(bvStr, "")
	End With
End Function

'**************************************************************************************
Function CleanXML(ByVal bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanXML = Replace(bvValue, Chr(62), "&gt;")
End Function

'**************************************************************************************
Function CleanXMLComment(ByVal bvValue)
   CleanXMLComment = Replace(bvValue, "--", "- ")
End Function

'**************************************************************************************
Function GetKeyToken( byval Key, byval bvStr)
	On Error Resume Next
    'Check if we have a specific key i.e. 14[...]
    startkey = CSTR(Key) + "["
    pos = InStr( bvStr, startkey )
    If pos = 0 Then
        GetKeyToken = bvStr
    Else
        pos2 = InStr( pos, bvStr, "]")
        If pos2 > 0 Then
            GetKeyToken = Mid( bvStr, pos + Len(startkey), pos2 - (pos + Len(startkey)) )
        End If
    End If
End Function

'**************************************************************************************
Function GetUniqueID()
  Randomize 
  for iCtr = 1 to 10
	sChar = Chr(Int((90 - 65 + 1) * Rnd) + 65)
  	sID = sID & sChar
  Next
  sID = sID & Month(Now) & Day(Now) & Year(Now) & Hour(Now) & Minute(Now) & Second(Now)
  GetUniqueID = sID
End Function

'**************************************************************************************
Function GetLanguage( _
	ByRef brDialect, _
	ByRef brCountry, _
	ByRef brDefault)

	Dim AppCodes, DefaultCode
	Dim reqUserCodes, pos
	Dim vAppCodes, idxAppCodes, sAppCode
	Dim vUserCodes, idxUserCodes, sUserCode 

	'*** CUSTOMIZE - Set the supported languages (comma delimited) ***
'	AppCodes = "en,es"
	AppCodes = "en"
	DefaultCode = "en"
	
	'-----convert application supported language codes (AppCodes) into an array
	'-----make sure vAppCodes is an array
	If Len(AppCodes) > 0 Then
		vAppCodes= Split(AppCodes, ",", -1)
	Else
		vAppCodes = Array("")
	End If

	'-----convert the user's browser settings for language preference into an array
	'-----delete any extraneous information besides the code and convert them into an array (vUserCodes)
	'-----SAMPLE: "en-us,es-us;q=0.7,es-pr;q=0.3"
	Set reqUserCodes = Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")

	vUserCodes= Split(reqUserCodes, ",", -1)
	If Not IsArray(vUserCodes) Then vUserCodes = Array(brDefault)	
	'-----strip out any extraneous information in the language code
	For idxUserCodes = LBound(vUserCodes) To UBound(vUserCodes)
		sUserCode = vUserCodes(idxUserCodes)
		pos = InStr(1, sUserCode, ";")
		If (pos > 0) Then vUserCodes(idxUserCodes) = Left(sUserCode, pos-1)
	Next

	'-----set the dialect-specific language setting if we find an exact match between the
	'-----one of the user's preferences and one of the application supported languages
	'-----IF WE DON'T FIND A SUITABLE MATCH LEAVE THIS PROPERTY EMPTY (we'll use either the country or default language)
	'-----NOTE: this match could be dialect-specific (like "en-us") or just the country (like "es")
	'-----depending on the actual user preferences and application supported languages
	'-----NOTE: user preferences are in order of priority so we pick the first match we find and disregard the rest
	brDialect = ""
	'-----loop through each user language setting in order of priority
	For idxUserCodes = LBound(vUserCodes) To UBound(vUserCodes)		
		sUserCode = vUserCodes(idxUserCodes)
		'-----if we have that dialect set use it
		For idxAppCodes = LBound(vAppCodes) To UBound(vAppCodes)		
			sAppCode = vAppCodes(idxAppCodes)
			If (StrComp(sUserCode, sAppCode, 1) = 0) Then
				brDialect = sUserCode
				Exit For
			End If
		Next
		'-----get out of loop if something is already set
		If (Len(brDialect) > 0) Then Exit For
	Next

	'-----If we didn't get a match on the dialect-specific language then look for a match on country.
	'-----To do this, we see if there is an application supported language that is not dialect-specific (like "es")
	'-----that matches the country of one of the user's language preferences (like "es-pr").
	'-----IF WE DON'T FIND A SUITABLE MATCH LEAVE THIS PROPERTY EMPTY (we'll use the default language)
	'-----NOTE: user preferences are in order of priority so we pick the first suitable match we find and disregard the rest
	brCountry = ""
	If (Len(brDialect) = 0) Then
		'-----loop through each user language setting in order of priority
		For idxUserCodes = LBound(vUserCodes) To UBound(vUserCodes)		
			sUserCode = vUserCodes(idxUserCodes)
			pos=Instr(1,sUserCode,"-")
			If (pos > 0) Then sUserCode = Left(sUserCode, pos-1)			
			'-----if we have that dialect set use it
			For idxAppCodes = LBound(vAppCodes) To UBound(vAppCodes)		
				sAppCode = vAppCodes(idxAppCodes)
				If (StrComp(sUserCode, sAppCode, 1) = 0) Then
					brCountry = sUserCode
					Exit For
				End If
			Next	'idxAppCodes
			'-----get out of loop if something is already set
			If (Len(brCountry) > 0) Then Exit For
		Next	' idxUserCodes
	End If

	'-----set language default
	brDefault = DefaultCode
End Function

'**************************************************************************************
Function GetHeader(company, group, filename, lang)
    On Error Resume Next
    Header = ""
    If group > 0 Then filename = filename + CSTR(group)
    If lang <> "" Then filename = filename + "[" + lang + "]"
    FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Images\Company\" + CStr(company) + "\" + filename

    Set oFileSys = CreateObject("Scripting.FileSystemObject")
    Exists = oFileSys.FileExists(FilePath + ".png")
    If Exists Then
	    Header = filename + ".png"
    Else
	    Exists = oFileSys.FileExists(FilePath + ".gif")
	    If Exists Then
    	    Header = filename + ".gif"
	    Else
		    Exists = oFileSys.FileExists(FilePath + ".jpg")
		    If Exists Then
        	    Header = filename + ".jpg"
		    End If
	    End If
    End If
    GetHeader = Header
   Set oFileSys = Nothing
End Function

'**************************************************************************************
Function FileExists(filename)
   On Error Resume Next
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   FileExists = oFileSys.FileExists(filename)
   Set oFileSys = Nothing
End Function

'**************************************************************************************
Function LogFile(ByVal bvFilename, ByVal bvLine)
   On Error Resume Next
	UserIP = Request.ServerVariables("REMOTE_ADDR")
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	'Open the text file for appending
	FilePath = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Log\"
	Set objTextStream = objFSO.OpenTextFile(FilePath + bvFilename + ".txt", 8, 1)
	'write the line tothe file 
	objTextStream.WriteLine CSTR(Date()) + " " + CSTR(Time()) + " " + UserIP + " " + bvLine
	'Close the file and clean up
	objTextStream.Close
	Set objTextStream = Nothing
	Set objFSO = Nothing
End Function

'**************************************************************************************
Function CommonSystem()
	On Error Resume Next
'   Get Google Analytics Account 
'	SetCache "GAA", "UA-926288-1"

'	Check for Installation Number	
	tmpInstall = GetCache("INSTALL")
	If tmpInstall = "" Then
		Set oBusiness = server.CreateObject("ptsBusinessUser.CBusiness")
		oBusiness.Load 1, 1
		SetCache "INSTALL", oBusiness.Install
		Set oBusiness = Nothing
	End If

    UserID = Numeric(GetCache("USERID"))
    UserIP = Request.ServerVariables("REMOTE_ADDR")
    UserGRP = Numeric(GetCache("USERGROUP"))
    UserCode = GetCache("UC")
    AE = Numeric(GetCache("AE"))

    'Check for valid UserCode if logged in
'    If UserGrp > 0 And UserGrp < 99 Then 
    If UserGrp > 0 And UserGrp < 99 And UserGrp <> 31 Then 
        Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
        If oAuthUser Is Nothing Then
            DoError Err.Number, Err.Source, "Unable to Create Object - ptsAuthUser.CAuthUser"
        Else
            With oAuthUser
                tmpUserCode = .GetUserCode( UserID )
                If tmpUserCode <> UserCode Then
                    tmpUserCode = .GetUserCode( UserID * -1 )
                    AbortUser()
                End If
            End With
        End If
        Set oAuthUser = Nothing
   End If

    ' Check for invalid Estonia IPs for GCR	
    Target = ",90.130.40,90.130.41,90.130.42,90.130.43,90.130.44,90.130.45,90.130.46,90.130.47,62.65.193,82.131.27,62.65.239,85.253.65,185.25.84,64.31.33.,"
    Target2 = ",83.187.128,83.187.129,83.187.130,83.187.131,83.187.132,83.187.143,174.140.16,66.187.73.,173.224.11,76.164.227,204.15.110,216.31.10.,172.245.20,192.3.78.1,198.203.31,"
    If UserID = 10242 OR UserID = 10976 OR UserID = 10977 OR InStr( Target, "," + Left(UserIP,9) + "," ) > 0 OR InStr( Target2, "," + Left(UserIP,10) + "," ) > 0 Then
       AbortUser()
    End If
	
End Function

'**************************************************************************************
Function AbortUser()
	On Error Resume Next
	UserID = Numeric(GetCache("USERID"))
	MemberID = Numeric(GetCache("MEMBERID"))
	CompanyID = Numeric(GetCache("COMPANYID"))
	UserName = GetCache("USERNAME")
    User = CStr(UserID) + "/" + CStr(MemberID) + " - " + UserName + " - " + CStr(CompanyID)
	LogFile "AccessError", User + " - " + Request.ServerVariables("ALL_HTTP")
    NotifyAbort "ABORT: " + User
	Response.Cookies(SysCookie).Expires = Now()-1
	Session.Abandon
	SetCache "USERID", 99
	SetCache "USERGROUP", 99
	SetCache "UC", ""
	Response.Write "Oops! System Unavailable.  Please contact customer support for assistance."     
	Response.end
End Function

'**************************************************************************************
Function NotifyAbort( tmpSubject )
    Set oMail = server.CreateObject("CDO.Message")
    If oMail Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - CDO.Message"
    Else
        With oMail
            .From = "app-events@pinnaclep.com"
            .To = "app-events@pinnaclep.com"
            .Subject = tmpSubject 
            .Send
        End With
    End If
    Set oMail = Nothing
End Function

'**************************************************************************************
Function Is2FA( tmpAuthUserID )
	O2FA = Numeric(GetCache("O2FA"))
    If O2FA = 1 Then
        Is2FA = 0
    Else
        Set oAuthUser = server.CreateObject("ptsAuthUser.CAuthUser")
        With oAuthUser
            .AuthUserID = tmpAuthUserID
            .Load 1
            If (.UserType <> 0) Or (.UserKey <> "") Then
                Is2FA = 1
            Else
                Is2FA = 0
            End If
        End With
        Set oAuthUser = Nothing
    End If
End Function

%>

