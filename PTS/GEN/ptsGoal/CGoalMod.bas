Attribute VB_Name = "CGoalMod"
Option Explicit
'-----constants
Private Const cModName As String = "CGoalMod"

'-----enum item type constants
Public Const cptsGoalEnumFindType As Long = 1
Public Const cptsGoalEnumGoalType As Long = 7017
Public Const cptsGoalEnumPriority As Long = 7018
Public Const cptsGoalEnumStatus As Long = 7019

'-----enum FindType constants
Public Const cptsGoalFindGoalName As Long = 7015
Public Const cptsGoalFindDescription As Long = 7016
Public Const cptsGoalFindGoalID As Long = 7001
Public Const cptsGoalFindGoalType As Long = 7017
Public Const cptsGoalFindPriority As Long = 7018

'-----enum GoalType constants
Public Const cptsGoalGoalTypeCompany As Long = 1
Public Const cptsGoalGoalTypeDepartment As Long = 2
Public Const cptsGoalGoalTypeIndividual As Long = 3

'-----enum Priority constants
Public Const cptsGoalPriorityHigh As Long = 1
Public Const cptsGoalPriorityMedium As Long = 2
Public Const cptsGoalPriorityLow As Long = 3

'-----enum Status constants
Public Const cptsGoalStatusDeclared As Long = 1
Public Const cptsGoalStatusCommitted As Long = 2
Public Const cptsGoalStatusCompleted As Long = 3
Public Const cptsGoalStatusCancelled As Long = 4