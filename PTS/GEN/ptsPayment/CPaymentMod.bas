Attribute VB_Name = "CPaymentMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPaymentMod"

'-----enum item type constants
Public Const cptsPaymentEnumFindType As Long = 1
Public Const cptsPaymentEnumPayType As Long = 1010
Public Const cptsPaymentEnumStatus As Long = 1018
Public Const cptsPaymentEnumCommStatus As Long = 1021

'-----enum FindType constants
Public Const cptsPaymentFindPaymentID As Long = 1001
Public Const cptsPaymentFindReference As Long = 1019
Public Const cptsPaymentFindPayDate As Long = 1008
Public Const cptsPaymentFindPayType As Long = 1010
Public Const cptsPaymentFindAmount As Long = 1011
Public Const cptsPaymentFindDescription As Long = 1016

'-----enum PayType constants
Public Const cptsPaymentPayTypeVisa As Long = 1
Public Const cptsPaymentPayTypeMasterCard As Long = 2
Public Const cptsPaymentPayTypeDiscover As Long = 3
Public Const cptsPaymentPayTypeAmex As Long = 4
Public Const cptsPaymentPayTypeCheck As Long = 5
Public Const cptsPaymentPayTypePayPal As Long = 6
Public Const cptsPaymentPayTypeCash As Long = 7
Public Const cptsPaymentPayTypePO As Long = 8
Public Const cptsPaymentPayTypeWallet As Long = 10
Public Const cptsPaymentPayTypeiPayout As Long = 11
Public Const cptsPaymentPayTypePayQuicker As Long = 12
Public Const cptsPaymentPayTypeSolidTrust As Long = 13
Public Const cptsPaymentPayTypeBitCoin As Long = 14
Public Const cptsPaymentPayTypeBitCoinCash As Long = 15
Public Const cptsPaymentPayTypeGCR As Long = 20
Public Const cptsPaymentPayTypeNTX As Long = 21
Public Const cptsPaymentPayTypeCoin1 As Long = 22
Public Const cptsPaymentPayTypeCoin2 As Long = 23
Public Const cptsPaymentPayTypeCoin3 As Long = 24
Public Const cptsPaymentPayTypeCoin4 As Long = 25
Public Const cptsPaymentPayTypeCoin5 As Long = 26
Public Const cptsPaymentPayTypeCoin6 As Long = 27
Public Const cptsPaymentPayTypeCoin7 As Long = 28
Public Const cptsPaymentPayTypeCoin8 As Long = 29
Public Const cptsPaymentPayTypeCoin9 As Long = 30
Public Const cptsPaymentPayTypeCoin10 As Long = 31
Public Const cptsPaymentPayTypeCommission As Long = 90
Public Const cptsPaymentPayTypeCredit As Long = 91
Public Const cptsPaymentPayTypeMiscPay1 As Long = 97
Public Const cptsPaymentPayTypeMiscPay2 As Long = 98
Public Const cptsPaymentPayTypeMiscPay3 As Long = 99

'-----enum Status constants
Public Const cptsPaymentStatusSubmitted As Long = 1
Public Const cptsPaymentStatusPending As Long = 2
Public Const cptsPaymentStatusApproved As Long = 3
Public Const cptsPaymentStatusDeclined As Long = 4
Public Const cptsPaymentStatusReturned As Long = 5
Public Const cptsPaymentStatusCancelled As Long = 6
Public Const cptsPaymentStatusPartial As Long = 7

'-----enum CommStatus constants
Public Const cptsPaymentCommStatusNo As Long = 1
Public Const cptsPaymentCommStatusYes As Long = 2
Public Const cptsPaymentCommStatusNone As Long = 3
Public Const cptsPaymentCommStatusReclaimed As Long = 4