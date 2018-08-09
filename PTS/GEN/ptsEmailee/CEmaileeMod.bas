Attribute VB_Name = "CEmaileeMod"
Option Explicit
'-----constants
Private Const cModName As String = "CEmaileeMod"

'-----enum item type constants
Public Const cptsEmaileeEnumFindType As Long = 1
Public Const cptsEmaileeEnumStatus As Long = 8714

'-----enum FindType constants
Public Const cptsEmaileeFindEmail As Long = 8705
Public Const cptsEmaileeFindEmaileeName As Long = 8708
Public Const cptsEmaileeFindEmailListID As Long = 8703

'-----enum Status constants
Public Const cptsEmaileeStatusActive As Long = 1
Public Const cptsEmaileeStatusInActive As Long = 2
Public Const cptsEmaileeStatusUnsubscribed As Long = 3