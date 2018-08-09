Attribute VB_Name = "CBarterCampaignMod"
Option Explicit
'-----constants
Private Const cModName As String = "CBarterCampaignMod"

'-----enum item type constants
Public Const cptsBarterCampaignEnumFindType As Long = 1
Public Const cptsBarterCampaignEnumStatus As Long = 17511

'-----enum FindType constants
Public Const cptsBarterCampaignFindCampaignName As Long = 17510
Public Const cptsBarterCampaignFindStartDate As Long = 17512

'-----enum Status constants
Public Const cptsBarterCampaignStatusPending As Long = 1
Public Const cptsBarterCampaignStatusActive As Long = 2
Public Const cptsBarterCampaignStatusExpired As Long = 3
Public Const cptsBarterCampaignStatusCancelled As Long = 4