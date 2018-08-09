Attribute VB_Name = "CRewardMod"
Option Explicit
'-----constants
Private Const cModName As String = "CRewardMod"

'-----enum item type constants
Public Const cptsRewardEnumFindType As Long = 1
Public Const cptsRewardEnumRewardType As Long = 15212
Public Const cptsRewardEnumStatus As Long = 15215

'-----enum FindType constants
Public Const cptsRewardFindRewardDate As Long = 15211
Public Const cptsRewardFindMerchantID As Long = 15202
Public Const cptsRewardFindConsumerID As Long = 15203

'-----enum RewardType constants
Public Const cptsRewardRewardTypeCash As Long = 1
Public Const cptsRewardRewardTypePoints As Long = 2

'-----enum Status constants
Public Const cptsRewardStatusSubmitted As Long = 1
Public Const cptsRewardStatusPending As Long = 2
Public Const cptsRewardStatusApproved As Long = 3
Public Const cptsRewardStatusHold As Long = 4