Attribute VB_Name = "CCalendarMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCalendarMod"

'-----enum item type constants
Public Const cptsCalendarEnumLayout As Long = 4707
Public Const cptsCalendarEnumTimezone As Long = 4722

'-----enum Layout constants
Public Const cptsCalendarLayoutDay As Long = 1
Public Const cptsCalendarLayoutWeek As Long = 2
Public Const cptsCalendarLayoutMonth As Long = 3
Public Const cptsCalendarLayoutList As Long = 4

'-----enum Timezone constants
Public Const cptsCalendarTimezoneGMTm4 As Long = -4
Public Const cptsCalendarTimezoneGMTm5 As Long = -5
Public Const cptsCalendarTimezoneGMTm6 As Long = -6
Public Const cptsCalendarTimezoneGMTm7 As Long = -7
Public Const cptsCalendarTimezoneGMTm8 As Long = -8
Public Const cptsCalendarTimezoneGMTm9 As Long = -9
Public Const cptsCalendarTimezoneGMTm10 As Long = -10