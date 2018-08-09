Attribute VB_Name = "CAdMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAdMod"

'-----enum item type constants
Public Const cptsAdEnumFindType As Long = 1
Public Const cptsAdEnumStatus As Long = 14306

'-----enum FindType constants
Public Const cptsAdFindAdName As Long = 14305
Public Const cptsAdFindMemberName As Long = 14304
Public Const cptsAdFindPlacement As Long = 14308

'-----enum Status constants
Public Const cptsAdStatusPending As Long = 1
Public Const cptsAdStatusActive As Long = 2
Public Const cptsAdStatusInactive As Long = 3