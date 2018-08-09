Attribute VB_Name = "CLeadMod"
Option Explicit
'-----constants
Private Const cModName As String = "CLeadMod"

'-----enum item type constants
Public Const cptsLeadEnumFindType As Long = 1
Public Const cptsLeadEnumStatus As Long = 2225
Public Const cptsLeadEnumTimeZone As Long = 2229
Public Const cptsLeadEnumBestTime As Long = 2230

'-----enum FindType constants
Public Const cptsLeadFindLeadName As Long = 2212
Public Const cptsLeadFindPriority As Long = 2226
Public Const cptsLeadFindLeadDate As Long = 2213
Public Const cptsLeadFindCallBackDate As Long = 2227
Public Const cptsLeadFindSalesCampaignName As Long = 2205
Public Const cptsLeadFindProspectTypeName As Long = 2206
Public Const cptsLeadFindEmail As Long = 2214
Public Const cptsLeadFindPhone1 As Long = 2215
Public Const cptsLeadFindPhone2 As Long = 2216
Public Const cptsLeadFindSource As Long = 2224

'-----enum Status constants
Public Const cptsLeadStatusNew As Long = 0
Public Const cptsLeadStatusContact1 As Long = 1
Public Const cptsLeadStatusContact2 As Long = 2
Public Const cptsLeadStatusContact3 As Long = 3
Public Const cptsLeadStatusNoContact As Long = 4
Public Const cptsLeadStatusCallBack As Long = 5
Public Const cptsLeadStatusDead As Long = 6

'-----enum TimeZone constants
Public Const cptsLeadTimeZoneGMTm12 As Long = -12
Public Const cptsLeadTimeZoneGMTm11 As Long = -11
Public Const cptsLeadTimeZoneGMTm10 As Long = -10
Public Const cptsLeadTimeZoneGMTm9 As Long = -9
Public Const cptsLeadTimeZoneGMTm8 As Long = -8
Public Const cptsLeadTimeZoneGMTm7 As Long = -7
Public Const cptsLeadTimeZoneGMTm6 As Long = -6
Public Const cptsLeadTimeZoneGMTm5 As Long = -5
Public Const cptsLeadTimeZoneGMTm4 As Long = -4
Public Const cptsLeadTimeZoneGMTm3 As Long = -3
Public Const cptsLeadTimeZoneGMTm2 As Long = -2
Public Const cptsLeadTimeZoneGMTm1 As Long = -1
Public Const cptsLeadTimeZoneGMT As Long = 0
Public Const cptsLeadTimeZoneGMTp1 As Long = 1
Public Const cptsLeadTimeZoneGMTp2 As Long = 2
Public Const cptsLeadTimeZoneGMTp3 As Long = 3
Public Const cptsLeadTimeZoneGMTp4 As Long = 4
Public Const cptsLeadTimeZoneGMTp5 As Long = 5
Public Const cptsLeadTimeZoneGMTp6 As Long = 6
Public Const cptsLeadTimeZoneGMTp7 As Long = 7
Public Const cptsLeadTimeZoneGMTp8 As Long = 8
Public Const cptsLeadTimeZoneGMTp9 As Long = 9
Public Const cptsLeadTimeZoneGMTp10 As Long = 10
Public Const cptsLeadTimeZoneGMTp11 As Long = 11
Public Const cptsLeadTimeZoneGMTp12 As Long = 12

'-----enum BestTime constants
Public Const cptsLeadBestTimeMorning As Long = 1
Public Const cptsLeadBestTimeAfternoon As Long = 2
Public Const cptsLeadBestTimeEvening As Long = 3
Public Const cptsLeadBestTimeWeekend As Long = 4