Attribute VB_Name = "CMerchantMod"
Option Explicit
'-----constants
Private Const cModName As String = "CMerchantMod"

'-----enum item type constants
Public Const cptsMerchantEnumFindType As Long = 1
Public Const cptsMerchantEnumStatus As Long = 15023

'-----enum FindType constants
Public Const cptsMerchantFindMerchantName As Long = 15011
Public Const cptsMerchantFindMerchantID As Long = 15001
Public Const cptsMerchantFindNameLast As Long = 15012
Public Const cptsMerchantFindNameFirst As Long = 15013
Public Const cptsMerchantFindEmail As Long = 15014
Public Const cptsMerchantFindZip As Long = 15028
Public Const cptsMerchantFindCity As Long = 15026
Public Const cptsMerchantFindState As Long = 15027
Public Const cptsMerchantFindMemberID As Long = 15002

'-----enum Status constants
Public Const cptsMerchantStatusPrelaunch As Long = 1
Public Const cptsMerchantStatusSetup As Long = 2
Public Const cptsMerchantStatusActive As Long = 3
Public Const cptsMerchantStatusCancelled As Long = 4
Public Const cptsMerchantStatusRemoved As Long = 5
Public Const cptsMerchantStatusDemo As Long = 6