Attribute VB_Name = "CDripCampaignMod"
Option Explicit
'-----constants
Private Const cModName As String = "CDripCampaignMod"

'-----enum item type constants
Public Const cptsDripCampaignEnumTarget As Long = 11412
Public Const cptsDripCampaignEnumStatus As Long = 11413

'-----enum Target constants
Public Const cptsDripCampaignTargetLead As Long = 1
Public Const cptsDripCampaignTargetProspect As Long = 2
Public Const cptsDripCampaignTargetCustomer As Long = 3
Public Const cptsDripCampaignTargetMember As Long = 4

'-----enum Status constants
Public Const cptsDripCampaignStatusPending As Long = 1
Public Const cptsDripCampaignStatusActive As Long = 2
Public Const cptsDripCampaignStatusInActive As Long = 3