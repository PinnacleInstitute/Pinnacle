Attribute VB_Name = "CContestMod"
Option Explicit
'-----constants
Private Const cModName As String = "CContestMod"

'-----enum item type constants
Public Const cptsContestEnumFindType As Long = 1
Public Const cptsContestEnumStatus As Long = 12607
Public Const cptsContestEnumMetric As Long = 12608

'-----enum FindType constants
Public Const cptsContestFindStartDate As Long = 12609
Public Const cptsContestFindContestName As Long = 12605

'-----enum Status constants
Public Const cptsContestStatusPending As Long = 1
Public Const cptsContestStatusOpen As Long = 2
Public Const cptsContestStatusClosed As Long = 3
Public Const cptsContestStatusLocked As Long = 4

'-----enum Metric constants
Public Const cptsContestMetricResult As Long = 1
Public Const cptsContestMetricActivity As Long = 2
Public Const cptsContestMetricResultActivity As Long = 3
Public Const cptsContestMetricCustom As Long = 0