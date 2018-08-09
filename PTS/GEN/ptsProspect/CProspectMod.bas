Attribute VB_Name = "CProspectMod"
Option Explicit
'-----constants
Private Const cModName As String = "CProspectMod"

'-----enum item type constants
Public Const cptsProspectEnumFindType As Long = 1
Public Const cptsProspectEnumNextEvent As Long = 8141
Public Const cptsProspectEnumEmailStatus As Long = 8164
Public Const cptsProspectEnumReminder As Long = 8177
Public Const cptsProspectEnumTimeZone As Long = 8179
Public Const cptsProspectEnumBestTime As Long = 8180

'-----enum FindType constants
Public Const cptsProspectFindProspectName As Long = 8120
Public Const cptsProspectFindContactName As Long = 8127
Public Const cptsProspectFindCreateDate As Long = 8145
Public Const cptsProspectFindPriority As Long = 8173
Public Const cptsProspectFindSource As Long = 8175
Public Const cptsProspectFindRepresenting As Long = 8123
Public Const cptsProspectFindProspectID As Long = 8101
Public Const cptsProspectFindEmail As Long = 8129
Public Const cptsProspectFindPhone1 As Long = 8130
Public Const cptsProspectFindLeadCampaignID As Long = 8105
Public Const cptsProspectFindSalesCampaignID As Long = 8104
Public Const cptsProspectFindDescription As Long = 8122

'-----enum NextEvent constants
Public Const cptsProspectNextEventEvent1 As Long = 1
Public Const cptsProspectNextEventEvent2 As Long = 2
Public Const cptsProspectNextEventEvent3 As Long = 3
Public Const cptsProspectNextEventEvent4 As Long = 4
Public Const cptsProspectNextEventEvent5 As Long = 5
Public Const cptsProspectNextEventEvent6 As Long = 6

'-----enum EmailStatus constants
Public Const cptsProspectEmailStatusPending As Long = 1
Public Const cptsProspectEmailStatusActive As Long = 2
Public Const cptsProspectEmailStatusUnsubscribe As Long = 3

'-----enum Reminder constants
Public Const cptsProspectReminder30m As Long = 5
Public Const cptsProspectReminder1h As Long = 6
Public Const cptsProspectReminder2h As Long = 7
Public Const cptsProspectReminder3h As Long = 8
Public Const cptsProspectReminder4h As Long = 9
Public Const cptsProspectReminder5h As Long = 10
Public Const cptsProspectReminder6h As Long = 11
Public Const cptsProspectReminder7h As Long = 12
Public Const cptsProspectReminder8h As Long = 13
Public Const cptsProspectReminder9h As Long = 14
Public Const cptsProspectReminder10h As Long = 15
Public Const cptsProspectReminder11h As Long = 16
Public Const cptsProspectReminder12h As Long = 17
Public Const cptsProspectReminder18h As Long = 18
Public Const cptsProspectReminder1d As Long = 19
Public Const cptsProspectReminder2d As Long = 20
Public Const cptsProspectReminder3d As Long = 21
Public Const cptsProspectReminder4d As Long = 22
Public Const cptsProspectReminder1w As Long = 23
Public Const cptsProspectReminder2w As Long = 24
Public Const cptsProspectReminderCustom As Long = 99

'-----enum TimeZone constants
Public Const cptsProspectTimeZoneGMTm12 As Long = -12
Public Const cptsProspectTimeZoneGMTm11 As Long = -11
Public Const cptsProspectTimeZoneGMTm10 As Long = -10
Public Const cptsProspectTimeZoneGMTm9 As Long = -9
Public Const cptsProspectTimeZoneGMTm8 As Long = -8
Public Const cptsProspectTimeZoneGMTm7 As Long = -7
Public Const cptsProspectTimeZoneGMTm6 As Long = -6
Public Const cptsProspectTimeZoneGMTm5 As Long = -5
Public Const cptsProspectTimeZoneGMTm4 As Long = -4
Public Const cptsProspectTimeZoneGMTm3 As Long = -3
Public Const cptsProspectTimeZoneGMTm2 As Long = -2
Public Const cptsProspectTimeZoneGMTm1 As Long = -1
Public Const cptsProspectTimeZoneGMT As Long = 0
Public Const cptsProspectTimeZoneGMTp1 As Long = 1
Public Const cptsProspectTimeZoneGMTp2 As Long = 2
Public Const cptsProspectTimeZoneGMTp3 As Long = 3
Public Const cptsProspectTimeZoneGMTp4 As Long = 4
Public Const cptsProspectTimeZoneGMTp5 As Long = 5
Public Const cptsProspectTimeZoneGMTp6 As Long = 6
Public Const cptsProspectTimeZoneGMTp7 As Long = 7
Public Const cptsProspectTimeZoneGMTp8 As Long = 8
Public Const cptsProspectTimeZoneGMTp9 As Long = 9
Public Const cptsProspectTimeZoneGMTp10 As Long = 10
Public Const cptsProspectTimeZoneGMTp11 As Long = 11
Public Const cptsProspectTimeZoneGMTp12 As Long = 12

'-----enum BestTime constants
Public Const cptsProspectBestTimeMorning As Long = 1
Public Const cptsProspectBestTimeAfternoon As Long = 2
Public Const cptsProspectBestTimeEvening As Long = 3
Public Const cptsProspectBestTimeWeekend As Long = 4