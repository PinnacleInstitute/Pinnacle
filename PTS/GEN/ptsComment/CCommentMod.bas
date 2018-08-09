Attribute VB_Name = "CCommentMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCommentMod"

'-----enum item type constants
Public Const cptsCommentEnumStatus As Long = 14612

'-----enum Status constants
Public Const cptsCommentStatusPending As Long = 1
Public Const cptsCommentStatusBlocked As Long = 2
Public Const cptsCommentStatusOpen As Long = 3
Public Const cptsCommentStatusClosed As Long = 4