Attribute VB_Name = "CAuthUserMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAuthUserMod"

'-----enum item type constants
Public Const cptsAuthUserEnumUserType As Long = 115
Public Const cptsAuthUserEnumUserGroup As Long = 116
Public Const cptsAuthUserEnumUserStatus As Long = 117

'-----enum UserType constants
Public Const cptsAuthUserUserTypeSysAdmin As Long = 10
Public Const cptsAuthUserUserTypeEmployee As Long = 20
Public Const cptsAuthUserUserTypeCustomer As Long = 30
Public Const cptsAuthUserUserTypeAffiliate As Long = 40

'-----enum UserGroup constants
Public Const cptsAuthUserUserGroupSysAdmin As Long = 1
Public Const cptsAuthUserUserGroupManager As Long = 21
Public Const cptsAuthUserUserGroupAdministrator As Long = 22
Public Const cptsAuthUserUserGroupEmployee As Long = 23
Public Const cptsAuthUserUserGroupCustomer As Long = 31
Public Const cptsAuthUserUserGroupAffiliate As Long = 41

'-----enum UserStatus constants
Public Const cptsAuthUserUserStatusActive As Long = 1
Public Const cptsAuthUserUserStatusInActive As Long = 2
Public Const cptsAuthUserUserStatusReadOnly As Long = 3

