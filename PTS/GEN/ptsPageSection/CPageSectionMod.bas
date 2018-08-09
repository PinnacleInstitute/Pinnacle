Attribute VB_Name = "CPageSectionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPageSectionMod"

'-----enum item type constants
Public Const cptsPageSectionEnumFindType As Long = 1
Public Const cptsPageSectionEnumCustom As Long = 9110

'-----enum FindType constants
Public Const cptsPageSectionFindPageSectionName As Long = 9105
Public Const cptsPageSectionFindFileName As Long = 9106
Public Const cptsPageSectionFindLanguage As Long = 9108

'-----enum Custom constants
Public Const cptsPageSectionCustomStandard As Long = 1
Public Const cptsPageSectionCustomWide As Long = 2
Public Const cptsPageSectionCustomFull As Long = 3