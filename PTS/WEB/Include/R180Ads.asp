<%
'*****************************************************************************************************
Function AdTracks( byVal bvType, byVal bvFromDate, byVal bvToDate, byRef brFile, byRef brTotal)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

	Set oR180s = server.CreateObject("ptsR180User.CR180s")
	If oR180s Is Nothing Then
		DoError Err.Number, Err.Source, "Unable to Create Object - ptsR180User.CR180s"
	Else
		With oR180s
		.SysCurrentLanguage = reqSysLanguage
		.Report bvType, bvFromDate, bvToDate, 0, 0
		If (Err.Number <> 0) Then DoError Err.Number, Err.Source, Err.Description End If

		Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Ads\" 
		dt = CStr(Year(Date)) + "-" + CStr(Month(Date)) + "-" + CStr(Day(Date)) + "-" + CSTR(Hour(Now)) + "-" + CSTR(Minute(Now))
	    brFile = "AD" + CStr(bvType) + "-" + dt + ".csv"

        brTotal = 0
		For Each oItem in oR180s

			If brTotal = 0 Then
				Set oFile = oFileSys.CreateTextFile(Path + brFile, True)
				If oFile Is Nothing Then
					Response.Write "Couldn't create Order file: " + Path + brFile
					Response.End
				Else
    			    If bvType = 1 Then 'Member Ads'
                        rec = "Member Ads - " + CStr(bvFromDate) + " to " + CStr(bvToDate)
            			oFile.WriteLine( Rec )
                        rec = "MemberID,NameLast,NameFirst,AdvertiserID,AdvertiserName,AdID,AdName,Impressions"
            			oFile.WriteLine( Rec )
    			    End If
    			    If bvType = 2 Then 'Advertiser Ads'
                        rec = "Advertiser Ads - " + CStr(bvFromDate) + " to " + CStr(bvToDate)
            			oFile.WriteLine( Rec )
                        rec = "MemberID,CompanyName,AdID,AdName,Impressions"
            			oFile.WriteLine( Rec )
    			    End If
				End If
			End If

			With oItem
				Rec = .Result
			End With

			oFile.WriteLine( Rec )
					
			brTotal = brTotal + 1

		Next
		If brTotal > 0 Then oFile.Close
		Set oFile = Nothing

		End With
	End If

	Set oR180s = Nothing
	Set oFileSys = Nothing

End Function

%>

