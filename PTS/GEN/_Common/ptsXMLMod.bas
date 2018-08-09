Attribute VB_Name = "wtiXMLMod"
Option Explicit
Private Const cModName As String = "wtiXMLMod"

Public Function FormatXML( _
   ByVal bvXML As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns th specified XML formatted with carriage returns and indentation
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "FormatXML"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim char1 As String
   Dim char2 As String
   Dim idxchar As Long
   Dim WorkStr As String
   Dim Result As String
   Dim mTabs As Integer
   Dim TotalLen As Long
   Dim StartMode As Boolean
   Dim StartTag As String
   Dim NoIndent As Boolean
   Dim Strip As Boolean
   
   On Error GoTo ErrorHandler

   mTabs = 0
   
   WorkStr = Replace(bvXML, vbCrLf, "")
   WorkStr = Replace(WorkStr, vbTab, "")
   WorkStr = Trim$(WorkStr)
   
   TotalLen = Len(WorkStr)
   For idxchar = 1 To TotalLen
      char1 = Mid$(WorkStr, idxchar, 1)
      char2 = Mid$(WorkStr, idxchar, 2)
      '-----if closing a tag
      If char2 = "</" Then
         'start indenting again if end tag for script
         If Mid$(WorkStr, idxchar + 2, 12) = "msxsl:script" Then
            NoIndent = False
         End If
         If Not NoIndent Then
            mTabs = mTabs - 1
            StartMode = False
            '--if the StartTag matches this closing tag, leave the closing tag on the same line
            If StartTag = Mid$(WorkStr, idxchar + 2, Len(StartTag)) Then
               Result = Result + "<"
            Else
               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
            End If
         Else
            Result = Result + "<"
         End If
      '-----if closing a tag
      ElseIf char2 = "/>" Then
         Result = Result + "/"
         If Not NoIndent Then
            mTabs = mTabs - 1
            StartMode = False
         End If
      '-----if starting a new tag
      ElseIf char1 = "<" Then
         'ignore less than sign (not a start tag)
         If char2 = "< " Or char2 = "<=" Then
            Result = Result + "<"
         Else
            If NoIndent Then
               Result = Result + "<"
            Else
               Result = Result + vbCrLf + String(mTabs, vbTab) + "<"
               If char2 <> "<?" And char2 <> "<!" Then mTabs = mTabs + 1
               StartMode = True
               StartTag = ""
            End If
            'don't indent script
            If Mid$(WorkStr, idxchar + 1, 12) = "msxsl:script" Then
               NoIndent = True
            End If
         End If
      '-----else nothing
      Else
         Result = Result + char1
         'remember the most recent start tag
         If StartMode Then
            If char1 = " " Or char1 = ">" Or char1 = "/" Then
               StartMode = False
            Else
               StartTag = StartTag + char1
            End If
         End If
      End If
   Next idxchar
   
   FormatXML = Result
      
   Exit Function

ErrorHandler:
   Err.Raise Err.Number, Err.Source, Err.Description
End Function

Public Function GetXMLEmptyElement( _
   ByVal bvXMLTag As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns the XML for an emty element.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "GetXMLEmptyElement"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler

   '-----return an emty tag for the element
   GetXMLEmptyElement = "<" + UCase$(Trim$(bvXMLTag)) + "/>"

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLElement( _
   ByVal bvName As String, _
   Optional ByVal bvAttributes As String = "", _
   Optional ByVal bvValue As String = "", _
   Optional ByVal bvChildren As String = "") As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a formatted XML Element. The name of the element is UPPERCASED for consistency.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLElement"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sXML As String
   Dim bAttributesOnly As Boolean
   
   On Error GoTo ErrorHandler
   
   '-----uppercase all element names
   bvName = UCase$(bvName)
   
   If Len(bvValue) + Len(bvChildren) = 0 Then bAttributesOnly = True
   
   '-----generate the element tags if I have something to write out
   If (Len(bvAttributes) + Len(bvValue) + Len(bvChildren) > 0) Then
      '-----start element tag
      sXML = sXML + "<" + bvName
      '-----attributes
      If Len(bvAttributes) > 0 Then
         sXML = sXML + Space(1) + Trim$(bvAttributes)
      End If
      If bAttributesOnly Then
         sXML = sXML + "/>"
      Else
         sXML = sXML + ">"
         '-----value
         If Len(bvValue) > 0 Then
            sXML = sXML + bvValue
         End If
         '-----children's XML
         If Len(bvChildren) > 0 Then
            sXML = sXML + bvChildren
         End If
         '-----close element tag
         sXML = sXML + "</" + bvName + ">"
      End If
   Else
      '-----generate an empty tag
      sXML = GetXMLEmptyElement(bvName)
   End If
   
   XMLElement = sXML
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function XMLAttribute( _
   ByVal bvName As String, _
   ByVal bvValue As String, _
   Optional ByVal bvCheckEmpty As Boolean = True) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a formatted XML attribute for inclusion in an XML Element. The name of the attribute is LOWERCASED for consistency.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "XMLAttribute"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim bEmpty As Boolean
   
   On Error GoTo ErrorHandler
   
   '-----lowercase all attribute names
   bvName = LCase$(bvName)
   'replace double quote with a single quote
'   bvValue = Replace(bvValue, Chr$(34), Chr$(39))
   
   '----- check for empty number, string, boolean, or date
   bEmpty = False
   If bvCheckEmpty Then
      If bvValue = "0" Or Len(bvValue) = 0 Or bvValue = "False" Or bvValue = "12:00:00 AM" Then
         bEmpty = True
      End If
   End If
   
   '-----start element tag
   If bEmpty Then
      XMLAttribute = ""
   Else
      '-----replace reserved xml values
        
      '-----&AMP MUST BE FIRST!!!
      bvValue = Replace(bvValue, Chr$(38), "&amp;")
      bvValue = Replace(bvValue, Chr$(34), "&quot;")
      bvValue = Replace(bvValue, Chr$(39), "&apos;")
      bvValue = Replace(bvValue, Chr$(60), "&lt;")
      bvValue = Replace(bvValue, Chr$(62), "&gt;")
           
      XMLAttribute = Space(1) + bvName + "=" + Chr$(34) + CStr(bvValue) + Chr$(34)
   End If
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

