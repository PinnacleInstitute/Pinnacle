Attribute VB_Name = "CCoinMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCoinMod"

'-----enum item type constants
Public Const cptsCoinEnumFindType As Long = 1
Public Const cptsCoinEnumStatus As Long = 15712
Public Const cptsCoinEnumCoinType As Long = 15713

'-----enum FindType constants
Public Const cptsCoinFindCoinDate As Long = 15710
Public Const cptsCoinFindCoinID As Long = 15701
Public Const cptsCoinFindAmount As Long = 15711
Public Const cptsCoinFindStatus As Long = 15712
Public Const cptsCoinFindCoinType As Long = 15713
Public Const cptsCoinFindReference As Long = 15714

'-----enum Status constants
Public Const cptsCoinStatusSubmitted As Long = 1
Public Const cptsCoinStatusPending As Long = 2
Public Const cptsCoinStatusComplete As Long = 3
Public Const cptsCoinStatusRequest As Long = 4
Public Const cptsCoinStatusCancelled As Long = 5

'-----enum CoinType constants
Public Const cptsCoinCoinTypeMined As Long = 1
Public Const cptsCoinCoinTypeSent As Long = 2
Public Const cptsCoinCoinTypeReceived As Long = 3