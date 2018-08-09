Attribute VB_Name = "CSalesOrderMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSalesOrderMod"

'-----enum item type constants
Public Const cptsSalesOrderEnumFindType As Long = 1
Public Const cptsSalesOrderEnumStatus As Long = 5225
Public Const cptsSalesOrderEnumShip As Long = 5229
Public Const cptsSalesOrderEnumAutoShip As Long = 5236

'-----enum FindType constants
Public Const cptsSalesOrderFindOrderDate As Long = 5221
Public Const cptsSalesOrderFindMemberName As Long = 5212
Public Const cptsSalesOrderFindProspectName As Long = 5213
Public Const cptsSalesOrderFindSalesOrderID As Long = 5201
Public Const cptsSalesOrderFindAffiliateID As Long = 5205
Public Const cptsSalesOrderFindPromotionID As Long = 5206
Public Const cptsSalesOrderFindAmount As Long = 5222
Public Const cptsSalesOrderFindPinnAmount As Long = 5233
Public Const cptsSalesOrderFindCommAmount As Long = 5235
Public Const cptsSalesOrderFindNotes As Long = 5226

'-----enum Status constants
Public Const cptsSalesOrderStatusSubmitted As Long = 1
Public Const cptsSalesOrderStatusInprocess As Long = 2
Public Const cptsSalesOrderStatusComplete As Long = 3
Public Const cptsSalesOrderStatusCancelled As Long = 4
Public Const cptsSalesOrderStatusReturned As Long = 5
Public Const cptsSalesOrderStatusBackorder As Long = 6

'-----enum Ship constants
Public Const cptsSalesOrderShipShip1 As Long = 1
Public Const cptsSalesOrderShipShip2 As Long = 2
Public Const cptsSalesOrderShipShip3 As Long = 3
Public Const cptsSalesOrderShipShip4 As Long = 4
Public Const cptsSalesOrderShipShip5 As Long = 5

'-----enum AutoShip constants
Public Const cptsSalesOrderAutoShipAutoShip1 As Long = 1
Public Const cptsSalesOrderAutoShipAutoShip2 As Long = 2