Attribute VB_Name = "wtiCommonUserMod"
Option Explicit
Private Const cModName As String = "wtiCommonUserMod"

'--- XML function Options -------------------
Public Const cXMLEnumOnly As Long = 1		  'Returns only the Enums for an Item or Collection
Public Const cXMLNoEnum As Long = 2		     'Returns No Enums for an Item or Collection
Public Const cXMLNoChildEnum As Long = 3	  'Returns No Enums for an Item
Public Const cXMLNoLookupEnum As Long = 4	  'Returns only the Static Enums for a Item or Collection (non-lookup unfiltered)
Public Const cXMLNoFilterEnum As Long = 5	  'Returns only the Static Enums for a Item or Collection (non-lookup)

Public Function WTBlankDate( _
   ByVal bvDate As Date) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a blank string if Date = 0.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTBlankDate"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   If Year(bvDate) < 1900 Then
      WTBlankDate = ""
   Else
      WTBlankDate = CDate(bvDate)
   End If
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function WTBlankNumber( _
   ByVal bvNumber As Long) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a blank string if number = 0.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTBlankNumber"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   If bvNumber = 0 Then
      WTBlankNumber = ""
   Else
      WTBlankNumber = CStr(bvNumber)
   End If
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function WTBlankValue( _
   ByVal bvValue As Double) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a blank string if Value = 0.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTBlankValue"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   If bvValue = 0 Then
      WTBlankValue = ""
   Else
      WTBlankValue = CStr(bvValue)
   End If
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function WTComboValue( _
   ByRef oCombo As ComboBox)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns the item data for the selected item
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTComboValue"
   '---------------------------------------------------------------------------------------------------------------------------------
   
   On Error GoTo ErrorHandler
   
   With oCombo
      If .ListIndex = -1 Then
         WTComboValue = 0
      Else
         WTComboValue = .ItemData(.ListIndex)
      End If
   End With
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Sub WTEnableControl( _
   ByRef oControl As Control, _
   ByVal bvEnable As Boolean)
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Enables/Disables the specified control
   '
   '  Input:
   '  oControl - reference to a control [Required]
   '  bvEnable - flag specifying if the control should be enabled or not [Required]
   '
   '  Output:
   '  None
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTEnableControl"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   With oControl
      .Enabled = bvEnable
      If bvEnable Then
         .BackColor = vbWindowBackground
      Else
         .BackColor = vbButtonFace
      End If
   End With
   
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Sub WTLoadCombo( _
   ByRef oCombo As ComboBox, _
   ByRef oEnums As wtSystem.CEnumItems, _
   Optional ByVal bvNoSelectionText As String = "", _
   Optional ByVal bvSelectedValue As Long = 0, _
   Optional ByVal bvSelectedText As String = "")
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Helper function which loads a combo box control with the items from an enumerator.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTLoadCombo"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim oItem As wtSystem.CEnumItem
   Dim idxEnum As Integer
   Dim Name As String
   Dim ID As Long
   
   On Error GoTo ErrorHandler
   
   '-----if no selection text then add that as the first item
   If Len(bvNoSelectionText) > 0 Then
      oCombo.AddItem bvNoSelectionText
   End If
   
   '-----loop through all items and add them to the combo
   For Each oItem In oEnums
      With oItem
         Name = .Name
         ID = .ID
      End With
      With oCombo
         .AddItem Name
         .ItemData(.NewIndex) = ID
         
         '----check for defaults selection and set the item
         '-----only need to check if i still don't have an item selected
         If (Len(.Text) = 0) Then
            If (ID > 0) Then
               If ID = bvSelectedValue Then
                  '-----if the Value matches then set it
                  .Text = Name
               End If
            ElseIf Len(bvSelectedText) > 0 Then
               If (StrComp(Name, bvSelectedText, vbTextCompare) = 0) Then
               '-----else if the item matches then select it
                  .Text = Name
               End If
            End If
         End If
      End With
   Next oItem
         
   Exit Sub

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Sub

Public Function WTSetCheckBox( _
   ByVal bvBool As Boolean) As Integer
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns a blank string if number = 0.
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "WTSetCheckBox"
   '---------------------------------------------------------------------------------------------------------------------------------
   On Error GoTo ErrorHandler
   
   WTSetCheckBox = Abs(CInt(bvBool))
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

Public Function EmbeddedText(ByVal bvText As String, ByVal bvToken As String) As String
   '---------------------------------------------------------------------------------------------------------------------------------
   '  parses a string for an embedded token and returns its data
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "EmbeddedText"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim val As String
   Dim pos As Integer
   Dim pos1 As Integer
   Dim length As Integer
   
   On Error GoTo ErrorHandler

   pos = InStr(bvText, bvToken + "[")
      
   If pos > 0 Then
      length = pos + Len(bvToken) + 1
      pos1 = InStr(length, bvText, "]")
      If pos1 > 0 Then
         val = Mid(bvText, length, pos1 - length)
      End If
   End If
   
   EmbeddedText = val
   
   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function

