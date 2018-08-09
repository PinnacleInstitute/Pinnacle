<%
'*****************************************************************************************************
Function NewMembers( byVal bvCompanyID, byVal bvOption)
	On Error Resume Next
    
	Dim oFileSys, oFile, Rec, total
	total = 0
		            
	Set oFileSys = CreateObject("Scripting.FileSystemObject")
	If oFileSys Is Nothing Then
		Response.Write "Scripting.FileSystemObject failed to load"
		Response.End
	End If

    Set oMembers = server.CreateObject("ptsMemberUser.CMembers")
    If oMembers Is Nothing Then
        DoError Err.Number, Err.Source, "Unable to Create Object - ptsMemberUser.CMembers"
    Else
        With oMembers
            .SysCurrentLanguage = reqSysLanguage
            .CustomList bvCompanyID, bvOption, 0

			Path = Request.ServerVariables("APPL_PHYSICAL_PATH") + "Sections\Company\" & bvCompanyID & "\"
			File = "NewMembers.csv"
			
			total = 0
			For Each oItem in oMembers

				If total = 0 Then
					Set oFile = oFileSys.CreateTextFile(Path + File, True)
					If oFile Is Nothing Then
						Response.Write "Couldn't create file: " + Path + File
						Response.End
					End If
				End If

				With oItem
					Rec = .Signature
				End With

				oFile.WriteLine( Rec )
						
				total = total + 1

			Next
			If total > 0 Then oFile.Close
			Set oFile = Nothing

        End With
    End If

    Set oMembers = Nothing
	Set oFileSys = Nothing

	NewMembers = total
	
End Function

%>

