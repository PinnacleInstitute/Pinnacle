Attribute VB_Name = "CSurveyMod"
Option Explicit
'-----constants
Private Const cModName As String = "CSurveyMod"

'-----enum item type constants
Public Const cptsSurveyEnumFindType As Long = 1
Public Const cptsSurveyEnumStatus As Long = 4007

'-----enum FindType constants
Public Const cptsSurveyFindSurveyName As Long = 4005
Public Const cptsSurveyFindSurveyID As Long = 4001
Public Const cptsSurveyFindStatus As Long = 4007

'-----enum Status constants
Public Const cptsSurveyStatusActive As Long = 1
Public Const cptsSurveyStatusInactive As Long = 2
Public Const cptsSurveyStatusCalced As Long = 3