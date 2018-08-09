Attribute VB_Name = "CBinarySaleMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBinarySaleMod"

'-----enum item type constants
Public Const cptsBinarySaleEnumFindType As Long = 1
Public Const cptsBinarySaleEnumSaleType As Long = 10605

'-----enum FindType constants
Public Const cptsBinarySaleFindSaleDate As Long = 10604
Public Const cptsBinarySaleFindSaleType As Long = 10605

'-----enum SaleType constants
Public Const cptsBinarySaleSaleTypeSale As Long = 1
Public Const cptsBinarySaleSaleTypeBonus As Long = 2
Public Const cptsBinarySaleSaleTypeRefund As Long = 3
Public Const cptsBinarySaleSaleTypeExpired As Long = 4