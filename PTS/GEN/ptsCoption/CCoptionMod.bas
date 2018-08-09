Attribute VB_Name = "CCoptionMod"
Option Explicit
'-----constants
Private Const cModName As String = "CCoptionMod"

'-----enum item type constants
Public Const cptsCoptionEnumBilling As Long = 4920
Public Const cptsCoptionEnumQuizLimit As Long = 4924
Public Const cptsCoptionEnumProjectsDefault As Long = 4940

'-----enum Billing constants
Public Const cptsCoptionBillingBillNone As Long = 1
Public Const cptsCoptionBillingBillCompany As Long = 2
Public Const cptsCoptionBillingBillMember As Long = 3
Public Const cptsCoptionBillingBillManual As Long = 5

'-----enum QuizLimit constants
Public Const cptsCoptionQuizLimitNoRetake As Long = 1
Public Const cptsCoptionQuizLimitNoAnswer As Long = 2

'-----enum ProjectsDefault constants
Public Const cptsCoptionProjectsDefaultpNone As Long = 1
Public Const cptsCoptionProjectsDefaultpAssign As Long = 2
Public Const cptsCoptionProjectsDefaultpSecure As Long = 3