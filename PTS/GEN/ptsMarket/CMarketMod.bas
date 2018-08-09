Attribute VB_Name = "CMarketMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMarketMod"

'-----enum item type constants
Public Const cptsMarketEnumFindType As Long = 1
Public Const cptsMarketEnumStatus As Long = 18208

'-----enum FindType constants
Public Const cptsMarketFindMarketName As Long = 18205
Public Const cptsMarketFindSendDate As Long = 18211
Public Const cptsMarketFindStatus As Long = 18208
Public Const cptsMarketFindTarget As Long = 18209

'-----enum Status constants
Public Const cptsMarketStatusSetup As Long = 1
Public Const cptsMarketStatusActive As Long = 2
Public Const cptsMarketStatusInactive As Long = 3