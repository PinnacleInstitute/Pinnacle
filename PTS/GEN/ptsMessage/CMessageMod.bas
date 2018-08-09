Attribute VB_Name = "CMessageMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMessageMod"

'-----enum item type constants
Public Const cptsMessageEnumFindType As Long = 1
Public Const cptsMessageEnumStatus As Long = 8521

'-----enum FindType constants
Public Const cptsMessageFindMessageTitle As Long = 8520
Public Const cptsMessageFindBody As Long = 8523

'-----enum Status constants
Public Const cptsMessageStatusOpen As Long = 1
Public Const cptsMessageStatusLocked As Long = 2
Public Const cptsMessageStatusSecured As Long = 3