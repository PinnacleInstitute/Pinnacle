Attribute VB_Name = "CMsgMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMsgMod"

'-----enum item type constants
Public Const cptsMsgEnumFindType As Long = 1
Public Const cptsMsgEnumStatus As Long = 9713

'-----enum FindType constants
Public Const cptsMsgFindMsgID As Long = 9701
Public Const cptsMsgFindSubject As Long = 9711
Public Const cptsMsgFindMessage As Long = 9712

'-----enum Status constants
Public Const cptsMsgStatusCompose As Long = 1
Public Const cptsMsgStatusReady As Long = 2
Public Const cptsMsgStatusSent As Long = 3