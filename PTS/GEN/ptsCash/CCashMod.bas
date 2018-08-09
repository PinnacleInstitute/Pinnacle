Attribute VB_Name = "CCashMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCashMod"

'-----enum item type constants
Public Const cptsCashEnumFindType As Long = 1
Public Const cptsCashEnumCashType As Long = 11206

'-----enum FindType constants
Public Const cptsCashFindCashDate As Long = 11205

'-----enum CashType constants
Public Const cptsCashCashTypeCAB As Long = 1
Public Const cptsCashCashTypeBonus As Long = 2
Public Const cptsCashCashTypePrepaid As Long = 3
Public Const cptsCashCashTypePayout As Long = 4