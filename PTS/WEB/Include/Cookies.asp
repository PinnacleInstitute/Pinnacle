<%
PUBLIC CONST IsLogging = 0
PUBLIC CONST SysClient = "Pinnacle"
PUBLIC CONST SysProject = "PTS"
PUBLIC CONST SysCookie = "TEMPPTS"
PUBLIC CONST SysCookiePersist = "PTS"

Function GetCache(ByVal bvName)
	GetCache = Request.Cookies(SysCookie)(bvName)
End Function

Sub SetCache(ByVal bvName, ByVal bvValue)
	Response.Cookies(SysCookie)(bvName) = bvValue
End Sub

Function GetCookie(ByVal bvName)
	GetCookie = Request.Cookies(SysCookiePersist)(bvName)
End Function

Sub SetCookie(ByVal bvName, ByVal bvValue)
	Response.Cookies(SysCookiePersist)(bvName) = bvValue
	Response.Cookies(SysCookiePersist).Expires = Now() + 90
End Sub

Function GetReturnURL()
	Dim sURL
	sURL = Request.ServerVariables("HTTP_REFERER")
	GetReturnURL = sURL
End Function

Function CheckSecurity(ByRef brUserID, ByRef brUserGroup, ByVal bvSecured, ByVal bvSecuredGroup )
	brUserID = CLng(GetCache("USERID"))
	brUserGroup = CLng(GetCache("USERGROUP"))
	If (bvSecured=1) Then
		If (CLng(brUserID) = CLng(0)) Then
			SetCache "SignInURL", MakeReturnURL
			Response.Redirect "0101.asp"
		ElseIf (brUserGroup > bvSecuredGroup) Then
			SetCache "SignInURL", MakeReturnURL
			Response.Redirect "0101.asp?ActionCode=9"
		End If
	ElseIf (bvSecured=2) Then
		If (CLng(brUserID) = CLng(0)) Then
			SetCache "SignInURL", MakeReturnURL
			Response.Redirect "0101.asp"
		ElseIf (brUserGroup <> bvSecuredGroup) Then
			SetCache "SignInURL", MakeReturnURL
			Response.Redirect "0101.asp?ActionCode=9"
		End If
	ElseIf (brUserID = 0) Then 
		brUserID = CLng(99)
		brUserGroup = CLng(99)
		SetCache "USERID", CLng(brUserID)
		SetCache "USERGROUP", CLng(brUserGroup)
		SetCache "USERSTATUS", CLng(1)
	End If
End Function

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

Function CleanXML(ByVal bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanXML = Replace(bvValue, Chr(62), "&gt;")
End Function

Function GetUniqueID()

  Randomize 
  for iCtr = 1 to 10
	sChar = Chr(Int((90 - 65 + 1) * Rnd) + 65)
  	sID = sID & sChar
  Next
  
  sID = sID & Month(Now) & Day(Now) & Year(Now) & Hour(Now) _
    & Minute(Now) & Second(Now)

  GetUniqueID = sID
End Function
%>

