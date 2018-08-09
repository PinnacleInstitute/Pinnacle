Attribute VB_Name = "CMeetingMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMeetingMod"

'-----enum item type constants
Public Const cptsMeetingEnumStatus As Long = 17913

'-----enum Status constants
Public Const cptsMeetingStatusPending As Long = 1
Public Const cptsMeetingStatusActive As Long = 2
Public Const cptsMeetingStatusFull As Long = 3
Public Const cptsMeetingStatusCancelled As Long = 4
Public Const cptsMeetingStatusComplete As Long = 5