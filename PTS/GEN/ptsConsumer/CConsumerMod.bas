Attribute VB_Name = "CConsumerMod"
Option Explicit
'-----constants
Private Const cModName As String = "CConsumerMod"

'-----enum item type constants
Public Const cptsConsumerEnumFindType As Long = 1
Public Const cptsConsumerEnumStatus As Long = 15118
Public Const cptsConsumerEnumMessages As Long = 15119

'-----enum FindType constants
Public Const cptsConsumerFindConsumerName As Long = 15112
Public Const cptsConsumerFindNameFirst As Long = 15111
Public Const cptsConsumerFindEmail As Long = 15113
Public Const cptsConsumerFindPhone As Long = 15115

'-----enum Status constants
Public Const cptsConsumerStatusSetup As Long = 1
Public Const cptsConsumerStatusActive As Long = 2
Public Const cptsConsumerStatusCancelled As Long = 3
Public Const cptsConsumerStatusRemoved As Long = 4

'-----enum Messages constants
Public Const cptsConsumerMessagesmsgAll As Long = 1
Public Const cptsConsumerMessagesmsgNoRewards As Long = 2
Public Const cptsConsumerMessagesmsgNoPromotions As Long = 3
Public Const cptsConsumerMessagesmsgNone As Long = 4