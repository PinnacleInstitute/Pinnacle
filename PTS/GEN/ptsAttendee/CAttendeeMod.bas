Attribute VB_Name = "CAttendeeMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAttendeeMod"

'-----enum item type constants
Public Const cptsAttendeeEnumFindType As Long = 1
Public Const cptsAttendeeEnumStatus As Long = 18019

'-----enum FindType constants
Public Const cptsAttendeeFindNameLast As Long = 18011
Public Const cptsAttendeeFindNameFirst As Long = 18010
Public Const cptsAttendeeFindEmail As Long = 18012
Public Const cptsAttendeeFindPhone As Long = 18013
Public Const cptsAttendeeFindMeetingID As Long = 18003

'-----enum Status constants
Public Const cptsAttendeeStatusAttend As Long = 1
Public Const cptsAttendeeStatusInterested As Long = 2
Public Const cptsAttendeeStatusCancelled As Long = 3