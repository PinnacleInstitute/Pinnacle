Attribute VB_Name = "CEmployeeMod"
Option Explicit
'-----constants
Private Const cModName As String = "CEmployeeMod"

'-----enum item type constants
Public Const cptsEmployeeEnumFindType As Long = 1
Public Const cptsEmployeeEnumUserGroup As Long = 0204
Public Const cptsEmployeeEnumUserStatus As Long = 0205
Public Const cptsEmployeeEnumStatus As Long = 0223

'-----enum FindType constants
Public Const cptsEmployeeFindEmail As Long = 0213
Public Const cptsEmployeeFindEmployeeName As Long = 0212

'-----enum UserGroup constants
Public Const cptsEmployeeUserGroupManager As Long = 21
Public Const cptsEmployeeUserGroupAdmin As Long = 22
Public Const cptsEmployeeUserGroupClerk As Long = 23
Public Const cptsEmployeeUserGroupTranslator As Long = 24

'-----enum UserStatus constants
Public Const cptsEmployeeUserStatusActive As Long = 1
Public Const cptsEmployeeUserStatusInActive As Long = 2
Public Const cptsEmployeeUserStatusReadOnly As Long = 3

'-----enum Status constants
Public Const cptsEmployeeStatusFulltime As Long = 1
Public Const cptsEmployeeStatusParttime As Long = 2
Public Const cptsEmployeeStatusContractor As Long = 3