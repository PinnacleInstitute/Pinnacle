Attribute VB_Name = "CSalesMemberMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSalesMemberMod"

'-----enum item type constants
Public Const cptsSalesMemberEnumFindType As Long = 1
Public Const cptsSalesMemberEnumStatus As Long = 16910

'-----enum FindType constants
Public Const cptsSalesMemberFindNameLast As Long = 16906
Public Const cptsSalesMemberFindStatusDate As Long = 16911

'-----enum Status constants
Public Const cptsSalesMemberStatusActive As Long = 1
Public Const cptsSalesMemberStatusInactive As Long = 2