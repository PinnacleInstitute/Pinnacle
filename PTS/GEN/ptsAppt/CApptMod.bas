Attribute VB_Name = "CApptMod"
Option Explicit
'-----constants
Private Const cModName As String = "CApptMod"

'-----enum item type constants
Public Const cptsApptEnumStatus As Long = 4813
Public Const cptsApptEnumApptType As Long = 4814
Public Const cptsApptEnumImportance As Long = 4815
Public Const cptsApptEnumShow As Long = 4816
Public Const cptsApptEnumReminder As Long = 4817
Public Const cptsApptEnumRecur As Long = 4819

'-----enum Status constants
Public Const cptsApptStatusActive As Long = 1
Public Const cptsApptStatusInactive As Long = 2
Public Const cptsApptStatusPending As Long = 3

'-----enum ApptType constants
Public Const cptsApptApptTypeAppt As Long = 1
Public Const cptsApptApptTypePhone As Long = 2
Public Const cptsApptApptTypeMeeting As Long = 3
Public Const cptsApptApptTypeSeminar As Long = 4
Public Const cptsApptApptTypeTradeShow As Long = 5
Public Const cptsApptApptTypeMeal As Long = 6
Public Const cptsApptApptTypeParty As Long = 7
Public Const cptsApptApptTypeBirthday As Long = 8
Public Const cptsApptApptTypeAnniversary As Long = 9
Public Const cptsApptApptTypePersonal As Long = 10
Public Const cptsApptApptTypeFamily As Long = 11
Public Const cptsApptApptTypeSports As Long = 12
Public Const cptsApptApptTypeEducation As Long = 13
Public Const cptsApptApptTypeEntertainment As Long = 14
Public Const cptsApptApptTypeVacation As Long = 15
Public Const cptsApptApptTypeMedical As Long = 16

'-----enum Importance constants
Public Const cptsApptImportanceLow As Long = 1
Public Const cptsApptImportanceNormal As Long = 2
Public Const cptsApptImportanceHigh As Long = 3

'-----enum Show constants
Public Const cptsApptShowNormal As Long = 1
Public Const cptsApptShowPrivate As Long = 2
Public Const cptsApptShowBusy As Long = 3

'-----enum Reminder constants
Public Const cptsApptReminder30m As Long = 5
Public Const cptsApptReminder1h As Long = 6
Public Const cptsApptReminder2h As Long = 7
Public Const cptsApptReminder3h As Long = 8
Public Const cptsApptReminder4h As Long = 9
Public Const cptsApptReminder5h As Long = 10
Public Const cptsApptReminder6h As Long = 11
Public Const cptsApptReminder7h As Long = 12
Public Const cptsApptReminder8h As Long = 13
Public Const cptsApptReminder9h As Long = 14
Public Const cptsApptReminder10h As Long = 15
Public Const cptsApptReminder11h As Long = 16
Public Const cptsApptReminder12h As Long = 17
Public Const cptsApptReminder18h As Long = 18
Public Const cptsApptReminder1d As Long = 19
Public Const cptsApptReminder2d As Long = 20
Public Const cptsApptReminder3d As Long = 21
Public Const cptsApptReminder4d As Long = 22
Public Const cptsApptReminder1w As Long = 23
Public Const cptsApptReminder2w As Long = 24

'-----enum Recur constants
Public Const cptsApptRecurWeek As Long = 1
Public Const cptsApptRecurMonth As Long = 2
Public Const cptsApptRecurYear As Long = 3