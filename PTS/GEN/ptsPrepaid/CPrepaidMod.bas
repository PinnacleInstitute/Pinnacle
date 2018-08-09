Attribute VB_Name = "CPrepaidMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPrepaidMod"

'-----enum item type constants
Public Const cptsPrepaidEnumFindType As Long = 1
Public Const cptsPrepaidEnumPayType As Long = 11106
Public Const cptsPrepaidEnumBonus As Long = 11110

'-----enum FindType constants
Public Const cptsPrepaidFindPayDate As Long = 11105

'-----enum PayType constants
Public Const cptsPrepaidPayTypeCredit As Long = 1
Public Const cptsPrepaidPayTypeDebit As Long = 2

'-----enum Bonus constants
Public Const cptsPrepaidBonusNo As Long = 1
Public Const cptsPrepaidBonusYes As Long = 2
Public Const cptsPrepaidBonusNone As Long = 3
Public Const cptsPrepaidBonusReclaimed As Long = 4