Attribute VB_Name = "CSalesItemMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSalesItemMod"

'-----enum item type constants
Public Const cptsSalesItemEnumFindType As Long = 1
Public Const cptsSalesItemEnumStatus As Long = 5317
Public Const cptsSalesItemEnumLocks As Long = 5320

'-----enum FindType constants
Public Const cptsSalesItemFindOrderDate As Long = 5306
Public Const cptsSalesItemFindProductName As Long = 5307
Public Const cptsSalesItemFindStatus As Long = 5317

'-----enum Status constants
Public Const cptsSalesItemStatusSubmitted As Long = 1
Public Const cptsSalesItemStatusInprocess As Long = 2
Public Const cptsSalesItemStatusComplete As Long = 3
Public Const cptsSalesItemStatusCancelled As Long = 4
Public Const cptsSalesItemStatusReturned As Long = 5
Public Const cptsSalesItemStatusBackorder As Long = 6

'-----enum Locks constants
Public Const cptsSalesItemLocksNoEdit As Long = 1
Public Const cptsSalesItemLocksNoDelete As Long = 2