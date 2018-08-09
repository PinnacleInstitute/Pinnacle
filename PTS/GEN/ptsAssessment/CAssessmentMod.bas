Attribute VB_Name = "CAssessmentMod"
Option Explicit
'-----constants
Private Const cModName As String = "CAssessmentMod"

'-----enum item type constants
Public Const cptsAssessmentEnumFindType As Long = 1
Public Const cptsAssessmentEnumStatus As Long = 3110
Public Const cptsAssessmentEnumAssessmentType As Long = 3111
Public Const cptsAssessmentEnumResultType As Long = 3115
Public Const cptsAssessmentEnumAssessType As Long = 3123
Public Const cptsAssessmentEnumAssessLevel As Long = 3124

'-----enum FindType constants
Public Const cptsAssessmentFindAssessmentName As Long = 3105
Public Const cptsAssessmentFindStatus As Long = 3110

'-----enum Status constants
Public Const cptsAssessmentStatusSetup As Long = 1
Public Const cptsAssessmentStatusActive As Long = 2
Public Const cptsAssessmentStatusInactive As Long = 3

'-----enum AssessmentType constants
Public Const cptsAssessmentAssessmentTypeInternal As Long = 1
Public Const cptsAssessmentAssessmentTypeExternal As Long = 2
Public Const cptsAssessmentAssessmentTypeMaster As Long = 3
Public Const cptsAssessmentAssessmentTypeProgram As Long = 4

'-----enum ResultType constants
Public Const cptsAssessmentResultTypeSum As Long = 1
Public Const cptsAssessmentResultTypeCustom As Long = 2
Public Const cptsAssessmentResultTypeDecision As Long = 3
Public Const cptsAssessmentResultTypeSelf As Long = 4

'-----enum AssessType constants
Public Const cptsAssessmentAssessTypePersonal As Long = 1
Public Const cptsAssessmentAssessTypeAcademic As Long = 2
Public Const cptsAssessmentAssessTypeProfessional As Long = 3
Public Const cptsAssessmentAssessTypeTechnical As Long = 4

'-----enum AssessLevel constants
Public Const cptsAssessmentAssessLevelBeginner As Long = 1
Public Const cptsAssessmentAssessLevelIntermediate As Long = 2
Public Const cptsAssessmentAssessLevelAdvanced As Long = 3
Public Const cptsAssessmentAssessLevelExpert As Long = 4