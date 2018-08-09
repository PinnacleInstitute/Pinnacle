Attribute VB_Name = "CAssessQuestionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAssessQuestionMod"

'-----enum item type constants
Public Const cptsAssessQuestionEnumQuestionType As Long = 3208
Public Const cptsAssessQuestionEnumResultType As Long = 3211
Public Const cptsAssessQuestionEnumNextType As Long = 3214
Public Const cptsAssessQuestionEnumMediaType As Long = 3219
Public Const cptsAssessQuestionEnumStatus As Long = 3222

'-----enum QuestionType constants
Public Const cptsAssessQuestionQuestionTypePriority As Long = 1
Public Const cptsAssessQuestionQuestionTypeRank As Long = 2
Public Const cptsAssessQuestionQuestionTypeChoice As Long = 3
Public Const cptsAssessQuestionQuestionTypeResult As Long = 4
Public Const cptsAssessQuestionQuestionTypeInfo As Long = 5

'-----enum ResultType constants
Public Const cptsAssessQuestionResultTypeMatch As Long = 1

'-----enum NextType constants
Public Const cptsAssessQuestionNextTypespecified As Long = 1
Public Const cptsAssessQuestionNextTypemost As Long = 2
Public Const cptsAssessQuestionNextTypeleast As Long = 3
Public Const cptsAssessQuestionNextTypesum As Long = 4
Public Const cptsAssessQuestionNextTypechoice As Long = 5
Public Const cptsAssessQuestionNextTypecustom As Long = 6

'-----enum MediaType constants
Public Const cptsAssessQuestionMediaTypeImage As Long = 1
Public Const cptsAssessQuestionMediaTypeVideo As Long = 2
Public Const cptsAssessQuestionMediaTypeAudio As Long = 3

'-----enum Status constants
Public Const cptsAssessQuestionStatusActive As Long = 1
Public Const cptsAssessQuestionStatusInactive As Long = 2