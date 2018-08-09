Attribute VB_Name = "CPageMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPageMod"

'-----enum item type constants
Public Const cptsPageEnumFindType As Long = 1
Public Const cptsPageEnumStatus As Long = 9308
Public Const cptsPageEnumForm As Long = 9311

'-----enum FindType constants
Public Const cptsPageFindPageName As Long = 9305
Public Const cptsPageFindCategory As Long = 9306
Public Const cptsPageFindPageID As Long = 9301
Public Const cptsPageFindLanguage As Long = 9309

'-----enum Status constants
Public Const cptsPageStatusActive As Long = 1
Public Const cptsPageStatusInActive As Long = 2

'-----enum Form constants
Public Const cptsPageFormMember As Long = 1
Public Const cptsPageFormProspect As Long = 2