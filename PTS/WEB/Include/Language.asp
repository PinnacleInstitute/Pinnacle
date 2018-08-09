<% 

Function GetLanguage( _
	ByRef brDialect, _
	ByRef brCountry, _
	ByRef brDefault)

	Dim AppCodes, DefaultCode
	Dim reqUserCodes, pos
	Dim vAppCodes, idxAppCodes, sAppCode
	Dim vUserCodes, idxUserCodes, sUserCode 

	'*** CUSTOMIZE - Set the supported languages ***
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
Function FileExists(filename)
   On Error Resume Next
   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   FileExists = oFileSys.FileExists(filename)
   Set oFileSys = Nothing
End Function

%>