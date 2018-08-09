Attribute VB_Name = "CPayoutMod"
Option Explicit
'-----constants
Private Const cModName As String = "CPayoutMod"

'-----enum item type constants
Public Const cptsPayoutEnumFindType As Long = 1
Public Const cptsPayoutEnumStatus As Long = 0813
Public Const cptsPayoutEnumPayType As Long = 0815

'-----enum FindType constants
Public Const cptsPayoutFindPayDate As Long = 0810
Public Const cptsPayoutFindPaidDate As Long = 0811
Public Const cptsPayoutFindPayoutID As Long = 0801
Public Const cptsPayoutFindAmount As Long = 0812
Public Const cptsPayoutFindOwnerID As Long = 0804

'-----enum Status constants
Public Const cptsPayoutStatusSubmitted As Long = 1
Public Const cptsPayoutStatusPaid As Long = 2
Public Const cptsPayoutStatusForce As Long = 3
Public Const cptsPayoutStatusPending As Long = 4
Public Const cptsPayoutStatusRequest As Long = 5
Public Const cptsPayoutStatusCancelled As Long = 6
Public Const cptsPayoutStatusLoaded As Long = 7

'-----enum PayType constants
Public Const cptsPayoutPayTypeCard As Long = 1
Public Const cptsPayoutPayTypeeCheck As Long = 2
Public Const cptsPayoutPayTypeeWallet As Long = 6
Public Const cptsPayoutPayTypeCheck As Long = 3
Public Const cptsPayoutPayTypeCredit As Long = 4
Public Const cptsPayoutPayTypeDebit As Long = 5
Public Const cptsPayoutPayTypeiPayout As Long = 11
Public Const cptsPayoutPayTypePayQuicker As Long = 12
Public Const cptsPayoutPayTypeSolidTrust As Long = 13
Public Const cptsPayoutPayTypeBitCoin As Long = 14
Public Const cptsPayoutPayTypeBitCoinCash As Long = 15
Public Const cptsPayoutPayTypePayType16 As Long = 16
Public Const cptsPayoutPayTypePayType17 As Long = 17
Public Const cptsPayoutPayTypePayType18 As Long = 18
Public Const cptsPayoutPayTypePayment As Long = 90
Public Const cptsPayoutPayTypeBonuses As Long = 91
Public Const cptsPayoutPayTypeTransfer As Long = 92