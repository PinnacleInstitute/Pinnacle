Attribute VB_Name = "CMemberAssessMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMemberAssessMod"

'-----enum item type constants
Public Const cptsMemberAssessEnumStatus As Long = 3412
Public Const cptsMemberAssessEnumCommStatus As Long = 3417

'-----enum Status constants
Public Const cptsMemberAssessStatusPass As Long = 1
Public Const cptsMemberAssessStatusFail As Long = 2

'-----enum CommStatus constants
Public Const cptsMemberAssessCommStatusNo As Long = 1
Public Const cptsMemberAssessCommStatusYes As Long = 2
Public Const cptsMemberAssessCommStatusNone As Long = 3