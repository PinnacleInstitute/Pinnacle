Attribute VB_Name = "CFriendMod"
Option Explicit
'-----constants
Private Const cModName As String = "CFriendMod"

'-----enum item type constants
Public Const cptsFriendEnumFindType As Long = 1
Public Const cptsFriendEnumStatus As Long = 14115

'-----enum FindType constants
Public Const cptsFriendFindFriendName As Long = 14112
Public Const cptsFriendFindEmail As Long = 14113
Public Const cptsFriendFindFriendDate As Long = 14114
Public Const cptsFriendFindFriendGroupName As Long = 14105
Public Const cptsFriendFindCountryName As Long = 14106

'-----enum Status constants
Public Const cptsFriendStatusPending As Long = 1
Public Const cptsFriendStatusApproved As Long = 2
Public Const cptsFriendStatusCancelled As Long = 3
Public Const cptsFriendStatusTerminated As Long = 4