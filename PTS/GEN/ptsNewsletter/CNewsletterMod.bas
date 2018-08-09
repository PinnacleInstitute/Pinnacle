Attribute VB_Name = "CNewsLetterMod"
Option Explicit
'-----constants
Private Const cModName As String = "CNewsLetterMod"

'-----enum item type constants
Public Const cptsNewsLetterEnumFindType As Long = 1
Public Const cptsNewsLetterEnumStatus As Long = 1811

'-----enum FindType constants
Public Const cptsNewsLetterFindNewsLetterName As Long = 1810
Public Const cptsNewsLetterFindDescription As Long = 1812
Public Const cptsNewsLetterFindMemberID As Long = 1803

'-----enum Status constants
Public Const cptsNewsLetterStatusCompose As Long = 1
Public Const cptsNewsLetterStatusActive As Long = 2
Public Const cptsNewsLetterStatusCancelled As Long = 3