Attribute VB_Name = "CAuthLogMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAuthLogMod"

'-----enum item type constants
Public Const cptsAuthLogEnumStatus As Long = 7107

'-----enum Status constants
Public Const cptsAuthLogStatusAllow As Long = 1
Public Const cptsAuthLogStatusDisallow As Long = 2
Public Const cptsAuthLogStatusOverride As Long = 3