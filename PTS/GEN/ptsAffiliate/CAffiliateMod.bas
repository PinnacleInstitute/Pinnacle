Attribute VB_Name = "CAffiliateMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAffiliateMod"

'-----enum item type constants
Public Const cptsAffiliateEnumFindType As Long = 1
Public Const cptsAffiliateEnumUserGroup As Long = 0610
Public Const cptsAffiliateEnumUserStatus As Long = 0611
Public Const cptsAffiliateEnumStatus As Long = 0630

'-----enum FindType constants
Public Const cptsAffiliateFindAffiliateName As Long = 0615
Public Const cptsAffiliateFindContactName As Long = 0618
Public Const cptsAffiliateFindAffiliateID As Long = 0601
Public Const cptsAffiliateFindEmail As Long = 0625

'-----enum UserGroup constants
Public Const cptsAffiliateUserGroupAuthUser As Long = 61

'-----enum UserStatus constants
Public Const cptsAffiliateUserStatusActive As Long = 1
Public Const cptsAffiliateUserStatusInActive As Long = 2
Public Const cptsAffiliateUserStatusReadOnly As Long = 3

'-----enum Status constants
Public Const cptsAffiliateStatusPending As Long = 1
Public Const cptsAffiliateStatusActive As Long = 2
Public Const cptsAffiliateStatusInActive As Long = 3
Public Const cptsAffiliateStatusCancelled As Long = 4
Public Const cptsAffiliateStatusTerminated As Long = 5