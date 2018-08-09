Attribute VB_Name = "COrgMod"
Option Explicit
'-----constants
Private Const cModName As String = "COrgMod"

'-----enum item type constants
Public Const cptsOrgEnumUserGroup As Long = 2810
Public Const cptsOrgEnumUserStatus As Long = 2811
Public Const cptsOrgEnumStatus As Long = 2817

'-----enum UserGroup constants
Public Const cptsOrgUserGroupOrgAdmin As Long = 51
Public Const cptsOrgUserGroupOrgManager As Long = 52

'-----enum UserStatus constants
Public Const cptsOrgUserStatusActive As Long = 1
Public Const cptsOrgUserStatusInActive As Long = 2
Public Const cptsOrgUserStatusReadOnly As Long = 3

'-----enum Status constants
Public Const cptsOrgStatusSetup As Long = 1
Public Const cptsOrgStatusActive As Long = 2
Public Const cptsOrgStatusDemo As Long = 3
Public Const cptsOrgStatusInactive As Long = 4