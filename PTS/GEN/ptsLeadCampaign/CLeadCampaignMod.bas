Attribute VB_Name = "CLeadCampaignMod"
Option Explicit
'-----constants
Private Const cModName As String = "CLeadCampaignMod"

'-----enum item type constants
Public Const cptsLeadCampaignEnumFindType As Long = 1
Public Const cptsLeadCampaignEnumStatus As Long = 1411
Public Const cptsLeadCampaignEnumPageType As Long = 1412
Public Const cptsLeadCampaignEnumEntity As Long = 1424

'-----enum FindType constants
Public Const cptsLeadCampaignFindSeq As Long = 1425
Public Const cptsLeadCampaignFindLeadCampaignName As Long = 1410
Public Const cptsLeadCampaignFindLeadCampaignID As Long = 1401
Public Const cptsLeadCampaignFindObjective As Long = 1413
Public Const cptsLeadCampaignFindStatus As Long = 1411
Public Const cptsLeadCampaignFindGroupID As Long = 1407

'-----enum Status constants
Public Const cptsLeadCampaignStatusPending As Long = 1
Public Const cptsLeadCampaignStatusActive As Long = 2
Public Const cptsLeadCampaignStatusInActive As Long = 3

'-----enum PageType constants
Public Const cptsLeadCampaignPageTypeLead As Long = 1
Public Const cptsLeadCampaignPageTypePresent As Long = 2

'-----enum Entity constants
Public Const cptsLeadCampaignEntityContact As Long = 22
Public Const cptsLeadCampaignEntityProspect As Long = 81