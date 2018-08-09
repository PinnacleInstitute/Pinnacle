Attribute VB_Name = "CQuestionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CQuestionMod"

'-----enum item type constants
Public Const cptsQuestionEnumFindType As Long = 1
Public Const cptsQuestionEnumStatus As Long = 1711

'-----enum FindType constants
Public Const cptsQuestionFindQuestion As Long = 1707
Public Const cptsQuestionFindQuestionTypeName As Long = 1704
Public Const cptsQuestionFindReference As Long = 1709
Public Const cptsQuestionFindQuestionDate As Long = 1706

'-----enum Status constants
Public Const cptsQuestionStatusPending As Long = 1
Public Const cptsQuestionStatusActive As Long = 2
Public Const cptsQuestionStatusInActive As Long = 3