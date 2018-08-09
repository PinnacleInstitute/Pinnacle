Attribute VB_Name = "CCoinPriceMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCoinPriceMod"

'-----enum item type constants
Public Const cptsCoinPriceEnumCoin As Long = 16603
Public Const cptsCoinPriceEnumSource As Long = 16604
Public Const cptsCoinPriceEnumStatus As Long = 16608

'-----enum Coin constants
Public Const cptsCoinPriceCoinCoin1 As Long = 1
Public Const cptsCoinPriceCoinCoin2 As Long = 2
Public Const cptsCoinPriceCoinCoin3 As Long = 3
Public Const cptsCoinPriceCoinCoin4 As Long = 4
Public Const cptsCoinPriceCoinCoin5 As Long = 5
Public Const cptsCoinPriceCoinCoin6 As Long = 6
Public Const cptsCoinPriceCoinCoin7 As Long = 7
Public Const cptsCoinPriceCoinCoin8 As Long = 8
Public Const cptsCoinPriceCoinCoin9 As Long = 9
Public Const cptsCoinPriceCoinCoin10 As Long = 10

'-----enum Source constants
Public Const cptsCoinPriceSourceSource1 As Long = 1
Public Const cptsCoinPriceSourceSource2 As Long = 2
Public Const cptsCoinPriceSourceSource3 As Long = 3
Public Const cptsCoinPriceSourceSource4 As Long = 4
Public Const cptsCoinPriceSourceSource5 As Long = 5
Public Const cptsCoinPriceSourceSource6 As Long = 6
Public Const cptsCoinPriceSourceSource7 As Long = 7
Public Const cptsCoinPriceSourceSource8 As Long = 8
Public Const cptsCoinPriceSourceSource9 As Long = 9
Public Const cptsCoinPriceSourceSource10 As Long = 10

'-----enum Status constants
Public Const cptsCoinPriceStatusDefault As Long = 1
Public Const cptsCoinPriceStatusActive As Long = 2
Public Const cptsCoinPriceStatusInactive As Long = 3