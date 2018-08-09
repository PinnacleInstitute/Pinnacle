Attribute VB_Name = "CEmailMod"
Option Explicit
'-----constants
Private Const cModName As String = "CEmailMod"

'-----enum item type constants
Public Const cptsEmailEnumFindType As Long = 1
Public Const cptsEmailEnumStatus As Long = 8809

'-----enum FindType constants
Public Const cptsEmailFindEmailName As Long = 8805
Public Const cptsEmailFindSendDate As Long = 8810
Public Const cptsEmailFindStatus As Long = 8809

'-----enum Status constants
Public Const cptsEmailStatusCompose As Long = 1
Public Const cptsEmailStatusReady As Long = 2
Public Const cptsEmailStatusSent As Long = 3
Public Const cptsEmailStatusCancelled As Long = 4