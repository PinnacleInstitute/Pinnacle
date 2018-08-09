<%
'**************************************************************************************
'Function FormatXML( ByVal bvXML)
'   
'   On Error  Resume Next
'
'   mTabs = 0
'   
'   WorkStr = Replace(bvXML, vbCrLf, "")
'   WorkStr = Replace(WorkStr, vbTab, "")
'   WorkStr = Trim(WorkStr)
'   
'   TotalLen = Len(WorkStr)
'   For idxchar = 1 To TotalLen
'      char1 = Mid(WorkStr, idxchar, 1)
'      char2 = Mid(WorkStr, idxchar, 2)
'      '-----if closing a tag
'      If char2 = "</" Then
'         'start indenting again if end tag for script
'         If Mid(WorkStr, idxchar + 2, 12) = "msxsl:script" Then
'            NoIndent = False
'         End If
'         If Not NoIndent Then
'            mTabs = mTabs - 1
'            StartMode = False
'            '--if the StartTag matches this closing tag, leave the closing tag on the same line
'            If StartTag = Mid(WorkStr, idxchar + 2, Len(StartTag)) Then
'               Result = Result + "<"
'            Else
'               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
'            End If
'         Else
'            Result = Result + "<"
'         End If
'      '-----if closing a tag
'      ElseIf char2 = "/>" Then
'         Result = Result + "/"
'         If Not NoIndent Then
'            mTabs = mTabs - 1
'            StartMode = False
'         End If
'      '-----if starting a new tag
'      ElseIf char1 = "<" Then
'         'ignore less than sign (not a start tag)
'         If char2 = "< " Or char2 = "<=" Then
'            Result = Result + "<"
'         Else
'            If NoIndent Then
'               Result = Result + "<"
'            Else
'               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
'               If char2 <> "<?" And char2 <> "<!" Then mTabs = mTabs + 1
'               StartMode = True
'               StartTag = ""
'            End If
'            'don't indent script
'            If Mid(WorkStr, idxchar + 1, 12) = "msxsl:script" Then
'               NoIndent = True
'            End If
'         End If
'      '-----else nothing
'      Else
'         Result = Result + char1
'         'remember the most recent start tag
'         If StartMode Then
'            If char1 = " " Or char1 = ">" Or char1 = "/" Then
'               StartMode = False
'            Else
'               StartTag = StartTag + char1
'            End If
'         End If
'      End If
'   Next
'   
'   FormatXML = Result
'   
'End Function

'**************************************************************************************
Function SaveXMLFile(filename, data)
   On Error Resume Next
   
'   data = FormatXML( data )

   Set oFileSys = CreateObject("Scripting.FileSystemObject")
   If oFileSys Is Nothing Then
      Response.Write "Scripting.FileSystemObject failed to load"
      Response.End
   End If
   '-----open the language file to replace its contents, create it if it doesn't exist
   Set oFile = oFileSys.OpenTextFile(filename, 2, True)
   If oFile Is Nothing Then
      Response.Write "Couldn't open file: " + filename
      Response.End
   End If
   '-----this will overwrite the file if it already exists
   oFile.Write data
   oFile.Close
   Set oFile = Nothing
   Set oFileSys = Nothing

End Function

%>

