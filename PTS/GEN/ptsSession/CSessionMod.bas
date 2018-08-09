Attribute VB_Name = "CSessionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSessionMod"

'-----enum item type constants
Public Const cptsSessionEnumStatus As Long = 1318
Public Const cptsSessionEnumCommStatus As Long = 1336
Public Const cptsSessionEnumApply As Long = 1337

'-----enum Status constants
Public Const cptsSessionStatusRegistered As Long = 1
Public Const cptsSessionStatusStarted As Long = 2
Public Const cptsSessionStatusDropped As Long = 3
Public Const cptsSessionStatusCompleted As Long = 5
Public Const cptsSessionStatusQuized As Long = 6
Public Const cptsSessionStatusCertified As Long = 7

'-----enum CommStatus constants
Public Const cptsSessionCommStatusNo As Long = 1
Public Const cptsSessionCommStatusYes As Long = 2
Public Const cptsSessionCommStatusNone As Long = 3

'-----enum Apply constants
Public Const cptsSessionApplyApply1 As Long = 1
Public Const cptsSessionApplyApply2 As Long = 2
Public Const cptsSessionApplyApply3 As Long = 3
Public Const cptsSessionApplyApply4 As Long = 4