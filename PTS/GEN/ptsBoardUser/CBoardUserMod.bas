Attribute VB_Name = "CBoardUserMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBoardUserMod"

'-----enum item type constants
Public Const cptsBoardUserEnumFindType As Long = 1
Public Const cptsBoardUserEnumBoardUserGroup As Long = 8313

'-----enum FindType constants
Public Const cptsBoardUserFindBoardUserGroup As Long = 8313
Public Const cptsBoardUserFindBoardUserName As Long = 8312

'-----enum BoardUserGroup constants
Public Const cptsBoardUserBoardUserGroupUser As Long = 1
Public Const cptsBoardUserBoardUserGroupModerator As Long = 2
Public Const cptsBoardUserBoardUserGroupAdmin As Long = 3