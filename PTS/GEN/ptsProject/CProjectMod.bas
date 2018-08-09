Attribute VB_Name = "CProjectMod"
Option Explicit
'-----constants
Private Const cModName As String = "CProjectMod"

'-----enum item type constants
Public Const cptsProjectEnumFindType As Long = 1
Public Const cptsProjectEnumStatus As Long = 7522
Public Const cptsProjectEnumRefType As Long = 7544

'-----enum FindType constants
Public Const cptsProjectFindProjectName As Long = 7520
Public Const cptsProjectFindDescription As Long = 7521
Public Const cptsProjectFindProjectID As Long = 7501

'-----enum Status constants
Public Const cptsProjectStatusStarted As Long = 1
Public Const cptsProjectStatusCompleted As Long = 2
Public Const cptsProjectStatusCancelled As Long = 3

'-----enum RefType constants
Public Const cptsProjectRefTypeCustomer As Long = 81