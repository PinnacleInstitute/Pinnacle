Attribute VB_Name = "CEventMod"
Option Explicit
'-----constants
Private Const cModName As String = "CEventMod"

'-----enum item type constants
Public Const cptsEventEnumEventType As Long = 9612
Public Const cptsEventEnumRecur As Long = 9615

'-----enum EventType constants
Public Const cptsEventEventTypeBirthday As Long = 1
Public Const cptsEventEventTypeAnniversary As Long = 2
Public Const cptsEventEventTypeCheckup As Long = 3
Public Const cptsEventEventTypeParty As Long = 4
Public Const cptsEventEventTypeReunion As Long = 5

'-----enum Recur constants
Public Const cptsEventRecurYear As Long = 1
Public Const cptsEventRecurMonth As Long = 2
Public Const cptsEventRecurQuarter As Long = 3
Public Const cptsEventRecurSemiAnnual As Long = 4