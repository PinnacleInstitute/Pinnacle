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
Public Const cptsAuthUserUserTypeTrainer As Long = 30
Public Const cptsAuthUserUserTypeMember As Long = 40
Public Const cptsAuthUserUserTypeOrg As Long = 50
Public Const cptsAuthUserUserTypeAffiliate As Long = 60

'-----enum UserGroup constants
Public Const cptsAuthUserUserGroupSysAdmin As Long = 1
Public Const cptsAuthUserUserGroupManager As Long = 21
Public Const cptsAuthUserUserGroupAdministrator As Long = 22
Public Const cptsAuthUserUserGroupEmployee As Long = 23
Public Const cptsAuthUserUserGroupTrainer As Long = 31
Public Const cptsAuthUserUserGroupMember As Long = 41
Public Const cptsAuthUserUserGroupOrg As Long = 51
Public Const cptsAuthUserUserGroupAffiliate As Long = 61

'-----enum UserStatus constants
Public Const cptsAuthUserUserStatusActive As Long = 1
Public Const cptsAuthUserUserStatusInActive As Long = 2
Public Const cptsAuthUserUserStatusReadOnly As Long = 3

