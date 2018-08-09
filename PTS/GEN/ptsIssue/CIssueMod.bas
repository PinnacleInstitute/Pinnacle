Attribute VB_Name = "CIssueMod"
Option Explicit
'-----constants
Private Const cModName As String = "CIssueMod"

'-----enum item type constants
Public Const cptsIssueEnumFindType As Long = 1
Public Const cptsIssueEnumPriority As Long = 9514
Public Const cptsIssueEnumStatus As Long = 9517

'-----enum FindType constants
Public Const cptsIssueFindIssueCategoryName As Long = 9505
Public Const cptsIssueFindIssueName As Long = 9511
Public Const cptsIssueFindIssueID As Long = 9501
Public Const cptsIssueFindSubmittedBy As Long = 9512
Public Const cptsIssueFindAssignedTo As Long = 9516
Public Const cptsIssueFindOutsource As Long = 9525
Public Const cptsIssueFindIssueDate As Long = 9510
Public Const cptsIssueFindDueDate As Long = 9520
Public Const cptsIssueFindDoneDate As Long = 9521
Public Const cptsIssueFindPriority As Long = 9514

'-----enum Priority constants
Public Const cptsIssuePriorityHigh As Long = 1
Public Const cptsIssuePriorityMedium As Long = 2
Public Const cptsIssuePriorityLow As Long = 3

'-----enum Status constants
Public Const cptsIssueStatusSubmitted As Long = 1
Public Const cptsIssueStatusAssigned As Long = 2
Public Const cptsIssueStatusInProcess As Long = 3
Public Const cptsIssueStatusResolved As Long = 4
Public Const cptsIssueStatusPostponed As Long = 5
Public Const cptsIssueStatusTested As Long = 6
Public Const cptsIssueStatusDeployed As Long = 7