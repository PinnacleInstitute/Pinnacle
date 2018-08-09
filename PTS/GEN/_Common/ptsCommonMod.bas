Attribute VB_Name = "ptsCommonMod"
Option Explicit
Private Const cModName As String = "gasCommonMod"

Public Declare Function GetModuleFileName Lib "kernel32" Alias "GetModuleFileNameA" (ByVal hModule As Long, ByVal lpFileName As String, ByVal nSize As Long) As Long

Public Function IsIDE() As Boolean
   '---------------------------------------------------------------------------------------------------------------------------------
   '  Returns true or flase inicating if the Visual Basic IDE is running
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim ErrNo As Long, ErrSrc As String, ErrDesc As String
   Const cProcName As String = "IsIDE"
   '---------------------------------------------------------------------------------------------------------------------------------
   Dim sFileName As String
   Dim api As Long
   
   On Error GoTo ErrorHandler

   '-----initialize variables for API call
   sFileName = String(255, 0)
      
   api = GetModuleFileName(App.hInstance, sFileName, (Len(sFileName)))
   '-----api returns length of string buffer
   sFileName = Left$(sFileName, api)
   
   '-----if the module path points to vb then we are
   '-----running in the IDe, otherwise not.
   IsIDE = (UCase(Right$(sFileName, 7)) = "VB6.EXE")

   Exit Function

ErrorHandler:
   CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName
   If Err.Number = 0 Then Resume Next
   Err.Raise ErrNo, ErrSrc, ErrDesc
End Function
