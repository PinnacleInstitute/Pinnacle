Attribute VB_Name = "CBroadcastMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBroadcastMod"

'-----enum item type constants
Public Const cptsBroadcastEnumFindType As Long = 1
Public Const cptsBroadcastEnumStatus As Long = 14406

'-----enum FindType constants
Public Const cptsBroadcastFindBroadcastDate As Long = 14405
Public Const cptsBroadcastFindFriendGroupName As Long = 14404

'-----enum Status constants
Public Const cptsBroadcastStatusPending As Long = 1
Public Const cptsBroadcastStatusSend As Long = 2
Public Const cptsBroadcastStatusSent As Long = 3