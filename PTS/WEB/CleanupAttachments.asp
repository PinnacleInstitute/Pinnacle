<% Response.Buffer=true

On Error Resume Next

'get the delete parameter
Delete = Request.Item("delete")

'get the path to the Attachments folder
Folder = Request.ServerVariables("APPL_PHYSICAL_PATH") + "\Attachments"

'create the object to make the http calls
Set oHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
If oHTTP Is Nothing Then
	Response.Write "Error #" & Err.number & " - " + Err.description
Else
	'print the header
	Response.Write "<BR>Cleanup UnAttached Files<BR>"
	'initialize the counter variables	
	cnt = 0
	size = 0
	totcnt = 0
	totsize = 0
	delfolders = 0
	totfolders = 0
	'create the object for reading the attachemnt files
   Set oFileSys = server.CreateObject("Scripting.FileSystemObject") 
   With oFileSys
		'check that the attachments folder exists
      If .FolderExists(Folder) Then
			' open the attachments folder
         Set oFolder = .GetFolder(Folder)
         'walk through each ParentType folder in the Attachments folder
         For Each oParentType In oFolder.SubFolders
            With oParentType
					'get the ParentType folder name
               sParentType = .ShortName
               For Each oParentID In .SubFolders
						totfolders = totfolders + 1
                  With oParentID
							'get the ParentID folder name
                     sParentID = .ShortName
                     TotalFiles = 0
                     DeletedFiles = 0
                     For Each oFile In .Files
	                     TotalFiles = TotalFiles + 1
                        With oFile
									'get the Attachemnt filename
									sFile = .Name
									'If the Attachments are stored on a remote document server, build the entire link name
									'sFile = "http://www.ecoquest.com/Attachments\" + sParentType + "\" + sParentID + "\" + .Name
									
									'increment the total file counter and total size
									totcnt = totcnt + 1
									totsize = totsize + .size
									'Get the URL to call
									'TEST URL = "http://localhost/pts/CheckAttachment.asp?type=" & sParentType & "&id=" & sParentID & "&file=" & Replace(sFile, "&", "%26")
									URL = "http://www.Pinnaclep.com/CheckAttachment.asp?type=" & sParentType & "&id=" & sParentID & "&file=" & Replace(sFile, "&", "%26")
									'check if the file is referenced by an Attachment for the ParentType and ParentID
									oHTTP.open "GET", URL, False
									oHTTP.send
									result = oHTTP.responseText
									'If the result is 0, then the file has no attachment for the ParentType and ParentID
									If result = "0" Then
										'output the file information that has no attachment
										Response.Write "<BR>" + sParentType + "\" + sParentID + "\" + sFile + "  (" & FormatNumber((.size/1024),0) & "KB)"
										'increment the counter and size of files with no attachments
										cnt = cnt + 1
										size = size + .size
										'if the delete parameter was specified, then delete the file
										If Delete <> "" Then .Delete
										'count the number of deleted files to see if the folder is empty
										DeletedFiles = DeletedFiles + 1
									End If
                        End With
                     Next
							'if the folder is empty
							If DeletedFiles = TotalFiles Then 
								'count the number of deleted folders
								delFolders = delFolders + 1
								'if we are in delete mode, delete it
								If Delete <> "" Then
									.Delete
									'output the empty folder information
									Response.Write "<BR>Empty Folder Deleted " + sParentType + "\" + sParentID
								Else
									'output the empty folder information
									Response.Write "<BR>Empty Folder " + sParentType + "\" + sParentID
								End If	
							End If	
                  End With
               Next
            End With
         Next
      End If
   End With

   cMB = 1024			'bytes in 1 MB
   cGB = 1048576		'bytes in 1 GB
   cTB = 1073741824	'bytes in 1 TB

	'format the size 
   If size < (cGB) Then
      sSize = FormatNumber((size / cMB), 0) & " KB"
   ElseIf size < (cTB) Then
      sSize = FormatNumber((size / cGB), 2) & " MB"
   Else
      sSize = FormatNumber((size / cTB), 2) & " GB"
   End If

	'if we have any unattached files, output the Unattached file summary
	If size > 0 Then
		If Delete = "" Then
			Response.Write "<BR><BR>" & cnt & " UnAttached Files (" + sSize + ")"
		Else	
			Response.Write "<BR><BR>" & cnt & " UnAttached Files Deleted (" + sSize + ")"
		End If
	End If

	'format the total size 
   If totsize < (cGB) Then
      sTotSize = FormatNumber((totsize / cMB), 0) & " KB"
   ElseIf totsize < (cTB) Then
      sTotSize = FormatNumber((totsize / cGB), 2) & " MB"
   Else
      sTotSize = FormatNumber((totsize / cTB), 2) & " GB"
   End If

	'output the total file summary
	Response.Write "<BR><BR>" & totcnt & " Total Files (" + sTotSize + ")"
	'output the total folder summary
	Response.Write "<BR>" & totFolders & " Total Folders (" & delFolders & " empty)"

   Set oFolder = Nothing
   Set oFileSys = Nothing
	Set oHTTP = Nothing
End If	


%>
