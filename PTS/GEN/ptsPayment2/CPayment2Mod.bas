Attribute VB_Name = "CPayment2Mod"
Option Explicit
'-----constants
Private Const cModName As String = "CPayment2Mod"

'-----enum item type constants
Public Const cptsPayment2EnumFindType As Long = 1
Public Const cptsPayment2EnumPayType As Long = 16516
Public Const cptsPayment2EnumStatus As Long = 16517
Public Const cptsPayment2EnumCommStatus As Long = 16530
Public Const cptsPayment2EnumCoinStatus As Long = 16532

'-----enum FindType constants
Public Const cptsPayment2FindPayment2ID As Long = 16501
Public Const cptsPayment2FindPayDate As Long = 16515
Public Const cptsPayment2FindPayType As Long = 16516
Public Const cptsPayment2FindTotal As Long = 16518
Public Const cptsPayment2FindReference As Long = 16526

'-----enum PayType constants
Public Const cptsPayment2PayTypeCash As Long = 1
Public Const cptsPayment2PayTypeCredit As Long = 2
Public Const cptsPayment2PayTypeCoin1 As Long = 3
Public Const cptsPayment2PayTypeCoin2 As Long = 4
Public Const cptsPayment2PayTypeCoin3 As Long = 5
Public Const cptsPayment2PayTypeCoin4 As Long = 6
Public Const cptsPayment2PayTypeCoin5 As Long = 7
Public Const cptsPayment2PayTypeCoin6 As Long = 8
Public Const cptsPayment2PayTypeCoin7 As Long = 9
Public Const cptsPayment2PayTypeCoin8 As Long = 10
Public Const cptsPayment2PayTypeCoin9 As Long = 11
Public Const cptsPayment2PayTypeCoin10 As Long = 12

'-----enum Status constants
Public Const cptsPayment2StatusSubmitted As Long = 1
Public Const cptsPayment2StatusPending As Long = 2
Public Const cptsPayment2StatusApproved As Long = 3
Public Const cptsPayment2StatusPartial As Long = 4
Public Const cptsPayment2StatusDeclined As Long = 5
Public Const cptsPayment2StatusReturned As Long = 6
Public Const cptsPayment2StatusCancelled As Long = 7

'-----enum CommStatus constants
Public Const cptsPayment2CommStatusNo As Long = 1
Public Const cptsPayment2CommStatusYes As Long = 2
Public Const cptsPayment2CommStatusNone As Long = 3
Public Const cptsPayment2CommStatusReclaimed As Long = 4

'-----enum CoinStatus constants
Public Const cptsPayment2CoinStatusCoinNotSent As Long = 1
Public Const cptsPayment2CoinStatusCoinSent As Long = 2