<%
'*************************************
Function FileExists(strFileName)
    set fs=Server.CreateObject("Scripting.FileSystemObject")
    FileExists = fs.FileExists(strFileName) 
    set fs=nothing
End Function

'*************************************
Function FolderExists(strFolderName)
    set fs=Server.CreateObject("Scripting.FileSystemObject")
    FolderExists = fs.FolderExists(strFolderName) 
    set fs=nothing
End Function

'*************************************
Sub CopyFile(strFileName, strFileName2)
    set fs=Server.CreateObject("Scripting.FileSystemObject")
    fs.CopyFile strFileName, strFileName2 
    set fs=nothing
End Sub

'*************************************
Sub DeleteFile(strFileName)
    set fs=Server.CreateObject("Scripting.FileSystemObject")
    fs.DeleteFile strFileName 
    set fs=nothing
End Sub

'*************************************
Function ListFiles(strFolderName, strExt, strFilter)
    On Error Resume Next
    set fs = Server.CreateObject("Scripting.FileSystemObject")
    strExt = UCase(strExt)
    strFilter = UCase(strFilter)

    If fs.FolderExists(strFolderName) Then
        Set Files = fs.GetFolder(strFolderName).Files
        xml = "<FILES>"
        For Each File In Files
            kb = Round(File.Size / 1024)
            If kb = 0 Then kb = 1
            'Test for excluded extensions
            include = False 
            If strExt <> "" Then
                ext = UCase(Right(File.Name, 3))
                If InStr(strExt, ext) > 0 Then include = True
            Else
                include = True
            End If
            If include = True And strFilter <> "" Then
                l = Len(strFilter)
                If Left(strFilter,l) <> Left( UCase(File.Name), l) Then include = False 
            End If
            If include = True Then
                xml = xml + "<FILE name=" + Chr(34) + CleanXML(File.Name) + Chr(34) + " size=" + Chr(34) + FormatNumber(kb,0) + " KB" + Chr(34) + " date=" + Chr(34) & FormatDateTime(File.DateLastModified) & Chr(34) + "/>"
            End If
        Next
        xml = xml + "</FILES>"
        Set Files = Nothing
        Set oFolder = Nothing
    End If
    ListFiles = xml
    set fs = nothing
End Function

'*************************************
Function FileList(strFolderName, strExt, strFilter)
    On Error Resume Next
    set fs = Server.CreateObject("Scripting.FileSystemObject")
    strExt = UCase(strExt)
    strFilter = UCase(strFilter)

    If fs.FolderExists(strFolderName) Then
        Set Files = fs.GetFolder(strFolderName).Files
        str = ""
        For Each File In Files
            kb = Round(File.Size / 1024)
            If kb = 0 Then kb = 1
            'Test for excluded extensions
            include = False 
            If strExt <> "" Then
                ext = UCase(Right(File.Name, 3))
                If InStr(strExt, ext) > 0 Then include = True
            Else
                include = True
            End If
            If include = True And strFilter <> "" Then
                l = Len(strFilter)
                If Left(strFilter,l) <> Left( UCase(File.Name), l) Then include = False 
            End If
            If include = True Then
                str = str + File.Name + "|"
            End If
        Next
        Set Files = Nothing
        Set oFolder = Nothing
    End If
    FileList = str
    set fs = nothing
End Function

'*************************************
Function CleanXML(ByVal bvValue)
   '-----&AMP MUST BE FIRST!!!
   bvValue = Replace(bvValue, Chr(38), "&amp;")
   bvValue = Replace(bvValue, Chr(34), "&quot;")
   bvValue = Replace(bvValue, Chr(39), "&apos;")
   bvValue = Replace(bvValue, Chr(60), "&lt;")
   CleanXML = Replace(bvValue, Chr(62), "&gt;")
End Function

%>
